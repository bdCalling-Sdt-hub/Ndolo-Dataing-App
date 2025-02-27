import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/prefs_helpers.dart';
import '../../helpers/route.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../service/socket_services.dart';
import '../../utils/app_constants.dart';
import '../../models/message_model.dart';
import '../../models/conversation_model.dart';

class MessageController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isActive = false.obs;
  RxBool seenMessage = false.obs;
  RxList<MessageModel> messageModel = <MessageModel>[].obs;
  RxBool inboxFirstLoading = false.obs;
  RxBool sentMessageLoading = false.obs;
  var inboxPage = 1;
  var inboxTotalPages = 0;
  var inboxCurrentPage = 0;
  RxBool conversationLoading = false.obs;
  RxList<ConversationModel> conversationModel = <ConversationModel>[].obs;
  RxString imagesPath = ''.obs;
  File? selectedImage;
  final TextEditingController sentMsgCtrl = TextEditingController();
  final SocketServices _socket = SocketServices();
  @override
  void onInit() {
    super.onInit();
    _socket.init();
  }

  //===================================> GET CONVERSATIONS <===================================
  Future<void> getConversation() async {
    conversationLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllConversationEndPoint);
    if (response.statusCode == 200) {
      var data = response.body["data"]['attributes'];
      conversationModel.value = List<ConversationModel>.from(
          data.map((x) => ConversationModel.fromJson(x)));
    } else {
      ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg: '${response.statusText}');
    }
    conversationLoading(false);
  }

  //===================================> CREATE A NEW CONVERSATION <===================================
   createConversation(String conversationId) async {
    var response = await ApiClient.postData(
      ApiConstants.createConversationEndPoint(conversationId),
      {"receiver": conversationId},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var currentUserID = await PrefsHelper.getString(AppConstants.userId);
      var data = response.body['data']['attributes'];
      Get.toNamed(AppRoutes.messageScreen, parameters: {
        'conversationId': data['id'],
        'currentUserId': currentUserID,
        'currentUserImage': currentUserID == data['sender'] ? data['sender']['profileImage'] : data['receiver']['profileImage'],
        "receiverName": currentUserID == data['sender'] ? data['receiver']['fullName'] : data['sender']['fullName'],
        "receiverId": currentUserID == data['sender'] ? data['receiver'] : data['sender'],
      });
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //===================================> LOAD MESSAGES FOR CONVERSATION <===================================
  inboxFirstLoad(String conversationId) async {
    inboxFirstLoading(true);
    var response = await ApiClient.getData(
        ApiConstants.getAllSingleMessageEndPoint(conversationId));
    if (response.statusCode == 200) {
      var data = response.body['data']['attributes']['data'];
      messageModel.value =
          List<MessageModel>.from(data.map((x) => MessageModel.fromJson(x)));
    } else {
      ApiChecker.checkApi(response);
    }
    inboxFirstLoading(false);
  }

  //===================================> LISTEN FOR NEW MESSAGES VIA SOCKET <===================================
  listenMessage(String conversationId) {
    SocketServices().socket?.on("new-message::$conversationId", (data) {
      debugPrint("🔵 Live Message Received: $data");
      MessageModel receivedMessage = MessageModel.fromJson(data);
      messageModel.removeWhere((msg) => msg.imageUrl == receivedMessage.imageUrl && msg.id == null);
      messageModel.add(receivedMessage);
      messageModel.refresh();
      messageModel.refresh();
      messageModel.refresh();
      update();
      update();
      update();
      //=======================> Auto-scroll to the latest message <==================
      Future.delayed(const Duration(milliseconds: 100));
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        }
    });
  }

  //===================================> SEND A TEXT MESSAGE <===================================
  void sentMessage(String conversationId, String type, String text) async {
    if (text.isEmpty || sentMessageLoading.value) return;
    sentMessageLoading(true);
    update();
    String currentUserID = await PrefsHelper.getString(AppConstants.userId);
    MessageModel newMessage = MessageModel(
      text: text,
      type: type,
      msgByUserId: MsgByUserId(id: currentUserID),
      createdAt: DateTime.now(),
    );
    messageModel.add(newMessage);
    messageModel.refresh();
    update();
    try {
      if (_socket != null) {
        _socket.emit("send-message", {
          "conversationId": conversationId,
          "type": type,
          "text": text,
        });
      } else {
        Fluttertoast.showToast(msg: "WebSocket not connected!");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Socket Error: ${e.toString()}");
      sentMessageLoading(false);
      return;
    }
    try {
      var response = await ApiClient.postData(ApiConstants.sentMessageEndPoint, {
        "conversationId": conversationId,
        "type": type,
        "text": text,
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        Fluttertoast.showToast(msg: "Failed to save message in database!");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "API Error: ${e.toString()}");
    }
    sentMessageLoading(false);
    update();
    Future.delayed(const Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }


  //===================================> SEND AN IMAGE MESSAGE <===================================
  Future<void> sentImage(String conversationId, String type) async {
    if (imagesPath.value.isEmpty) {
      Fluttertoast.showToast(msg: "No image selected!");
      return;
    }
    sentMessageLoading(true);
    Map<String, String> body = {
      "conversationId": conversationId,
      "type": type,
    };

    List<MultipartBody> multipartList = [
      MultipartBody("image", File(imagesPath.value))
    ];
    SocketServices().emit("send-message", {
      "conversationId": conversationId,
      "type": type,
      "imageUrl": imagesPath.value,
    });
    messageModel.add(MessageModel(
      type: type,
      msgByUserId: MsgByUserId(id: await PrefsHelper.getString(AppConstants.userId)),
      imageUrl: imagesPath.value,
      createdAt: DateTime.now(),
    ));
    messageModel.refresh();
    update();
    var response = await ApiClient.postMultipartData(
      ApiConstants.sentMessageEndPoint,
      body,
      multipartBody: multipartList,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      imagesPath.value = '';
      listenMessage(conversationId);
      sentMessageLoading(false);
      update();
    } else {
      sentMessageLoading(false);
      Fluttertoast.showToast(msg: "Failed to send image!");
      update();
    }
  }

  //=================================> PICK IMAGE FROM GALLERY <===================================
  Future<void> pickImages(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    imagesPath.value = returnImage.path;
    update();
  }
}
