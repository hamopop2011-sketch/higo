/// Constants for the application
class AppConstants {
  AppConstants._();

  // Firebase collection names
  static const String usersCollection = 'users';
  static const String chatRoomsCollection = 'chat_rooms';
  static const String messagesCollection = 'messages';

  // Cache keys
  static const String currentUserCacheKey = 'current_user';
  static const String userIdCacheKey = 'user_id';

  // App configuration
  static const int messageCacheLimit = 50;
  static const int chatRoomsCacheLimit = 20;
  static const Duration cacheExpiration = Duration(hours: 24);

  // Error messages in Arabic
  static const String errorGeneric = 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
  static const String errorNetwork = 'فشل الاتصال بالشبكة. تحقق من اتصالك بالإنترنت.';
  static const String errorFirebaseInit = 'فشل في تهيئة Firebase.';
  static const String errorAuth = 'فشل في المصادقة. يرجى التحقق من بياناتك.';
  static const String errorEmailInUse = 'البريد الإلكتروني مستخدم بالفعل.';
  static const String errorInvalidEmail = 'البريد الإلكتروني غير صالح.';
  static const String errorWeakPassword = 'كلمة المرور ضعيفة جداً.';
  static const String errorWrongPassword = 'كلمة المرور غير صحيحة.';
  static const String errorUserNotFound = 'المستخدم غير موجود.';
  static const String errorUserDisabled = 'تم تعطيل حساب المستخدم.';
  static const String errorTooManyRequests = 'عدد كبير جداً من المحاولات. حاول مرة أخرى لاحقاً.';
  static const String errorOperationNotAllowed = 'العملية غير مسموح بها.';
  static const String errorSignOut = 'فشل في تسجيل الخروج.';
  
  // Firestore error messages
  static const String errorFetchData = 'فشل في جلب البيانات.';
  static const String errorSaveData = 'فشل في حفظ البيانات.';
  static const String errorDeleteData = 'فشل في حذف البيانات.';
  static const String errorUpdateData = 'فشل في تحديث البيانات.';
  
  // Cache error messages
  static const String errorCacheSave = 'فشل في حفظ البيانات في الذاكرة المؤقتة.';
  static const String errorCacheLoad = 'فشل في تحميل البيانات من الذاكرة المؤقتة.';
  
  // Success messages in Arabic
  static const String successSignUp = 'تم إنشاء الحساب بنجاح.';
  static const String successSignIn = 'تم تسجيل الدخول بنجاح.';
  static const String successSignOut = 'تم تسجيل الخروج بنجاح.';
  static const String successMessageSent = 'تم إرسال الرسالة بنجاح.';
  
  // UI strings in Arabic
  static const String appName = 'هيجو';
  static const String signUp = 'إنشاء حساب';
  static const String signIn = 'تسجيل الدخول';
  static const String signOut = 'تسجيل الخروج';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String displayName = 'الاسم';
  static const String confirmPassword = 'تأكيد كلمة المرور';
  static const String send = 'إرسال';
  static const String chat = 'الدردشة';
  static const String chats = 'المحادثات';
  static const String typeMessage = 'اكتب رسالة...';
  static const String noMessages = 'لا توجد رسائل بعد';
  static const String noChats = 'لا توجد محادثات بعد';
}
