import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publisherController = TextEditingController();
  final _isbnController = TextEditingController();
  final _memoController = TextEditingController();
  
  String _selectedStatus = 'to_read'; // 'read' or 'to_read'
  double _rating = 0.0;
  DateTime? _selectedDate;
  
  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _isbnController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本を追加'),
        actions: [
          TextButton(
            onPressed: _saveBook,
            child: Text(
              '保存',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ステータス選択
              _buildStatusSelector(),
              SizedBox(height: 24),
              
              // 本の基本情報
              _buildBasicInfoSection(),
              SizedBox(height: 24),
              
              // 評価（readの場合のみ）
              if (_selectedStatus == 'read') ...[
                _buildRatingSection(),
                SizedBox(height: 24),
              ],
              
              // 日付選択
              _buildDateSection(),
              SizedBox(height: 24),
              
              // メモ
              _buildMemoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ステータス',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text('読みたい本'),
                value: 'to_read',
                groupValue: _selectedStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('読んだ本'),
                value: 'read',
                groupValue: _selectedStatus,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '基本情報',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'タイトル *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.title),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'タイトルを入力してください';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _authorController,
          decoration: InputDecoration(
            labelText: '著者 *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '著者を入力してください';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _publisherController,
          decoration: InputDecoration(
            labelText: '出版社',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.business),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: _isbnController,
          decoration: InputDecoration(
            labelText: 'ISBN',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.qr_code),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '評価',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text('評価: '),
            ...List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    _rating = (index + 1).toDouble();
                  });
                },
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              );
            }),
            Text(' ${_rating.toInt()}/5'),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _selectedStatus == 'read' ? '読了日' : '追加日',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 12),
                Text(
                  _selectedDate != null
                      ? '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}'
                      : '日付を選択してください',
                  style: TextStyle(
                    color: _selectedDate != null ? null : Colors.grey,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMemoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メモ・感想',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          controller: _memoController,
          decoration: InputDecoration(
            labelText: 'メモや感想を入力してください',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.note),
          ),
          maxLines: 5,
          maxLength: 500,
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveBook() {
    if (_formKey.currentState!.validate()) {
      // ここでデータベースに保存する処理を実装
      print('本を保存しました:');
      print('タイトル: ${_titleController.text}');
      print('著者: ${_authorController.text}');
      print('ステータス: $_selectedStatus');
      print('評価: $_rating');
      print('日付: $_selectedDate');
      print('メモ: ${_memoController.text}');
      
      // 保存成功のメッセージを表示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('本を追加しました！'),
          backgroundColor: Colors.green,
        ),
      );
      
      // 前のページに戻る
      Navigator.pop(context);
    }
  }
}





