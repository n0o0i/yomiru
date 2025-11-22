import 'package:flutter/material.dart';
import 'package:yomiru/frontend/shared/bookDetails copy.dart';
import 'package:yomiru/services/local_storage_service.dart';
import 'package:yomiru/models/book_model.dart';

class booksGridView extends StatefulWidget {
  const booksGridView({super.key});

  @override
  _booksGridViewState createState() => _booksGridViewState();
}

class _booksGridViewState extends State<booksGridView> {
  List<BookModel> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    try {
      // ローカルストレージから本を取得
      final books = LocalStorageService.getAllBooks();
      setState(() {
        _books = books;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 3
      ),
      itemCount: _books.length,
      itemBuilder: (context, index) {
        final book = _books[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ShrinkingWidget())
            );
          },
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // 本の画像
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                      color: Colors.grey[300],
                    ),
                    child: book.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            child: Image.network(
                              book.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.book, color: Colors.grey, size: 40);
                              },
                            ),
                          )
                        : Icon(Icons.book, color: Colors.grey, size: 40),
                  ),
                ),
                // 本のタイトル
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        );
      }
    );
  }
}