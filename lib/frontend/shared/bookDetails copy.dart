import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShrinkingWidget extends StatefulWidget {
  const ShrinkingWidget({super.key});

  @override
  _ShrinkingWidgetState createState() => _ShrinkingWidgetState();
}

class _ShrinkingWidgetState extends State<ShrinkingWidget> {
  double _scale = 1.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      // スクロール量に応じてスケールを調整
      _scale = 1.0 - (_scrollController.offset / 600);
      _scale = _scale.clamp(0.5, 1.0); // 最小値を0.5に制限
    });
  }

  final List<String> detailTitles = [
    'タイトル',
    '著者',
    '出版社',
    '発売日',
    'タグ',
    'ステータス',
    '感想',
    'メモ',
    '評価',
  ];

  final List<String> detailContents = [
    'テストテストタイトル',
    'テスト著者',
    'テスト出版社',
    'テスト発売日',
    'テストタグ',
    'テストステータス',
    'テスト感想',
    'テストメモ',
    'テスト評価',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('book name'),
        actions: [
          IconButton(
            onPressed: (){
              // TODO: ブックマーク追加機能を実装
            }, 
            icon: Icon(Icons.bookmark_added_outlined)
          ),
          IconButton(
            onPressed: (){
              // TODO: ブックマーク機能を実装
            }, 
            icon: Icon(Icons.bookmark_add_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Transform.scale(
              scale: _scale,
              child: SizedBox(
                height: 300,
                width: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  )
              ),
            ),
            SizedBox(height: 20), // Transform.scaleの下の余白を追加
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                )
              ),
              child: Column(
                children: List.generate(
                  detailTitles.length, 
                  (index) => Column(
                    children: [
                      ListTile(
                        leading: (index > 3)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(detailTitles[index]),
                                SizedBox(width: 4,),
                                Icon(Icons.edit, size: 14,)
                              ],
                            )
                          : Text(detailTitles[index]),
                        title: (index == 8)
                        ? RatingBar.builder(
                            itemBuilder: (context, index) => const Icon(Icons.star), 
                            onRatingUpdate: (rating) {
                              // TODO: 評価をデータベースに保存
                            },
                            allowHalfRating: true,
                          )
                        : Text(detailContents[index]),
                        minLeadingWidth: 100,
                      ),
                      Divider()
                    ],
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
