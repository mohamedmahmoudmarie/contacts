# Contacts App — Route Mobile Diploma (Task Three)

## التشغيل (VS Code)

افتح الفولدر في VS Code ونفّذ في الـ Terminal:

```bash
flutter create . --project-name contacts_app   # بيعمل فولدرات android / ios بس، مش هيمسح lib
flutter pub get
flutter run
```

## إعداد image_picker

**Android**: مش محتاج أي إعداد.

**iOS** — في `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Pick a photo for the contact</string>
```

## الـ Lottie

الأنيميشن موجود في `assets/lottie/empty_list.json`. لو عايز أنيميشن تاني من LottieFiles، حط الملف مكانه بنفس الاسم.

## السلوك

- Splash فيها لوجو Route، وبعد ثانيتين بتنقل للـ Home.
- Home فاضية: أنيميشن Lottie وجملة "There is No Contacts Added Here".
- زرار (+) بيفتح Bottom Sheet: اختيار صورة، و3 حقول بتتعرض على الهيدر وانت بتكتب، وزرار "Enter user".
- الحقول عليها Validation (الإطار بيبقى أحمر لو في خطأ).
- الكونتاكتات بتتعرض في Grid من عمودين، وكل كارت فيه زرار Delete.
- زرار الحذف الأحمر بيمسح آخر عنصر، وبيظهر بس لو في عناصر في الليستة.
- زرار (+) بيختفي لما الكونتاكتات توصل 6.

## هيكل المشروع

```
lib/
  core/       app_colors.dart, app_theme.dart (Buttons / TextFields / Text styles)
  models/     contact.dart
  widgets/    contact_card.dart, add_contact_sheet.dart,
              app_text_field.dart, empty_state.dart
  screens/    splash_screen.dart, home_screen.dart
```
