import 'package:flutter/material.dart';
import 'package:myexpenses/components/spacer_component.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class UserProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _photoUrlController,
            decoration: const InputDecoration(labelText: 'URL da Foto'),
          ),
          const SpacerComponent(),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Editar Usuário'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _photoUrlController,
                          decoration:
                              const InputDecoration(labelText: 'URL da Foto'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          final name = _nameController.text;
                          final photoUrl = _photoUrlController.text;
                          final saldo = userProvider.user?.saldo;

                          // Atualizar informações do usuário
                          userProvider.setUser(name, photoUrl, saldo!);

                          Navigator.pop(context);
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Editar Usuário'),
          ),
        ],
      ),
    );
  }
}
