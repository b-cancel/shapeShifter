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
  ValueNotifier<int> selectedSideCountIndex = new ValueNotifier<int>(1);
  ValueNotifier<int> selectedSideCount = new ValueNotifier<int>(0);
  //8 in front for slight discrepancy
  List<int> sides = [
    8,0,3,4,5,6,7
  ];

  static Color backgroundColor = Color(0xFFF5F7FB);

  List<Color> theColors = [
    backgroundColor, //clear
    Color(0xFFFFFFFF), //white (offWhite: F4F4F4)
    Color(0xFFfdfd96), //F0F009), //yellow
    Color(0xFFffb347), //FF8000), //orange
    Color(0xFFff6961), //FF0000), //red
    Color(0xFFffd1dc), //FF69B4), //pink (peach)
    Color(0xFFb19cd9), //730896), //purple 
    Color(0xFFaec6cf), //blue
    Color(0xFF77dd77), //09EE09), //green
    Color(0xFFD2B48C), //tan
    Color(0xFF996633), //brown
    Color(0xFF808080), //grey
    Color(0xFF000000), //black
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> colorButtons = new List<Widget>();
    for(int i = 0; i < theColors.length; i++){
      colorButtons.add(
        IconButton(
          icon: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theColors[i],
              border: Border.all(
                width: 2, 
                color: Colors.black,
              ),
            ),
          ),
          onPressed: (){},
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SingleCircularSlider(
                //basics
                divisionCount,
                selectedSideCountIndex.value,
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
                  selectedSideCountIndex.value = end;
                  if(end > 6){
                    selectedSideCountIndex.value = 0;
                  }

                  //how many sides
                  selectedSideCount.value = sides[
                    selectedSideCountIndex.value
                  ];
                  
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
                            selectedSideCountIndex: selectedSideCountIndex,
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
                                selectedSideCount.value.toString() + " Sides",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Wrap(
                //only center also looks kinda nice
                alignment: WrapAlignment.start,
                //children
                children: colorButtons,
                //space
                spacing: 8,
                runSpacing: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
