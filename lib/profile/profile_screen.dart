import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            ProfileTitle(),
            UserNameWidget(),
            InfoBlock(),
            SizedBox(height: 20),
            Divider(),
            HistoryButton(),
            Divider(),
            SettingsButton(),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class ProfileTitle extends StatelessWidget {
  const ProfileTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: const Text(
          'Профиль',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: const [
          Text(
            'Добрый день, [имя_пользователя]!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class HistoryButton extends StatelessWidget {
  const HistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Row(
        children: const [
          Icon(Icons.history),
          SizedBox(width: 20),
          Text(
            'История покупок',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          Icon(Icons.arrow_right_outlined),
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Row(
        children: const [
          Icon(Icons.settings),
          SizedBox(width: 20),
          Text(
            'Настройки приложения',
            style: TextStyle(fontSize: 20),
          ),
          Spacer(),
          Icon(Icons.arrow_right_outlined),
        ],
      ),
    );
  }
}

class InfoBlock extends StatelessWidget {
  const InfoBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Material(
        shadowColor: Colors.black,
        elevation: 7,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              Text(
                'Рекламная инфа',
                style: TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
              Text(
                'Тут может быть произвольная рекламная или другая инфа',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
