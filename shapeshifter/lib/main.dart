import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:shapeshifter/gifManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int divisionCount = 7;
  //ditto as below for why we start at 1
  ValueNotifier<int> selectedSideCount = new ValueNotifier<int>(1);
  //8 in front for slight discrepancy
  List<int> sides = [
    8,0,3,4,5,6,7
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleCircularSlider(
          //basics
          divisionCount,
          selectedSideCount.value,
          //size
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          //colors
          primarySectors: 0,
          showRoundedCapInSelection: true,
          showHandlerOutter: true,
          sliderStrokeWidth: 24,
          handlerColor: Theme.of(context).accentColor,
          baseColor: ThemeData.dark().primaryColorLight,
          selectionColor: ThemeData.dark().cardColor,
          //code
          onSelectionChange: (int start, int end, int laps){
            selectedSideCount.value = end;
            if(end > 6){
              selectedSideCount.value = 0;
            }
            
            //change text
            setState(() {});
          },
          child: Padding(
            //24 is what you need for it to appear as 0 padding
            padding: const EdgeInsets.all(24),
            child: Padding(
              //24 is padding the morphing shape has
              padding: const EdgeInsets.all(24),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned.fill(
                    child: GifManager(
                      selectedSideCount: selectedSideCount,
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.all(
                        //56 is the extra padding we add to be within the shape
                        56,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          sides[selectedSideCount.value].toString() + " Sides",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
