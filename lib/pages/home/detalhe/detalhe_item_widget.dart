import 'package:flutter/material.dart';
import 'package:myexpenses/providers/config_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/spacer_component.dart';
import '../../../providers/user_provider.dart';

class DetalheItemWidget extends StatelessWidget {
  const DetalheItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: Image.network(
                    userProvider.user?.photoUrl ?? '',
                    fit: BoxFit.cover,
                  ).image,
                ),
              ),
              const SpacerComponent(),
              Text(
                userProvider.user?.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SpacerComponent(),
              const SpacerComponent(isHorizontal: true),
              Consumer<ConfigProvider>(
                builder: (context, storeConfig, _) {
                  return Column(
                    children: [
                      const Text('Tema escuro'),
                      Switch(
                        value: storeConfig.tema == ThemeMode.dark,
                        onChanged: (val) {
                          storeConfig.tema =
                              val ? ThemeMode.dark : ThemeMode.light;
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
