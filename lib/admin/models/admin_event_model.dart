class AdminEventModel {
  String? eventName;
  String? shows;
  String? price;
  String? capacity;
  String? startTime;
  String? endTime;
  String? eventUrl;
  AdminEventModel({
    required this.eventName,
    this.shows,
    this.price,
    this.capacity,
    this.startTime,
    this.endTime,
    this.eventUrl,
  });
}
