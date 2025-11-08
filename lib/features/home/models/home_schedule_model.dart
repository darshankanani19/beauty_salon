enum AppointmentStatus { pending, completed }

class HomeScheduleModel {
  final String id;
  final String name;
  final String service;
  final String timeText; // e.g. "10:00 AM"
  final AppointmentStatus status;

  const HomeScheduleModel({
    required this.id,
    required this.name,
    required this.service,
    required this.timeText,
    required this.status,
  });

  factory HomeScheduleModel.fromJson(Map<String, dynamic> json) {
    return HomeScheduleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      service: json['service'] as String,
      timeText: json['timeText'] as String,
      status: (json['status'] as String).toLowerCase() == 'completed'
          ? AppointmentStatus.completed
          : AppointmentStatus.pending,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'service': service,
    'timeText': timeText,
    'status': status.name,
  };
}
