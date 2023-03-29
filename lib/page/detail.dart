import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manor_temperature_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

final oCcy = NumberFormat("#,###", "ko_KR");
String calcStringToWon(String priceString){
  if(priceString=="무료나눔") return priceString;
  if(priceString != null && priceString != ""){
    return "${oCcy.format(int. parse(priceString))}원";
  } else {
    return "- 원";
  }   
}

class _DetailContentViewState extends State<DetailContentView> with SingleTickerProviderStateMixin{
  late Size size;
  late List<Map<String,String>> imgList;
  late int _current;
  double scrollpositionToAlpha = 0;
  ScrollController _controller = ScrollController();
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black).
        animate(_animationController);
    _controller.addListener(() {    // 스크롤 위치가 최상단인지 확인
      setState(() {    // 좌표값 이용
        if(_controller.offset > 255) {
          scrollpositionToAlpha = 255;
        } else {
          scrollpositionToAlpha = _controller.offset;
        }
        _animationController.value = scrollpositionToAlpha / 255;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _current = 0;
    imgList = [
      {"id":"0","url": widget.data["image"].toString()},
      {"id":"1","url": widget.data["image"].toString()},
      {"id":"2","url": widget.data["image"].toString()},
      {"id":"3","url": widget.data["image"].toString()},
      {"id":"4","url": widget.data["image"].toString()},
    ];
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween, 
      builder: (context, child) => 
          Icon(icon, color: _colorTween.value),
    );
  }

  PreferredSizeWidget? _appbarWidget(){
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()), // 스크롤시 투명도 변하도록
      elevation: 0,
      shadowColor: Colors.transparent,
      leading: IconButton(
        onPressed:(){
          Navigator.pop(context);
        },
        icon: _makeIcon(Icons.arrow_back),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.share)),
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.more_vert)),
      ],
    );
  }

  Widget _makeSliderImage(){
    return Container(
      height: size.width * 0.8,
      child: Stack(
        children: [
          Hero(
            tag: widget.data["cid"].toString(),
            // ignore: sort_child_properties_last
            child: CarouselSlider(
              options: CarouselOptions(
                  height: size.width * 0.8,
                  //height: 100,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason){
                    setState(() {
                      _current = index;
                    });
                    print(index);
                  }),
                items: imgList.map((map){
                  return Image.asset(
                    map["url"]!,
                    width: size.width,
                    fit:BoxFit.fill,
                  );
                },).toList(),
              ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,  // 가로축 기준으로 가운데 정렬
              children: imgList.map((map){
                return Container(
                  width: 10.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),  // 수직-수평으로 대칭적 여백 지정
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == int.parse(map["id"]!)   // 현재 id 이미지를 제외하고 반투명하게 조정
                    ? Colors.white
                    : Colors.white.withOpacity(0.4),
                    //? const Color.fromRGBO(0, 0, 0, 0.9)
                    //: const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
        //  ClipRRect(
        //    borderRadius: BorderRadius.circular(50),
        //    child: Container(
        //      width: 50,
        //      height: 50,
        //      child: Image.asset("assets/image/user.png"),  
        //    ),
        //  )
          CircleAvatar(  
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),  //원형으로
          const SizedBox(width: 10),  // 여백줌
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "판매자",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                ),
              ),
              Text("위치"),
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 36.5,)) // 나머지 전체 차지하게끔
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            widget.data["title"].toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 20,
            ),
          ),
          const Text(
            "카테고리 · 몇시간 전",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "내용\n내용\n내용",
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "채팅 · 관심 · 조회",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _reportButton() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                print("이 게시글 신고하기");
              }, 
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 0)), // 원래 있던 여백 제거
              ),
              child: const Text(
                "이 게시글 신고하기",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 30), 
          ],
        ),
      ),
    );
  }

  Widget _otherCellContents() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "판매자님의 판매 상품", 
            style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.bold
            ),
          ),
          Icon(Icons.chevron_right, size: 30),
        ],
      ),
    );
  }

  Widget _bodyWidget(){
    return CustomScrollView(controller: _controller,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(    // 실제 widget list를 갖고있는 목록(children)
            [
              _makeSliderImage(),
              _sellerSimpleInfo(),
              _line(),
              _contentDetail(),
              _line(),
              _reportButton(),
              _line(),
              _otherCellContents(),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,   
              mainAxisSpacing: 10, // 행 간 거리
              crossAxisSpacing: 10 // 열 간 거리
            ),
            delegate: SliverChildListDelegate(List.generate(10, (index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.grey,
                        height: 120,
                      ),
                    ),
                    const Text("상품명", style: TextStyle(fontSize: 14)),
                    const Text(
                      "금액", 
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              );
            }).toList()
            ),
          ),
        ),
      ]
    );
  }

  Widget _bottomBarWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: 55,
      //color: const Color.fromARGB(255, 119, 226, 219),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: Colors.black.withOpacity(0.6),
            iconSize: 17,
            onPressed: () {
              print("관심상품 이벤트 발생");
            },
          ),
          //GestureDetector(
          //  onTap: () {
          //    print("관심상품 이벤트 발생");
          //  },
          //  child: SvgPicture.asset(
          //    "assets/svg/heart_off.svg", 
          //    width: 17, 
          //    height: 17,
          //    color: Colors.black.withOpacity(0.6),
          //  ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            width: 1, 
            height: 40, 
            color: Colors.grey.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  calcStringToWon(widget.data["price"].toString()),
                  style: const TextStyle(
                    fontSize: 15, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("가격 제안하기");
                  },
                  child: const Text(
                    "가격 제안하기",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 114, 20),
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromARGB(255, 255, 114, 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    print("채팅하기");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 255, 114, 20),
                    ),
                    child: const Text(
                      "채팅하기",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 14, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,  // appBar 영역을 투명하게(배경화면이 보이게) 설정 -> 배경화면의 영역을 확장함
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}