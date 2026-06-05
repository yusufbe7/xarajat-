class AppConstants {
  static const appName = 'Xarajat';
  static const currencySymbol = "so'm";
  static const currencyCode = 'UZS';

  // O'zbek tilidagi kategoriyalar
  static const List<CategoryModel> expenseCategories = [
    CategoryModel(id: 'food', name: 'Oziq-ovqat', emoji: '🛒', colorHex: 0xFFFF6B6B),
    CategoryModel(id: 'transport', name: 'Transport', emoji: '🚌', colorHex: 0xFF4ECDC4),
    CategoryModel(id: 'utility', name: 'Kommunal', emoji: '💡', colorHex: 0xFFFFE66D),
    CategoryModel(id: 'health', name: 'Salomatlik', emoji: '💊', colorHex: 0xFF95E1D3),
    CategoryModel(id: 'education', name: "Ta'lim", emoji: '📚', colorHex: 0xFFA8E6CF),
    CategoryModel(id: 'clothing', name: 'Kiyim-kechak', emoji: '👗', colorHex: 0xFFDDA0DD),
    CategoryModel(id: 'entertainment', name: 'Ko\'ngil ochar', emoji: '🎮', colorHex: 0xFFFFB347),
    CategoryModel(id: 'cafe', name: 'Kafe va restoran', emoji: '☕', colorHex: 0xFFD4A574),
    CategoryModel(id: 'mobile', name: 'Telefon/Internet', emoji: '📱', colorHex: 0xFF74B9FF),
    CategoryModel(id: 'family', name: 'Oila', emoji: '👨‍👩‍👧', colorHex: 0xFFFF7675),
    CategoryModel(id: 'other', name: 'Boshqa', emoji: '📦', colorHex: 0xFFB2BEC3),
  ];

  static const List<CategoryModel> incomeCategories = [
    CategoryModel(id: 'salary', name: 'Maosh', emoji: '💼', colorHex: 0xFF27AE60),
    CategoryModel(id: 'freelance', name: 'Freelance', emoji: '💻', colorHex: 0xFF2980B9),
    CategoryModel(id: 'business', name: 'Biznes', emoji: '🏪', colorHex: 0xFF8E44AD),
    CategoryModel(id: 'gift', name: "Sovg'a", emoji: '🎁', colorHex: 0xFFE84393),
    CategoryModel(id: 'other_income', name: 'Boshqa', emoji: '💰', colorHex: 0xFFF39C12),
  ];

  // O'zbek oylar nomi
  static const List<String> months = [
    'Yanvar', 'Fevral', 'Mart', 'Aprel', 'May', 'Iyun',
    'Iyul', 'Avgust', 'Sentabr', 'Oktabr', 'Noyabr', 'Dekabr'
  ];

  static const List<String> weekdays = [
    'Du', 'Se', 'Cho', 'Pa', 'Ju', 'Sha', 'Ya'
  ];
}

class CategoryModel {
  final String id;
  final String name;
  final String emoji;
  final int colorHex;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.colorHex,
  });
}
