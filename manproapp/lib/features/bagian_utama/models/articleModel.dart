class Article {
  final String title;
  final String date;
  final String image;
  final String content;
  final String isAsset;
  final List<String>? additionalImages;

  Article({
    required this.title,
    required this.date,
    required this.image,
    required this.content,
    required this.isAsset,
    this.additionalImages,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      isAsset: json['isAsset'] ?? 'false',
      additionalImages: json['additionalImages'] != null
          ? List<String>.from(json['additionalImages'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'image': image,
      'content': content,
      'isAsset': isAsset,
      'additionalImages': additionalImages,
    };
  }
}
