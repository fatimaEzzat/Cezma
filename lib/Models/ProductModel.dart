class ProductModel {
  late int currentPage;
  late List data;
  late String nextPageUrl;
  late String path;
  late int perPage;
  late String? prevPageUrl;
  late int to;
  late double total;
  late String firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  late List links;
  ProductModel(
      {required this.currentPage,
      required this.data,
      required this.nextPageUrl,
      required this.path,
      required this.perPage,
      required this.prevPageUrl,
      required this.to,
      required this.total,
      required this.firstPageUrl,
      required this.from,
      required this.lastPage,
      required this.lastPageUrl,
      required this.links});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        currentPage: json["current_page"] as int,
        data: json["data"] as List,
        nextPageUrl: json["next_page_url"] ?? "",
        path: json["path"] as String,
        perPage: json["per_page"] as int,
        prevPageUrl: json["prev_page_url"] as String?,
        to: json["to"] as int,
        total: json["total"] as double,
        firstPageUrl: json["first_page_url"] as String,
        from: json["from"] as int,
        lastPage: json["last_page"] as int,
        lastPageUrl: json["last_page_url"] as String,
        links: json["links"] as List);
  }
}
