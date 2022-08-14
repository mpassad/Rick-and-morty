class DataInfo {
  final int? count;
  final int? pages;
  final String? next;
  final String? prev;

  DataInfo({
    required this.count,
    required this.pages,
    this.next = '',
    this.prev = '',
  });

  factory DataInfo.fromDict(Map<dynamic, dynamic> dict) => DataInfo(
        count: dict["count"],
        pages: dict["pages"],
        next: dict["next"],
        prev: dict["prev"],
      );

  Map<dynamic, dynamic> toDict() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}
