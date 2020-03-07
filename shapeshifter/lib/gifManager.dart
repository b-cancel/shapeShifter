import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:shapeshifter/aGif.dart';

class GifManager extends StatefulWidget {
  GifManager({
    @required this.selectedSideCountIndex,
  });

  final ValueNotifier<int> selectedSideCountIndex;

  @override
  _GifManagerState createState() => _GifManagerState();
}

class _GifManagerState extends State<GifManager> with TickerProviderStateMixin{
  final Duration timeToTransition = Duration(milliseconds: 500);

  final List<String> names = [
    "0To3",
    "3To4",
    "4To5",
    "5To6",
    "6To7",
    "7To8",
    "8To0",
  ];

  final List<int> frameCounts = [
    28, //diff
    32,
    32,
    32,
    32,
    31, //diff
    32,
  ];

  final List<int> toSides = [
    0,3,4,5,6,7,8
  ];

  //handled by manager
  //then used as instructions by gifs
  List<GifController> controllers = new List(7);
  List<Widget> theGifs = new List<Widget>(7);

  recalc(){
    //based on 
    //1. what animation is playing
    //2. where we are within that animation
    //we determine what the shortest path to the shape we desire
    
    //then we divide up the transition time
    //all the transition (including the one we are at half with)
    //should take the equivalent ammount of time
    
    //for example
    //we have 500 milliseconds to
    //1. finish 1/2 of 0to3 [50]
    //2. 3to4 full [100]
    //3. 4to5 full [100]
    //so we have 250 paces to walk through with 500 time units
    //so each pace should take 2 time units
    //so each step should take
    //1. 100 time
    //2. 200 time
    //3. 200 time
  }

  @override
  void initState() async{
    //super init
    super.initState();

    //create all gif controllers
    for(int i = 0; i < names.length; i++){
      //add to lists
      controllers[i] = GifController(vsync: this);

      //pass to widget
      theGifs[i] = AGif(
        name: names[i], 
        controller: controllers[i],
      );
    }

    //listen to the changes to the passed notifier
    widget.selectedSideCountIndex.addListener(recalc);
  }

  @override
  void dispose() { 
    //remove listener
    widget.selectedSideCountIndex.removeListener(recalc);

    //clean up
    for(int i = 0; i < names.length; i++){
      controllers[i].dispose();
    }
    
    //super dipose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          children: theGifs,
        ),
      ),
    );
  }
}