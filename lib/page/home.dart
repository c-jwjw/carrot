import 'package:carrot_market/components/actionbutton_menu.dart';
import 'package:carrot_market/page/detail.dart';
import 'package:carrot_market/page/sell.dart';
import 'package:carrot_market/repository/contents.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../utils/data_utils.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:carrot_market/components/actionbutton_menu.dart';

class Home extends StatefulWidget {
  final Function() onPressed;

  Home({Key? key, required this.onPressed}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with
  SingleTickerProviderStateMixin{
  late String currentLocation;
  late ContentsRepository contentsRepository;
  late AnimationController _animationController;
  late Animation<Color> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  late Animation _colorTween;
  Curve _curve = Curves.easeOut;
  ScrollController _scrollController = ScrollController();
  double indicator = 10.0;
  //bool _isSelected = false;
  //final LayerLink _layerLink = LayerLink();
  final Map<String, String> locationTypeToString = {
    "town1" : "town1",
    "town2" : "town2",
    "mytown" : "내 동네 설정하기",
  };
  final _valueList = [
    '알바', 
    '과외/클래스', 
    '농수산물', 
    '부동산',
    '중고차', 
    '내 물건 팔기'
  ];
  var _selectedValue = '내 물건 팔기';

  @override
  void initState() {
    super.initState();
    currentLocation = "town1";
    _animationController = AnimationController(vsync: this)
        ..addListener(() {setState(() {
            
        });
      });
    _colorTween = ColorTween(begin: Color.fromARGB(255, 255, 114, 20), end: Colors.white).
      animate(_animationController);        
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween, 
      builder: (context, child) => 
          Icon(icon, color: _colorTween.value,)
    );
  }

  PreferredSizeWidget _appbarWidget(){
    return AppBar(
        title : GestureDetector( 
          onTap: (){
            print("click");
          },
          child: PopupMenuButton<String>(
            offset: const Offset(0, 25),
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
            onSelected: (String where) {
              setState(() {
                print(where);
                currentLocation = where;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: "town1", child:Text("town1")),
                const PopupMenuItem(value: "town2", child:Text("town2")),
                const PopupMenuItem(value: "mytown", child:Text("내 동네 설정하기")),
              ];
            },
            child: Row(
              children: [
                Text(locationTypeToString[currentLocation]!),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        elevation: 1,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
          IconButton(
            onPressed: () {}, 
            icon: SvgPicture.asset(
              "assets/svg/bell.svg", 
              width: 22,
            )),
        ],
      );
  }

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext _context, int index){       
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return DetailContentView(
                data: datas[index],
              );
            }));
            print(datas[index]["title"]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Hero(
                    tag: datas[index]["cid"].toString(),
                    child: Image.asset(
                      datas[index]["image"].toString(),
                      width:100,
                      height: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]["title"].toString(), 
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          datas[index]["location"].toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DataUtils.calcStringToWon(datas[index]["price"].toString()),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //Icon(Icons.)
                              SvgPicture.asset(
                                "assets/svg/heart_off.svg",
                                width:13, 
                                height: 13,
                              ),
                              const SizedBox(width: 5),
                              Text(datas[index]["likes"].toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );       
      }, 
      separatorBuilder: (BuildContext  _context, int index){
        //return Divider()
        return Container(height: 1, color:Colors.grey.withOpacity(0.2));
      }, 
      itemCount: datas.length
    );
  }

  Widget _bodyWidget(){
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, snapshot){
        if(snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasError) {
          return const Center(child: Text("데이터 오류"));
        }

        if(snapshot.hasData) {   // 데이터를 정상적으로 받아오게 되면 실행하는 부분
          return _makeDataList(snapshot.data as List<Map<String, String>>);
        }
        
        return const Center(child: Text("데이터가 없습니다.")); 
      },
    );
  }

  /*String _colorOfFlatingActionButton(bool _isState) {
    return Color(
      if(_isState){
        Colors.white
      } else{
        Color.fromARGB(255, 255, 114, 20)
      }
    );
  }
  */

   /*CupertinoButton _actionButtonMenu() {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ActionButtonMenu(),
          ),
        );
      },
      child: const Text(
        "커스텀 드롭박스",
      ), 
    );
  }*/

  /*Widget _actionButtonMenu() {
    return DropdownButton(
      value: _selectedValue,
      items: _valueList.map(
        (value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value.toString();
        });
      },
    );
  }*/

  ScrollingFabAnimated renderFloatingActionButton() {
    return ScrollingFabAnimated(
        onPress: () {
          print("click");
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const ActionButtonMenu(),
            ),
          );
          //Navigator.push(context, 
          //  MaterialPageRoute(builder: (context) => SellProduct())
          //);
      },
      color:const Color.fromARGB(255, 255, 114, 20),
      //icon: _makeIcon(Icons.add),
      icon: const Icon(
        Icons.add, 
        size: 27,
        color:Colors.white,
      ),
      text: const Text(
        '글쓰기', 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, 
          fontSize: 17,
        ),
      ),
      scrollController: _scrollController,
      animateIcon: true,
      inverted: false,
      radius: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: renderFloatingActionButton(),
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      floatingActionButton: renderFloatingActionButton(),
    );
  }
}

