import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/user/controllers/user_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PerfilImageView extends StatelessWidget {
  const PerfilImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final String? url = userController.user.photoURL;
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url ??
                "https://cdn.pixabay.com/photo/2016/08/31/11/54/user-1633249_960_720.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xFFF5F6F9),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
