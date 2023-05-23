import '../export.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  final int? flex;
  final double? height;
  final double? width;

  final Widget? child;
  EdgeInsets? margin;
  EdgeInsets? padding;

  CustomContainer({
    Key? key,
    this.flex,
    required this.height,
    this.width,
    required this.child,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: boxDecoration(),
      margin: margin ?? const EdgeInsets.all(14),
      child: child,
    );
  }
}

BoxDecoration boxDecoration() {
  return const BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.all(Radius.circular(36)),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(3, 3),
      ),
    ],
  );
}
