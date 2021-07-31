import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PerfilImageView extends StatelessWidget {
  const PerfilImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile Image.png"),
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
