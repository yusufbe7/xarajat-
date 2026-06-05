# 💰 Xarajat — O'zbek Moliya Yordamchisi

> O'zbeklar uchun, o'zbek tilida. So'mda. Oddiy va tez.

---

## 📱 Ilova haqida

**Xarajat** — shaxsiy moliyangizni kuzatish uchun Flutter ilovasi. MonAi singari, lekin faqat o'zbeklar uchun moslashtirilgan:

- 🇺🇿 Interfeys to'liq o'zbek tilida
- 💵 So'm (UZS) valyutasi
- 📊 Kategoriyalar o'zbek turmushiga mos (bozor, kommunal, ta'lim...)
- 📱 Android va iOS uchun

---

## ✨ Funksiyalar

| Funksiya | Holati |
|----------|--------|
| Kirim/chiqim qo'shish | ✅ |
| Kategoriyalar | ✅ |
| Oylik statistika | ✅ |
| Pie chart tahlil | ✅ |
| Local saqlash (Hive) | ✅ |
| O'zbek tili | ✅ |
| Dark mode | 🔜 |
| Byudjet limiti | 🔜 |
| Payme/Click ulanish | 🔜 |
| Widget (home screen) | 🔜 |

---

## 🚀 Ishga tushirish

```bash
# 1. Reponi klonlash
git clone https://github.com/YOUR_USERNAME/xarajat.git
cd xarajat

# 2. Dependensiyalarni yuklab olish
flutter pub get

# 3. Hive generatorini ishlatish
dart run build_runner build

# 4. Ishga tushirish
flutter run
```

---

## 🗂 Papka strukturasi

```
lib/
├── core/
│   ├── constants/     # Kategoriyalar, konstantalar
│   ├── theme/         # Ranglar, shrift, tema
│   └── utils/         # Formatlash yordamchilari
├── data/
│   ├── models/        # TransactionModel (Hive)
│   └── repositories/  # Ma'lumotlar bazasi
└── presentation/
    ├── screens/
    │   ├── home/           # Asosiy ekran
    │   ├── add_transaction/ # Yangi qo'shish
    │   ├── analytics/      # Grafik tahlil
    │   └── settings/       # Sozlamalar
    └── widgets/            # Qayta ishlatiladigan widgetlar
```

---

## 🛠 Tech Stack

- **Flutter** 3.x
- **Hive** — offline local DB
- **fl_chart** — grafiklar
- **google_fonts** — Nunito shrifti
- **iconsax** — ikonkalar

---

## 📸 Ekran ko'rinishlari

> Tez orada qo'shiladi...

---

## 🤝 Hissa qo'shish

Pull request qabul qilinadi! Issues orqali xato xabar bering.

---

## 📄 Litsenziya

MIT © 2024 — Xarajat
