class WeatherModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  WeatherModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
