class FilterOption {
  final String name;

  const FilterOption({required this.name});
}

const List<FilterOption> filterOptions = [
  FilterOption(name: 'Category'),
  FilterOption(name: 'Brand'),
  FilterOption(name: 'Product Rating'),
  FilterOption(name: 'Size'),
  FilterOption(name: 'Color'),
];
