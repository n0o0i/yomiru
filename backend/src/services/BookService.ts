import { v4 as uuidv4 } from 'uuid';
import { Book, CreateBookRequest, UpdateBookRequest, BookQueryParams } from '../types/Book';

export class BookService {
  // メモリ内データストレージ（実際のプロダクションではデータベースを使用）
  private books: Book[] = [];

  // 本の一覧取得
  public async getBooks(queryParams: BookQueryParams): Promise<Book[]> {
    let filteredBooks = [...this.books];

    // ステータスでフィルタリング
    if (queryParams.status) {
      filteredBooks = filteredBooks.filter(book => book.status === queryParams.status);
    }

    // 検索クエリでフィルタリング
    if (queryParams.search) {
      const searchTerm = queryParams.search.toLowerCase();
      filteredBooks = filteredBooks.filter(book => 
        book.title.toLowerCase().includes(searchTerm) ||
        book.author.toLowerCase().includes(searchTerm) ||
        (book.publisher && book.publisher.toLowerCase().includes(searchTerm))
      );
    }

    // ページネーション
    const page = queryParams.page || 1;
    const limit = queryParams.limit || 10;
    const startIndex = (page - 1) * limit;
    const endIndex = startIndex + limit;

    return filteredBooks.slice(startIndex, endIndex);
  }

  // 本の詳細取得
  public async getBookById(id: string): Promise<Book | null> {
    return this.books.find(book => book.id === id) || null;
  }

  // 本の追加
  public async createBook(bookData: CreateBookRequest): Promise<Book> {
    const now = new Date().toISOString();
    
    const newBook: Book = {
      id: uuidv4(),
      title: bookData.title,
      author: bookData.author,
      publisher: bookData.publisher,
      isbn: bookData.isbn,
      status: bookData.status,
      rating: bookData.rating,
      dateAdded: now,
      dateRead: bookData.dateRead,
      memo: bookData.memo,
      tags: bookData.tags || [],
      createdAt: now,
      updatedAt: now
    };

    this.books.push(newBook);
    return newBook;
  }

  // 本の更新
  public async updateBook(id: string, updateData: UpdateBookRequest): Promise<Book | null> {
    const bookIndex = this.books.findIndex(book => book.id === id);
    
    if (bookIndex === -1) {
      return null;
    }

    const updatedBook: Book = {
      ...this.books[bookIndex],
      ...updateData,
      updatedAt: new Date().toISOString()
    };

    this.books[bookIndex] = updatedBook;
    return updatedBook;
  }

  // 本の削除
  public async deleteBook(id: string): Promise<boolean> {
    const bookIndex = this.books.findIndex(book => book.id === id);
    
    if (bookIndex === -1) {
      return false;
    }

    this.books.splice(bookIndex, 1);
    return true;
  }

  // 本の検索
  public async searchBooks(query: string): Promise<Book[]> {
    const searchTerm = query.toLowerCase();
    
    return this.books.filter(book => 
      book.title.toLowerCase().includes(searchTerm) ||
      book.author.toLowerCase().includes(searchTerm) ||
      (book.publisher && book.publisher.toLowerCase().includes(searchTerm)) ||
      (book.memo && book.memo.toLowerCase().includes(searchTerm))
    );
  }
}





