// import { Request, Response } from 'express';
import { Context } from 'hono';
import { Book, CreateBookRequest, UpdateBookRequest, BookQueryParams } from '../types/Book';
import { BookService } from '../services/BookService';

export class BookController {
  private bookService: BookService;

  constructor() {
    this.bookService = new BookService();
  }

  // 本の一覧取得
  public getBooks = async (c: Context) => {
    try {
      const queryParams: BookQueryParams = {
        status: c.req.query('status') as 'read' | 'to_read' | undefined,
        search: c.req.query('search') as string | undefined,
        page: c.req.query('page') ? parseInt(c.req.query('page') as string) : 1,
        limit: c.req.query('limit') ? parseInt(c.req.query('limit') as string) : 10
      };

      const books = await this.bookService.getBooks(c.env, queryParams);
      
      return c.json({
        success: true,
        data: books,
        pagination: {
          page: queryParams.page || 1,
          limit: queryParams.limit || 10,
          total: books.length
        }
      }, 200);
    } catch (error) {
      return c.json({
        success: false,
        error: 'Failed to fetch books',
        message: error instanceof Error ? error.message : 'Unknown error'
      }, 500);
    }
  };

  // 本の詳細取得
//   public getBookById = async (c: Context) => {
//     try {
//       const id = c.req.param('id');
//       const book = await this.bookService.getBookById(id);

//       if (!book) {
//         return c.json({
//           success: false,
//           error: 'Book not found',
//           message: `Book with id ${id} not found`
//         }, 404);
//       }

//       return c.json({
//         success: true,
//         data: book
//       }, 200);
//     } catch (error) {
//       return c.json({
//         success: false,
//         error: 'Failed to fetch book',
//         message: error instanceof Error ? error.message : 'Unknown error'
//       }, 500);
//     }
//   };

  // 本の追加
  public createBook = async (c: Context)=> {
    try {
      const bookData: CreateBookRequest = await c.req.json();
      const book = await this.bookService.createBook(c.env, bookData);

      return c.json({
        success: true,
        data: book,
        message: 'Book created successfully'
      }, 201);
    } catch (error) {
       return c.json({
        success: false,
        error: 'Failed to create book',
        message: error instanceof Error ? error.message : 'Unknown error'
      },);
    }
  };

//   // 本の更新
//   public updateBook = async (c: Context) => {
//     try {
//       const id = c.req.param('id');
//       const updateData: UpdateBookRequest = await c.req.json();
      
//       const book = await this.bookService.updateBook(id, updateData);

//       if (!book) {
//         return c.json({
//           success: false,
//           error: 'Book not found',
//           message: `Book with id ${id} not found`
//         }, 404);
//         return;
//       }

//       return c.json({
//         success: true,
//         data: book,
//         message: 'Book updated successfully'
//       }, 200);
//     } catch (error) {
//       return c.json({
//         success: false,
//         error: 'Failed to update book',
//         message: error instanceof Error ? error.message : 'Unknown error'
//       }, 500);
//     }
//   };

//   // 本の削除
//   public deleteBook = async (c: Context) => {
//     try {
//       const id = c.req.param('id');
//       const deleted = await this.bookService.deleteBook(id);

//       if (!deleted) {
//         return c.json({
//           success: false,
//           error: 'Book not found',
//           message: `Book with id ${id} not found`
//         }, 404);
//         return;
//       }

//       return c.json({
//         success: true,
//         message: 'Book deleted successfully'
//       }, 200);
//     } catch (error) {
//       return c.json({
//         success: false,
//         error: 'Failed to delete book',
//         message: error instanceof Error ? error.message : 'Unknown error'
//       }, 500);
//     }
//   };

//   // 本の検索
//   public searchBooks = async (c: Context) => {
//     try {
//       const query = c.req.param('query');
//       const books = await this.bookService.searchBooks(query);

//       return c.json({
//         success: true,
//         data: books,
//         query: query
//       }, 200);
//     } catch (error) {
//       return c.json({
//         success: false,
//         error: 'Failed to search books',
//         message: error instanceof Error ? error.message : 'Unknown error'
//       }, 500);
//     }
//   };
}