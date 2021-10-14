import 'package:hive/hive.dart';

part 'duck.g.dart';

// Extending HiveObject give auto-increment index key, you only worry about the value
@HiveType(typeId: 0)
class Duck extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isExtinct;

  Duck(this.name, this.isExtinct);
}
