import 'package:flutter/material.dart';


class SellProduct extends StatefulWidget {
  const SellProduct({super.key});

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  late Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      elevation: 0.2,
      automaticallyImplyLeading: false,
      title: const Text(
        "내 물건 팔기",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
                  onPressed: () {Navigator.pop(context);}, 
                  icon: const Icon(Icons.close,)),
      actions:[
        TextButton(
          onPressed: () {print("완료");}, 
          child: const Text(
            "완료", style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 114, 20),),),),
      ],
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _imageBox() {
    return SizedBox(
      width: 80, height: 80,
      child: OutlinedButton(
        onPressed: () {print("이미지 업로드");}, 
        style: OutlinedButton.styleFrom(
          shape : const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          side: BorderSide(
            //width: 70,
            color: Colors.grey.withOpacity(0.6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 18,),
            const Icon(Icons.photo_camera, size: 25, color: Colors.black,),
            const SizedBox(height: 2,),
            Text("0/10", style: TextStyle(color: Colors.black.withOpacity(0.5)),)
          ],
        )
      ),
    );
  }

  /*Widget _imageBox() {
    return Container(
      width: 80, height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15,),
          const Icon(Icons.photo_camera, size: 25,),
          const SizedBox(height: 2,),
          Text("0/10", style: TextStyle(color: Colors.black.withOpacity(0.5)),)
        ],
      ),
    );
  }*/

  Widget _pricePart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "￦ 가격 (선택사항)", 
          style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 17),
        ),
        TextButton.icon(
          onPressed: () {print("가격");}, 
          icon: Icon(Icons.check_box_outline_blank, color: Colors.grey.withOpacity(0.5), size: 33,), 
          label: const Text("나눔", style: TextStyle(color: Colors.black, fontSize: 17),)
        ),
      ],
    );
  }

  Widget _suggestPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () {print("가격 제안받기");}, 
          style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
          ),
          icon: Icon(Icons.check_box, color: Colors.grey.withOpacity(0.3),size: 31,),
          label: const Text("가격 제안받기", style: TextStyle(color: Colors.black, fontSize: 17),),
        ),
        Text("town에 올릴 게시글 내용을 작성해주세요. (판매\n금지 물품은 게시가 제한될 수 있어요.)",
          style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 17),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }

  Widget _locationChoice() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("거래 희망 장소", style: TextStyle(fontSize: 17,),),
            ElevatedButton(
              onPressed: () {print("장소 선택");}, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "장소 선택",
                    style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 17),
                  ),
                  const SizedBox(width: 5,),
                  const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 17,),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
      ],
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            _imageBox(),
            _line(),
            Text(
              "글 제목", 
              style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 18),
            ),
            _line(),
            _pricePart(),
            _line(),
            _suggestPrice(),
            _line(),
            _locationChoice(),
          ],
        ),
      ),
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: 55,
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {
              print("자주 쓰는 문구");
            }, 
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(
              Icons.format_list_bulleted_add,
              size: 15,
              color: Colors.black,
            ), 
            label: const Text(
              "자주 쓰는 문구",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 7),
          TextButton.icon(
            onPressed: () {
              print("보여줄 동네 설정");
            }, 
            icon: const Icon(
              Icons.tune,
              size: 15,
              color: Colors.black,
            ), 
            label: const Text(
              "보여줄 동네 설정",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}