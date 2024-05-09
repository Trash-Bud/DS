class PaginationInfo {
  int offset;
  int limit;
  late int total;

  Function(int, int)? fetchFunction;

  PaginationInfo(
      {this.offset = 0, this.limit = 5, required this.fetchFunction});

  PaginationInfo.second(
      {this.offset = 0, this.limit = 5, required this.total, required this.fetchFunction});

  cycleOffset() {
    if (offset + limit >= total) offset = 0;
  }

  int getCurrentPage() {
    return (offset / limit).floor() + 1;
  }

  int getTotalPages() {
    return (total / limit).ceil();
  }

  Future<void> fetchPage(int page) async {
    offset = (page - 1) * limit;
    fetchFunction!(offset, limit);
  }

  @override
  String toString() {
    return 'PaginationInfo{offset: $offset, limit: $limit, total: $total, fetchFunction: $fetchFunction}';
  }

  String getPageInfo() {
    return "Page ${offset ~/ limit + 1}"
        " of ${total ~/ limit + 1}";
  }
}
