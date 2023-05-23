import '../../export.dart';

class ListIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const ListIconButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      color: Colors.white,
      iconSize: 26,
      icon: Icon(Icons.list),
    );
  }
}
