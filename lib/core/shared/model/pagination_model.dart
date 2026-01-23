class PaginationModel {
  int? page;
  int? perPage;
  int? lastPage;
  int? total;
  int? firstItem;
  int? lastItem;

  PaginationModel({
    this.page,
    this.perPage,
    this.lastPage,
    this.total,
    this.firstItem,
    this.lastItem,
  });

  PaginationModel copyWith({
    int? page,
    int? perPage,
    int? lastPage,
    int? total,
    int? firstItem,
    int? lastItem,
  }) =>
      PaginationModel(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        lastPage: lastPage ?? this.lastPage,
        total: total ?? this.total,
        firstItem: firstItem ?? this.firstItem,
        lastItem: lastItem ?? this.lastItem,
      );

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
        page: json["page"],
        perPage: json["per_page"],
        lastPage: json["last_page"],
        total: json["total"],
        firstItem: json["first_item"],
        lastItem: json["last_item"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "last_page": lastPage,
        "total": total,
        "first_item": firstItem,
        "last_item": lastItem,
      };
}
