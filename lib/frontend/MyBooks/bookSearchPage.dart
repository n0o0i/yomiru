import 'package:flutter/material.dart';
import 'package:yomiru/services/api_service.dart';
import 'package:yomiru/services/local_storage_service.dart';
import 'package:yomiru/models/book_model.dart';
import 'package:yomiru/frontend/MyBooks/addBookPage.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchBooks() async {
    if (_searchController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await ApiService.searchBooks(_searchController.text.trim());
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '検索中にエラーが発生しました: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _addBook(Map<String, dynamic> bookData) async {
    try {
      // BookModelに変換
      final book = BookModel.fromJson(bookData);
      
      // ローカルストレージに保存
      final success = await LocalStorageService.saveBook(book);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('本を追加しました！'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('本の追加に失敗しました'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('エラーが発生しました: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本を検索'),
        actions: [
          IconButton(
            onPressed: _searchBooks,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          // 検索バー
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '本のタイトル、著者、ISBNで検索',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: _searchBooks,
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (_) => _searchBooks(),
            ),
          ),
          
          // エラーメッセージ
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
          
          // ローディング表示
          if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          // 検索結果
          else if (_searchResults.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final book = _searchResults[index];
                  return _buildBookCard(book);
                },
              ),
            )
          // 初期状態
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '本を検索してください',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => _showBookDetails(book),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              // 本の画像
              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[300],
                ),
                child: book['imageUrl'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          book['imageUrl'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.book, color: Colors.grey);
                          },
                        ),
                      )
                    : Icon(Icons.book, color: Colors.grey),
              ),
              SizedBox(width: 12),
              
              // 本の情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title'] ?? 'タイトル不明',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      book['author'] ?? '著者不明',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (book['publisher'] != null) ...[
                      SizedBox(height: 2),
                      Text(
                        book['publisher'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (book['averageRating'] != null) ...[
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(
                            '${book['averageRating'].toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // 追加ボタン
              IconButton(
                onPressed: () => _addBook(book),
                icon: Icon(Icons.add),
                tooltip: '本を追加',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookDetails(Map<String, dynamic> book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(book['title'] ?? 'タイトル不明'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (book['imageUrl'] != null) ...[
                Center(
                  child: Image.network(
                    book['imageUrl'],
                    height: 200,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.book, size: 100, color: Colors.grey);
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],
              Text('著者: ${book['author'] ?? '不明'}'),
              if (book['publisher'] != null)
                Text('出版社: ${book['publisher']}'),
              if (book['publishedDate'] != null)
                Text('発売日: ${book['publishedDate']}'),
              if (book['pageCount'] != null)
                Text('ページ数: ${book['pageCount']}ページ'),
              if (book['averageRating'] != null)
                Text('評価: ${book['averageRating'].toStringAsFixed(1)}/5.0'),
              if (book['description'] != null) ...[
                SizedBox(height: 8),
                Text('説明:'),
                Text(
                  book['description'],
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('閉じる'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _addBook(book);
            },
            child: Text('追加'),
          ),
        ],
      ),
    );
  }
}

