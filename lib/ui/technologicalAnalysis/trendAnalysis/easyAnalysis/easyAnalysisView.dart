import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_plus/flutter_chart.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/style/textStyle.dart';

class EasyAnalysisView extends StatefulWidget {
  const EasyAnalysisView({super.key});

  @override
  State<EasyAnalysisView> createState() => _EasyAnalysisViewState();
}

class _EasyAnalysisViewState extends State<EasyAnalysisView> {
  final List<Map> dataList = [
    {
      'title': "SHT",
      'value1': 80.2,
    },
    {
      'title': "PAS",
      'value1': 86.7,
    },
    {
      'title': "DEF",
      'value1': 76.3,
    },
    {
      'title': "PHY",
      'value1': 61.5,
    },
    {
      'title': "SPD",
      'value1': 82,
    },
    {
      'title': "DRI",
      'value1': 100,
    },
  ];
  Color color1 = Color.fromRGBO(255, 255, 255, 1);
  Color color2 = Color.fromRGBO(226, 6, 19, 1);
  Color color3 = Color.fromRGBO(255, 134, 81, 1);

  bool _isUnfold = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              "images/back.png",
              width: 10,
              fit: BoxFit.contain,
            )),
        title: Text("简单分析",style: AllTextStyle.f14White,),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child:
        Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 19),
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 13, 12, 16),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 46, 46, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 202,
                      padding: EdgeInsets.fromLTRB(17, 14, 17, 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color.fromRGBO(255, 255, 255, 1),
                            const Color.fromRGBO(255, 139, 146, 1),
                            const Color.fromRGBO(247, 158, 163, 1),
                            const Color.fromRGBO(246, 246, 246, 1),
                          ],
                        ),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 172,
                              height: 164,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/bg_radar1.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: ChartWidget(
                                coordinateRender: ChartCircularCoordinateRender(
                                  margin: const EdgeInsets.all(10),
                                  charts: [
                                    Radar(
                                      max: 150,
                                      data: dataList,
                                      lineColor: Colors.transparent,
                                      colors: [Colors.transparent],
                                      fillColors: [Colors.white],
                                      // legendFormatter: () => dataList.map((e) => e['title']).toList(),
                                      // count: 3,
                                      valueFormatter: (item) => [
                                        item['value1'],
                                      ],
                                      values: (item) => [
                                        (double.parse(item['value1'].toString())),
                                      ],
                                    ),
                                  ],
                                  borderColor: Colors.transparent,
                                ),
                              )),
                          SizedBox(width: 20,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown, // 仅在文本超出时缩小（不放大）
                                alignment: Alignment.centerLeft, // 保持左对齐（可按需改为 center/right）
                                child: Text(
                                  "Total score", // 即使数字更长（如"123.456"）也会自适应
                                  style: TextStyle(
                                    fontSize: 20, // 最大字体大小（超出时自动缩小）
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                "总评分",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w700),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown, // 仅在文本超出时缩小（不放大）
                                alignment: Alignment.centerLeft, // 保持左对齐（可按需改为 center/right）
                                child: Text(
                                  "86.1", // 即使数字更长（如"123.456"）也会自适应
                                  style: TextStyle(
                                    fontSize: 55, // 最大字体大小（超出时自动缩小）
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset("images/tubiaozhizuomoban.png",width: 8,fit: BoxFit.contain,),
                                  SizedBox(width: 6,),
                                  Text(
                                    "场次：",
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "25",
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(height: 17,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("images/daipingjia.png",width: 8,fit: BoxFit.contain,),
                                      SizedBox(width: 6,),
                                      Text(
                                        "评价",
                                        style: TextStyle(
                                            fontSize: 10, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("images/qiapian002.png",width: 10,fit: BoxFit.contain,),
                                      SizedBox(width: 6,),
                                      Text(
                                        "球星卡",
                                        style: TextStyle(
                                            fontSize: 10, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(child: Container(
                          width: 97,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(16, 16, 16, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(37.92),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          // padding: EdgeInsets.fromLTRB(20, 11, 20, 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("26",style: AllTextStyle.f18White,),
                              SizedBox(height: 10,),
                              Text("射门 (次)",style: AllTextStyle.f10WhiteNormal),
                            ],
                          ),
                        )),
                        SizedBox(width: 20,),
                        Expanded(child: Container(
                          width: 97,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(16, 16, 16, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          // padding: EdgeInsets.fromLTRB(17, 11, 20, 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("102",style: AllTextStyle.f18White,),
                              SizedBox(height: 10,),
                              Text("传球 (次)",style: AllTextStyle.f10WhiteNormal),
                            ],
                          ),
                        )),
                        SizedBox(width: 20,),
                        Expanded(child: Container(
                          width: 97,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(16, 16, 16, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          // padding: EdgeInsets.fromLTRB(20, 11, 20, 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("832",style: AllTextStyle.f18White,),
                              SizedBox(height: 10,),
                              Text("触球 (次)",style: AllTextStyle.f10WhiteNormal),
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(child: Container(
                          width: 97,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(16, 16, 16, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          // padding: EdgeInsets.fromLTRB(20, 11, 20, 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("1867",style: AllTextStyle.f18White,),
                              SizedBox(height: 10,),
                              Text("最大冲刺 (米/每秒)",style: AllTextStyle.f10WhiteNormal),
                            ],
                          ),
                        )),
                        SizedBox(width: 21,),
                        Expanded(child: Container(
                          width: 97,
                          height: 76,
                          decoration: BoxDecoration(
                            // color: Color.fromRGBO(16, 16, 16, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(37.92),
                              bottomLeft: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage('images/bg_juxin3.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("3.86",style: AllTextStyle.f18White,),
                              SizedBox(height: 1,),
                              Text("跑动距离 (千米)",style: AllTextStyle.f10WhiteNormal),
                            ],
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 16,),

                    !_isUnfold ?
                    Container(
                      height: 268,
                      child: Stack(
                          children: [
                            Image.asset("images/bg_juxin4.png",fit: BoxFit.contain,height: 268,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      _showProgressBar(color1, color2,70),
                                      SizedBox(height: 2,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("射门欲望",style: AllTextStyle.f10WhiteNormal,),
                                          Text("70",style: AllTextStyle.f10WhiteNormal,),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Column(
                                    children: [
                                      _showProgressBar(color1, color2,53),
                                      SizedBox(height: 2,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("射门力量",style: AllTextStyle.f10WhiteNormal,),
                                          Text("53",style: AllTextStyle.f10WhiteNormal,),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Column(
                                    children: [
                                      _showProgressBar(color1, color2,95),
                                      SizedBox(height: 2,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("射门时机",style: AllTextStyle.f10WhiteNormal,),
                                          Text("95",style: AllTextStyle.f10WhiteNormal,),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Column(
                                    children: [
                                      _showProgressBar(color1, color3,72),
                                      SizedBox(height: 2,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("长传能力",style: AllTextStyle.f10WhiteNormal,),
                                          Text("72",style: AllTextStyle.f10WhiteNormal,),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("images/pressBar.png",height: 16,fit: BoxFit.contain,),
                                      SizedBox(height: 2,),
                                      Text("短传能力",style: AllTextStyle.f10WhiteNormal,)
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Image.asset("images/pressBar.png",height: 16,fit: BoxFit.contain,),

                                ],
                              ),
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isUnfold = true;
                                    });
                                  },
                                  child: Image.asset("images/unfold.png",fit: BoxFit.contain,height: 69,width: 90,),
                                ))
                          ]


                      ),
                    ) :

                    SizedBox(
                      height: 268,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 17),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(16, 16, 16, 1),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child:
                          Column(
                            children: [
                              Column(
                                children: [
                                  _showProgressBar(color1, color2,70),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("射门欲望",style: AllTextStyle.f10WhiteNormal,),
                                      Text("70",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),

                              Column(
                                children: [
                                  _showProgressBar(color1, color2,53),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("射门力量",style: AllTextStyle.f10WhiteNormal,),
                                      Text("53",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),

                              Column(
                                children: [
                                  _showProgressBar(color1, color2,95),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("射门时机",style: AllTextStyle.f10WhiteNormal,),
                                      Text("95",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),

                              Column(
                                children: [
                                  _showProgressBar(color1, color3,72),
                                  SizedBox(height: 2,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("长传能力",style: AllTextStyle.f10WhiteNormal,),
                                      Text("72",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),

                              Column(
                                children: [
                                  _showProgressBar(color1, color3,95),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("短传能力",style: AllTextStyle.f10WhiteNormal,),
                                      Text("95",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Column(
                                children: [
                                  _showProgressBar(color1, color3,80),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("冲刺能力",style: AllTextStyle.f10WhiteNormal,),
                                      Text("80",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Column(
                                children: [
                                  _showProgressBar(color1, color2,96),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("耐力",style: AllTextStyle.f10WhiteNormal,),
                                      Text("96",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),

                              Column(
                                children: [
                                  _showProgressBar(color1, color2,90),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("触球",style: AllTextStyle.f10WhiteNormal,),
                                      Text("90",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),

                              Column(
                                children: [
                                  _showProgressBar(color1, color2,75),
                                  SizedBox(height: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("灵活度",style: AllTextStyle.f10WhiteNormal,),
                                      Text("75",style: AllTextStyle.f10WhiteNormal,),
                                    ],
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              ),
        )



      ),
    );
  }

  Widget _showProgressBar(Color color1,Color color2,int value) {
    return Container(
      height: 16,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // 进度条背景
            Container(color: Colors.white),
            // 渐变色进度
            LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: constraints.maxWidth * (value / 100), // 进度
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color1,
                        color2,
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
