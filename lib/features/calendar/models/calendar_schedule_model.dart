class CalendarScheduleModel {
  final String id;
  final String clientName;
  final String service;
  final String staffName;
  final String timeFrom;
  final String timeTo;

  CalendarScheduleModel({
    required this.id,
    required this.clientName,
    required this.service,
    required this.staffName,
    required this.timeFrom,
    required this.timeTo,
  });

  factory CalendarScheduleModel.fromJson(Map<String, dynamic> json) {
    return CalendarScheduleModel(
      id: json['id'] ?? '',
      clientName: json['clientName'] ?? '',
      service: json['service'] ?? '',
      staffName: json['staffName'] ?? '',
      timeFrom: json['timeFrom'] ?? '',
      timeTo: json['timeTo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'service': service,
      'staffName': staffName,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
    };
  }
}
