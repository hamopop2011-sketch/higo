# إعداد Firebase - دليل الإعداد الكامل

هذا الدليل يشرح كيفية إعداد Firebase لتطبيق Higo للدردشة.

## المتطلبات الأساسية

- حساب Google
- Flutter SDK مثبت
- Android Studio أو Xcode (للتطوير على iOS)

## الخطوات التفصيلية

### 1. إنشاء مشروع Firebase

1. اذهب إلى [Firebase Console](https://console.firebase.google.com)
2. اضغط على "إضافة مشروع" (Add Project)
3. أدخل اسم المشروع (مثلاً: "Higo Chat")
4. اختر إعدادات Google Analytics (اختياري)
5. اضغط على "إنشاء المشروع" (Create Project)

### 2. إضافة تطبيق Android

#### 2.1 الحصول على اسم الحزمة (Package Name)

1. افتح ملف `android/app/build.gradle` أو `android/app/build.gradle.kts`
2. ابحث عن `applicationId` أو `namespace`
3. انسخ القيمة (مثلاً: `com.example.higo`)

#### 2.2 تسجيل التطبيق في Firebase

1. في Firebase Console، اضغط على أيقونة Android
2. أدخل اسم الحزمة (Package Name) الذي نسخته
3. أدخل اسم التطبيق (اختياري)
4. اضغط على "تسجيل التطبيق" (Register App)

#### 2.3 تنزيل ملف google-services.json

1. قم بتنزيل ملف `google-services.json`
2. انسخ الملف إلى مجلد `android/app/`
3. تأكد من أن اسم الملف هو `google-services.json` بالضبط

#### 2.4 تحديث ملفات Gradle

الملفات محدثة مسبقاً في المشروع، ولكن تأكد من وجود التالي:

في `android/build.gradle`:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.0'
}
```

في `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```

### 3. إضافة تطبيق iOS (اختياري)

#### 3.1 الحصول على Bundle ID

1. افتح مشروع iOS في Xcode
2. اختر Target "Runner"
3. انسخ "Bundle Identifier" من تبويب "General"

#### 3.2 تسجيل التطبيق في Firebase

1. في Firebase Console، اضغط على أيقونة iOS
2. أدخل Bundle ID الذي نسخته
3. أدخل App nickname (اختياري)
4. اضغط على "تسجيل التطبيق" (Register App)

#### 3.3 تنزيل ملف GoogleService-Info.plist

1. قم بتنزيل ملف `GoogleService-Info.plist`
2. افتح Xcode
3. اسحب الملف وأفلته في مجلد `Runner` في Xcode
4. تأكد من تحديد "Copy items if needed"

### 4. تفعيل خدمات Firebase

#### 4.1 تفعيل Authentication

1. في Firebase Console، اذهب إلى "Authentication"
2. اضغط على "البدء" (Get Started)
3. اذهب إلى تبويب "Sign-in method"
4. فعّل "Email/Password"
5. احفظ التغييرات

#### 4.2 إنشاء قاعدة بيانات Firestore

1. في Firebase Console، اذهب إلى "Firestore Database"
2. اضغط على "إنشاء قاعدة البيانات" (Create Database)
3. اختر موقع البيانات (الأقرب لمستخدميك)
4. اختر وضع البداية:
   - **وضع الاختبار** (Test mode): للتطوير - يسمح بالقراءة والكتابة لمدة 30 يوم
   - **وضع الإنتاج** (Production mode): للإطلاق - يتطلب قواعد أمان

#### 4.3 إعداد قواعد الأمان (Security Rules)

للتطوير، استخدم هذه القواعد:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // السماح بالقراءة والكتابة للمستخدمين المصادق عليهم
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

للإنتاج، استخدم قواعد أكثر تقييداً:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // قواعد مجموعة المستخدمين
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // قواعد مجموعة غرف الدردشة
    match /chat_rooms/{chatRoomId} {
      allow read: if request.auth != null && 
                  request.auth.uid in resource.data.participants;
      allow create: if request.auth != null && 
                    request.auth.uid in request.resource.data.participants;
      allow update: if request.auth != null && 
                    request.auth.uid in resource.data.participants;
      
      // قواعد مجموعة الرسائل الفرعية
      match /messages/{messageId} {
        allow read: if request.auth != null && 
                    request.auth.uid in get(/databases/$(database)/documents/chat_rooms/$(chatRoomId)).data.participants;
        allow create: if request.auth != null && 
                      request.auth.uid == request.resource.data.senderId;
      }
    }
  }
}
```

