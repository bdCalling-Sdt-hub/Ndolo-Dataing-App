import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import '../models/ideal_match_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class IdealMatchController extends GetxController {
  //==========================> Get All Ideal Match Method <============================
  RxList<IdealMatchModel> idealMatchModel = <IdealMatchModel>[].obs;
  RxString selectedOption = ''.obs;
  var idealMatchLoading = false.obs;
  getAllIdealMatch() async {
    idealMatchLoading(true);
    var response = await ApiClient.getData(ApiConstants.idealMatchesEndPoint);
    if (response.statusCode == 200) {
      idealMatchModel.value = List<IdealMatchModel>.from(response.body['data']['attributes']['results']
          .map((x) => IdealMatchModel.fromJson(x)));
      idealMatchModel.refresh();
      idealMatchLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      idealMatchLoading(false);
      update();
    }
  }

  Future<void> markAsCompleteProfile() async {

    Map<String, bool> body ={
     'isProfileCompleted': true,
    };

    var response = await ApiClient.patchData(ApiConstants.updateProfileEndPoint, jsonEncode(body) );
    if(response.statusCode == 200 || response.statusCode == 201){
      Get.offAllNamed(AppRoutes.homeScreen);
      postMatchLoading(false);
    } else{
      ApiChecker.checkApi(response);
      postMatchLoading(false);
    }

  }

//==========================> Post Ideal Match Method <============================
  var postMatchLoading = false.obs;
  postIdealMatch(String idealMatch) async {
    postMatchLoading(true);
    var selectedRole = idealMatchModel.firstWhere((role) => role.title == selectedOption.value,
        orElse: () => IdealMatchModel());
    Map<String, String> body = {
      "idealMatch": selectedRole.id ?? "",
    };
    Response response =
    await ApiClient.postData(ApiConstants.userMatchingEndPoint, body);
    if (response.statusCode == 200) {
      markAsCompleteProfile();
      update();
    } else {
      ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    postMatchLoading(false);
  }
}
