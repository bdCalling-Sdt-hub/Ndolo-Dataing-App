import '../models/language_model.dart';

class AppConstants{

  static String APP_NAME = "Ndolo Dating";
  static String fcmToken = "fcmToken";
  static String receiverId = "receiverId";
  static String conversationID = "conversationID";
  static String userCountry = "userCountry";
  static String userState = "userState";
  static String userCity = "userCity";
  static String userAddress = "userAddress";


  static const String bearerToken = "BearerToken";
  static const String phoneNumber = "PhoneNumber";
  static String isLogged = "IsLogged";
  static String hasUpdateGallery  = "hasUpdateGallery";
  static String userId = "id";
  static String userName = "userName";

  // share preference Key
  static String THEME ="theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );
  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel( languageName: 'French', countryCode: 'FR', languageCode: 'fr'),
  ];
}