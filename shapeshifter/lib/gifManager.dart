import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class GifManager extends StatefulWidget {
  GifManager({
    @required this.selectedSideCount,
  });

  final ValueNotifier<int> selectedSideCount;

  @override
  _GifManagerState createState() => _GifManagerState();
}

class _GifManagerState extends State<GifManager> with TickerProviderStateMixin{
  final Duration timeToTransition = Duration(milliseconds: 500);

  GifController ctrl0to3;
  GifController ctrl3to4;
  GifController ctrl4to5;
  GifController ctrl5to6;
  GifController ctrl6to7;
  GifController ctrl7to8;
  GifController ctrl8to0;

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
  void initState() {
    //super init
    super.initState();

    //init all the controller
    ctrl0to3 = GifController(vsync: this);
    ctrl3to4 = GifController(vsync: this);
    ctrl4to5 = GifController(vsync: this);
    ctrl5to6 = GifController(vsync: this);
    ctrl6to7 = GifController(vsync: this);
    ctrl7to8 = GifController(vsync: this);
    ctrl8to0 = GifController(vsync: this);

    //catch all images
    fetchGif(AssetImage("assets/clear/0To3.gif"));
    fetchGif(AssetImage("assets/clear/3To4.gif"));
    fetchGif(AssetImage("assets/clear/4To5.gif"));
    fetchGif(AssetImage("assets/clear/5To6.gif"));
    fetchGif(AssetImage("assets/clear/6To7.gif"));
    fetchGif(AssetImage("assets/clear/7To8.gif"));
    fetchGif(AssetImage("assets/clear/8To0.gif"));

    //listen to the changes to the passed notifier
    widget.selectedSideCount.addListener(recalc);
  }

  @override
  void dispose() { 
    //remove listener
    widget.selectedSideCount.removeListener(recalc);

    //clean up
    ctrl0to3.dispose();
    ctrl3to4.dispose();
    ctrl4to5.dispose();
    ctrl5to6.dispose();
    ctrl6to7.dispose();
    ctrl7to8.dispose();
    ctrl8to0.dispose();
    
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
        child: Center(
          child: Text(""),
        ),
      ),
    );
  }
}