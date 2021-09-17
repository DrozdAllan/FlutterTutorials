import 'package:hive/hive.dart';

part 'duck.g.dart';

@HiveType(typeId: 0)
class Duck {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isExtinct;

  Duck(this.id, this.name, this.isExtinct);
}
