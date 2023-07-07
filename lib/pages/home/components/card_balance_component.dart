import 'package:flutter/material.dart';

import '../../../components/icon_button_component.dart';
import '../../../providers/user_provider.dart';

class CardBalanceComponent extends StatelessWidget {
  const CardBalanceComponent({
    super.key,
    required this.userStore,
  });

  final UserProvider userStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * .9,
      margin: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 133, 3, 246),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IconButtonComponent(
            color: Color.fromARGB(255, 244, 199, 64),
            icon: Icons.monetization_on_rounded,
            size: 24,
          ),
          Text(
            'Saldo disponível: ${userStore.user?.saldo ?? 0.0}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
