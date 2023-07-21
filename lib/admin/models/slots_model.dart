class SlotsModel {
  final String slotVenue;
  final String slotName;
  final String slotPrice;
  final int slotCapacity;
  final String slotStartTime;
  final String slotEndTime;

  const SlotsModel({
    required this.slotVenue,
    required this.slotName,
    required this.slotPrice,
    required this.slotCapacity,
    required this.slotStartTime,
    required this.slotEndTime,
  });

  // converts json to object
  factory SlotsModel.fromJson(Map json) {
    return SlotsModel(
      slotVenue: json['slotVenue'],
      slotName: json['slotName'],
      slotPrice: json['slotPrice'],
      slotCapacity: json['slotCapacity'],
      slotStartTime: json['slotStartTime'],
      slotEndTime: json['slotEndTime'],
    );
  }

  // converts object to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slotName'] = slotName;
    data['slotPrice'] = slotPrice;
    data['slotCapacity'] = slotCapacity;
    data['slotStartTime'] = slotStartTime;
    data['slotEndTime'] = slotEndTime;
    return data;
  }
}
