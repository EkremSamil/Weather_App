import '../../export.dart';

class GPSFixedIconButton extends StatelessWidget {
  const GPSFixedIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      color: Colors.white,
      iconSize: 26,
      icon: Icon(Icons.gps_fixed),
    );
  }
}
