# 🔥 البداية السريعة - Firebase Setup

## الملفات المطلوبة من مشروعك الحالي

أنت تحتاج إلى ملفين من مشروع Firebase الخاص بك:

### 1. للـ Android: `google-services.json`

**احصل عليه من:**
1. اذهب إلى [Firebase Console](https://console.firebase.google.com)
2. اختر مشروعك
3. اذهب إلى إعدادات المشروع (⚙️) > عام
4. قسم "تطبيقاتك" > اختر تطبيق Android
5. اضغط على "تنزيل google-services.json"

**ضعه في:**
```
d:\higo\android\app\google-services.json
```

### 2. للـ iOS: `GoogleService-Info.plist`

**احصل عليه من:**
1. نفس الصفحة في Firebase Console
2. اختر تطبيق iOS
3. اضغط على "تنزيل GoogleService-Info.plist"

**ضعه في:**
```
d:\higo\ios\Runner\GoogleService-Info.plist
```

---

## ✅ تم تحديث إعدادات Gradle تلقائياً

تم بالفعل تحديث الملفات التالية:

### `android/build.gradle.kts` ✓
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.5.0")
    }
}
```

### `android/app/build.gradle.kts` ✓
```kotlin
plugins {
    id("com.google.gms.google-services")  // ✓ تمت الإضافة
}

android {
    defaultConfig {
        minSdk = 23  // ✓ Firebase يحتاج 23+
        multiDexEnabled = true  // ✓ مطلوب لـ Firebase
    }
}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.19.0"))
    
    // Firebase Services
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-analytics")
    
    // MultiDex
    implementation("androidx.multidex:multidex:2.0.1")
}
```

---

## 🚀 الخطوات التالية

1. **انسخ الملفين من Firebase Console**
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

2. **فعّل Authentication في Firebase Console**
   - Authentication > Sign-in method > Email/Password

3. **أنشئ Firestore Database**
   - Firestore Database > Create Database
   - اختر Test Mode للتطوير

4. **شغّل التطبيق**
   ```bash
   flutter pub get
   flutter run
   ```

---

## 📱 قواعد Firestore للتطوير

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## 🎯 البنية المتوقعة في Firestore

سيتم إنشاء هذه Collections تلقائياً:

```
/users/{userId}
  - email
  - displayName
  - photoUrl
  - createdAt

/chat_rooms/{chatRoomId}
  - participants: [userId1, userId2]
  - lastMessage
  - lastMessageTime
  - unreadCount: {userId1: 0, userId2: 0}
  
  /messages/{messageId}
    - senderId
    - senderName
    - text
    - timestamp
    - read
```

---

## ⚠️ استكشاف الأخطاء الشائعة

**خطأ:** `No Firebase App '[DEFAULT]' has been created`
- **الحل:** تأكد من نسخ `google-services.json` في المكان الصحيح

**خطأ:** `Gradle build failed`
- **الحل:** شغّل `flutter clean` ثم `flutter pub get`

**خطأ:** `Permission denied`
- **الحل:** تحقق من قواعد Firestore Security Rules

---

لمزيد من التفاصيل، راجع `FIREBASE_SETUP.md` 📖
