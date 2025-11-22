import 'package:flutter/material.dart';

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
      _scale = 1.0 - (_scrollController.offset / 200);
      _scale = _scale.clamp(0.5, 1.0); // 最小値を0.5に制限
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('book name')),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Transform.scale(
              scale: _scale,
              child: Container(
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'スクロールで小さくなる',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1000,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('book title'),
                  ),
                  Divider(),
                ],  
              ),          
            )
          ],
        ),
      ),
    );
  }
}
