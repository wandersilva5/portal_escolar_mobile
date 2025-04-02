class SliderImage {
  final String id;
  final String institutionId;
  final String imageUrl;
  final String title;
  final String description;
  final int order;
  final bool isActive;
  
  SliderImage({
    required this.id,
    required this.institutionId,
    required this.imageUrl,
    this.title = '',
    this.description = '',
    this.order = 0,
    this.isActive = true,
  });
  
  factory SliderImage.fromJson(Map<String, dynamic> json) {
    return SliderImage(
      id: json['id'],
      institutionId: json['institutionId'],
      imageUrl: json['imageUrl'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institutionId': institutionId,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'order': order,
      'isActive': isActive,
    };
  }
}

