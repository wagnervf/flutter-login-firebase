import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/event/views/event_view.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/modules/perfil/views/perfil_view.dart';
import 'package:flutter_loggin_firebase/app/shared/enums.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconHome(inActiveIconColor),
            iconCalendar(inActiveIconColor),
            floatButton(context),
            iconList(inActiveIconColor),
            iconProfile(inActiveIconColor),
          ],
        ),
      ),
    );
  }

  Container floatButton(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 24.0),
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _configurandoModalBottomSheet(context),
      ),
    );
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.music_note),
                    title: new Text('Músicas'),
                    onTap: () => {}),
                ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Videos'),
                  onTap: () => {},
                ),
                ListTile(
                  leading: new Icon(Icons.satellite),
                  title: new Text('Tempo'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  IconButton iconProfile(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.person_fill,
        color: MenuState.profile == selectedMenu
            ? kPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => PerfilView(),
      ),
    );
  }

  IconButton iconList(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.list_bullet,
        color:
            MenuState.list == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }

  IconButton iconCalendar(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.calendar,
        color:
            MenuState.event == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => EventView(),
      ),
    );
  }

  IconButton iconHome(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.house_fill,
        color:
            MenuState.home == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }
}
