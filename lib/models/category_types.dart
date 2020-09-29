List<CategoryType> categoryTypes = <CategoryType>[
  CategoryType('Grocery & Staples'),
  CategoryType('Snacks'),
  CategoryType('Breakfast & Dairy'),
  CategoryType('Beverages'),
  CategoryType('Household Care'),
  CategoryType('Personal Care'),
  CategoryType('Packaged Food'),
  CategoryType('Baby Care'),
  CategoryType('Fruit & Vegetables'),
];

class CategoryType {
  final String categoryTitle;
  CategoryType(this.categoryTitle);
}
