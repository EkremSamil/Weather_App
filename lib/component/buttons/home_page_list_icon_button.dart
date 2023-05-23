import '../../export.dart';

class ListIconButton extends StatelessWidget {
  const ListIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      color: Colors.white,
      iconSize: 26,
      icon: Icon(Icons.list),
    );
  }
}
