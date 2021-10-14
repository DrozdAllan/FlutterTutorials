import 'package:hive/hive.dart';
import 'package:mynewapp/models/duck.dart';
import 'package:path_provider/path_provider.dart';

class DuckBox {
  static Box? box;

  static final List<Duck> ducks = [
    Duck('Kilamore', true),
    Duck('Kalimero', false),
    Duck('Kalemori', false),
    Duck('Kelomira', true),
  ];

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(DuckAdapter());

    box = await Hive.openBox('DuckBox');

    // box?.clear();
    // verify the state of the box on the app
    var values = box?.values;
    if (values == null || values.isEmpty) {
      // populate the box if it's the first time the app is built
      box?.addAll(ducks);
    }
  }
}
