import 'package:hive/hive.dart';

part 'duck.g.dart';

@HiveType(typeId: 0)
class Duck extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isExtinct;

  Duck(this.name, this.isExtinct);
}
