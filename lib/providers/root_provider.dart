import 'package:myexpenses/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'config_provider.dart';
import 'expense_provider.dart';
import 'user_provider.dart';

class RootProvider {
  static List<SingleChildWidget> providers() {
    return [
      Provider(create: (_) => UserService()),
      ChangeNotifierProvider(create: (context) => UserProvider(userService: context.read())),
      ChangeNotifierProvider(
        create: (context) => ExpenseProvider(userService: context.read(), expenses: []),
      ),
      ChangeNotifierProvider(create: (_) => ConfigProvider()),
    ];
  }
}
