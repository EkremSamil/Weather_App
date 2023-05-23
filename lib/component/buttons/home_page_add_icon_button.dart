import '../../export.dart';

class AddIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 48,
      color: Colors.white,
      icon: Icon(Icons.add),
    );
  }
}
