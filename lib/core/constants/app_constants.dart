class AppConstants {
  static const appName = 'Xarajat';
  static const currencySymbol = "so'm";
  static const currencyCode = 'UZS';

  // O'zbek tilidagi kategoriyalar (ru tarjimalari bilan)
  static const List<CategoryModel> expenseCategories = [
    CategoryModel(id: 'food', name: 'Oziq-ovqat', nameRu: 'Продукты', emoji: '🛒', colorHex: 0xFFFF6B6B),
    CategoryModel(id: 'transport', name: 'Transport', nameRu: 'Транспорт', emoji: '🚌', colorHex: 0xFF4ECDC4),
    CategoryModel(id: 'utility', name: 'Kommunal', nameRu: 'Коммуналка', emoji: '💡', colorHex: 0xFFFFE66D),
    CategoryModel(id: 'health', name: 'Salomatlik', nameRu: 'Здоровье', emoji: '💊', colorHex: 0xFF95E1D3),
    CategoryModel(id: 'education', name: "Ta'lim", nameRu: 'Образование', emoji: '📚', colorHex: 0xFFA8E6CF),
    CategoryModel(id: 'clothing', name: 'Kiyim-kechak', nameRu: 'Одежда', emoji: '👗', colorHex: 0xFFDDA0DD),
    CategoryModel(id: 'entertainment', name: 'Ko\'ngil ochar', nameRu: 'Развлечения', emoji: '🎮', colorHex: 0xFFFFB347),
    CategoryModel(id: 'cafe', name: 'Kafe va restoran', nameRu: 'Кафе и рестораны', emoji: '☕', colorHex: 0xFFD4A574),
    CategoryModel(id: 'mobile', name: 'Telefon/Internet', nameRu: 'Связь/Интернет', emoji: '📱', colorHex: 0xFF74B9FF),
    CategoryModel(id: 'family', name: 'Oila', nameRu: 'Семья', emoji: '👨‍👩‍👧', colorHex: 0xFFFF7675),
    CategoryModel(id: 'other', name: 'Boshqa', nameRu: 'Другое', emoji: '📦', colorHex: 0xFFB2BEC3),
  ];

  static const List<CategoryModel> incomeCategories = [
    CategoryModel(id: 'salary', name: 'Maosh', nameRu: 'Зарплата', emoji: '💼', colorHex: 0xFF27AE60),
    CategoryModel(id: 'freelance', name: 'Freelance', nameRu: 'Фриланс', emoji: '💻', colorHex: 0xFF2980B9),
    CategoryModel(id: 'business', name: 'Biznes', nameRu: 'Бизнес', emoji: '🏪', colorHex: 0xFF8E44AD),
    CategoryModel(id: 'gift', name: "Sovg'a", nameRu: 'Подарок', emoji: '🎁', colorHex: 0xFFE84393),
    CategoryModel(id: 'other_income', name: 'Boshqa', nameRu: 'Другое', emoji: '💰', colorHex: 0xFFF39C12),
  ];

  // Oylar nomi
  static const List<String> months = [
    'Yanvar', 'Fevral', 'Mart', 'Aprel', 'May', 'Iyun',
    'Iyul', 'Avgust', 'Sentabr', 'Oktabr', 'Noyabr', 'Dekabr'
  ];

  static const List<String> monthsRu = [
    'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
    'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
  ];

  // Qisqa oy nomlari (grafiklar uchun)
  static const List<String> monthsShort = [
    'Yan', 'Fev', 'Mar', 'Apr', 'May', 'Iyn',
    'Iyl', 'Avg', 'Sen', 'Okt', 'Noy', 'Dek'
  ];

  static const List<String> monthsShortRu = [
    'Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн',
    'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'
  ];

  static const List<String> weekdays = [
    'Du', 'Se', 'Cho', 'Pa', 'Ju', 'Sha', 'Ya'
  ];

  static const List<String> weekdaysRu = [
    'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'
  ];

  /// Til kodiga qarab oy nomini qaytaradi (1-12).
  static String monthName(int month, String lang) {
    final list = lang == 'ru' ? monthsRu : months;
    return list[(month - 1) % 12];
  }

  static String monthShort(int month, String lang) {
    final list = lang == 'ru' ? monthsShortRu : monthsShort;
    return list[(month - 1) % 12];
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String nameRu;
  final String emoji;
  final int colorHex;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.nameRu,
    required this.emoji,
    required this.colorHex,
  });

  /// Til kodiga qarab kategoriya nomini qaytaradi.
  String localizedName(String lang) => lang == 'ru' ? nameRu : name;
}
