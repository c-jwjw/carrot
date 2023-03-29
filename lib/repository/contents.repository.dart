class ContentsRepository{
    
  Map<String, dynamic> data = {
    "town1" : [
      {
        "cid" : "1",
        "image" : "assets/images/town1-1.jpeg",
        "title" : "치약",
        "location" : "town1",
        "price" : "3000",
        "likes" : "3"
      },
      {
        "cid" : "2",
        "image": "assets/images/town1-2.jpeg",
        "title" : "춘식이 인형",
        "location" : "town1",
        "price" : "5000",
        "likes" : "10"
      },
      {
        "cid" : "3",
        "image": "assets/images/town1-3.jpeg",
        "title" : "아이패드 에어 4세대",
        "location" : "town1",
        "price" : "450000",
        "likes" : "78"
      },
      {
        "cid" : "4",
        "image": "assets/images/town1-4.jpeg",
        "title" : "짱구 반지 단종품",
        "location" : "town1",
        "price" : "5000",
        "likes" : "100"
      },
      {
        "cid" : "5",
        "image": "assets/images/town1-5.jpeg",
        "title" : "해커스 토익 보카 분철됨",
        "location" : "town1",
        "price" : "8000",
        "likes" : "17"
      },
      {
        "cid" : "6",
        "image": "assets/images/town1-6.jpeg",
        "title" : "미니 냉장고 새상품",
        "location" : "town1",
        "price" : "23000",
        "likes" : "40"
      },
      {
        "cid" : "7",
        "image": "assets/images/town1-7.jpeg",
        "title" : "통기타",
        "location" : "town1",
        "price" : "30000",
        "likes" : "3"
      },
      {
        "cid" : "8",
        "image": "assets/images/town1-8.jpg",
        "title" : "고양이 음수대",
        "location" : "town1",
        "price" : "34000",
        "likes" : "54"
      },
      {
        "cid" : "9",
        "image": "assets/images/town1-9.jpg",
        "title" : "흰둥이 무드등 미개봉",
        "location" : "town1",
        "price" : "7000",
        "likes" : "8"
      },
      {
        "cid" : "10",
        "image": "assets/images/town1-10.jpeg",
        "title" : "아이워크 미니 보조배터리",
        "location" : "town1",
        "price" : "15000",
        "likes" : "65"
      },
    ],
    "town2" : [
      {
        "cid" : "1",
        "image" : "assets/images/town2-1.jpeg",
        "title" : "소니 wh-1000xm5 헤드셋",
        "location" : "town2",
        "price" : "320000",
        "likes" : "300"
      },
      {
        "cid" : "2",
        "image": "assets/images/town2-2.jpeg",
        "title" : "맹구 욕실 피규어 1개",
        "location" : "town2",
        "price" : "3500",
        "likes" : "100"
      },
      {
        "cid" : "3",
        "image": "assets/images/town2-3.jpg",
        "title" : "아이폰 13미니",
        "location" : "town2",
        "price" : "370000",
        "likes" : "89"
      },
      {
        "cid" : "4",
        "image": "assets/images/town2-4.jpeg",
        "title" : "1인용 독서실 책상",
        "location" : "town2",
        "price" : "무료나눔",
        "likes" : "160"
      },
      {
        "cid" : "5",
        "image": "assets/images/town2-5.jpeg",
        "title" : "닌텐도 스위치 라이트 라이트 코랄(한정) 색상",
        "location" : "town2",
        "price" : "300000",
        "likes" : "420"
      },
      {
        "cid" : "6",
        "image": "assets/images/town2-6.jpg",
        "title" : "춤추는 트리 인형",
        "location" : "town2",
        "price" : "8800",
        "likes" : "29"
      },
      {
        "cid" : "7",
        "image": "assets/images/town2-7.jpg",
        "title" : "에어팟 3세대",
        "location" : "town2",
        "price" : "180000",
        "likes" : "87"
      },
      {
        "cid" : "8",
        "image": "assets/images/town2-8.jpeg",
        "title" : "로지텍 지프로 슈퍼라이트",
        "location" : "town2",
        "price" : "120000",
        "likes" : "99"
      },
      {
        "cid" : "9",
        "image": "assets/images/town2-9.jpeg",
        "title" : "안마의자",
        "location" : "town2",
        "price" : "1500000",
        "likes" : "5"
      },
      {
        "cid" : "10",
        "image": "assets/images/town2-10.jpeg",
        "title" : "산리오 시나모롤 캐리어(세븐일레븐)",
        "location" : "town2",
        "price" : "37000",
        "likes" : "77"
      },
    ],
    "mytown" : [
      {},
    ],
  };

  Future<List<Map<String, dynamic>>> loadContentsFromLocation(String location) async {
      //location값을 보내주면서 통신
      await Future.delayed(const Duration(milliseconds : 1000));
      return data[location];
  }
}