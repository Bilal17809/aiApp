class FactModel {
  final int id;
  final String category;
  final String fact;

  FactModel({required this.id, required this.category, required this.fact});

  factory FactModel.fromJson(Map<String, dynamic> json) {
    return FactModel(
      id: json['id'],
      category: json['category'],
      fact: json['fact'],
    );
  }
}