### 5. إنشاء المجموعات (Collections) في Firestore

سيتم إنشاء المجموعات تلقائياً عند أول استخدام، ولكن يمكنك إنشائها يدوياً:

1. افتح Firestore Database في Firebase Console
2. اضغط على "Start collection"
3. أنشئ المجموعات التالية:
   - `users` - لتخزين بيانات المستخدمين
   - `chat_rooms` - لتخزين غرف الدردشة
   - في كل `chat_room`، أنشئ مجموعة فرعية `messages` - لتخزين الرسائل

### 6. التحقق من التثبيت

بعد إكمال جميع الخطوات:

1. قم بتشغيل الأمر:
```bash
flutter pub get
```

2. تأكد من عدم وجود أخطاء:
```bash
flutter analyze
```

3. قم بتشغيل التطبيق:
```bash
flutter run
```

## هيكل البيانات في Firestore

### مجموعة Users
```json
{
  "id": "user_id",
  "email": "user@example.com",
  "displayName": "اسم المستخدم",
  "photoUrl": "https://...",
  "createdAt": "2024-01-01T00:00:00.000Z"
}
```

### مجموعة Chat Rooms
```json
{
  "id": "userId1_userId2",
  "participants": ["userId1", "userId2"],
  "lastMessage": "آخر رسالة",
  "lastMessageTime": "2024-01-01T00:00:00.000Z",
  "unreadCount": {
    "userId1": 0,
    "userId2": 3
  }
}
```

### مجموعة Messages (فرعية في كل Chat Room)
```json
{
  "id": "message_id",
  "chatRoomId": "userId1_userId2",
  "senderId": "userId1",
  "senderName": "اسم المرسل",
  "text": "نص الرسالة",
  "timestamp": "2024-01-01T00:00:00.000Z",
  "read": false
}
```

## استكشاف الأخطاء

### مشكلة: "FirebaseException: No Firebase App"
**الحل**: تأكد من تنزيل ونسخ ملفات التكوين الصحيحة:
- `google-services.json` في `android/app/`
- `GoogleService-Info.plist` في `ios/Runner/`

### مشكلة: "FirebaseAuthException: [email-already-in-use]"
**الحل**: البريد الإلكتروني مسجل مسبقاً. استخدم بريد إلكتروني آخر أو قم بتسجيل الدخول.

### مشكلة: "FirebaseException: Permission denied"
**الحل**: تحقق من قواعد الأمان في Firestore وتأكد من السماح بالعمليات المطلوبة.

### مشكلة: "Gradle sync failed"
**الحل**: تأكد من:
1. إضافة plugin `com.google.gms.google-services` في `android/app/build.gradle`
2. إضافة classpath في `android/build.gradle`
3. تشغيل `flutter clean` ثم `flutter pub get`

## موارد إضافية

- [وثائق Firebase الرسمية](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)

## الدعم

إذا واجهت أي مشاكل:
1. تحقق من [Firebase Console](https://console.firebase.google.com) للأخطاء
2. راجع [FlutterFire Issues](https://github.com/firebase/flutterfire/issues)
3. تأكد من تحديث جميع الحزم إلى آخر إصدار

---

تم إنشاء هذا الدليل لمشروع Higo - تطبيق الدردشة
