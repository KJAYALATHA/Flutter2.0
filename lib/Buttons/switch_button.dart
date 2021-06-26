import 'package:flutter/material.dart';
import 'package:fswitch/fswitch.dart';

// ignore: must_be_immutable
class SwitchButton extends StatelessWidget {
  SwitchButton(
      {this.onChanged,
      this.open = true,
      this.sliderChild,
      this.closeChild,
      this.openChild});

  Function onChanged;
  bool open;
  Widget sliderChild;
  Widget closeChild;
  Widget openChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: FSwitch(
        sliderColor: Colors.white,
        sliderChild: sliderChild,
        enable: true,
        open: open,
        width: 300,
        height: 50,
        closeChild: closeChild,
        openChild: openChild,
        color: Colors.blue,
        openColor: Colors.blue[800],
        onChanged: onChanged,
      ),
    );
    // LiteRollingSwitch(
    //     //initial value
    //     value: open,
    //     textOn: 'disponible',
    //     textOff: 'ocupado',
    //     colorOn: Colors.greenAccent[700],
    //     colorOff: Colors.redAccent[700],
    //     iconOn: Icons.done,
    //     iconOff: Icons.remove_circle_outline,
    //     textSize: 16.0,
    //     onChanged: onChanged);
  }
}

// AdvancedSwitch(
// controller: switchContreller,
// activeChild: Text('Online'),
// inactiveChild: Text('Offline'),
// inactiveColor: Colors.blue[800],
// activeColor: Colors.blue,
// width: 80,
// ),
