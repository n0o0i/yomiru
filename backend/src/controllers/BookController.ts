import { Request, Response } from 'express';
import { v4 as uuidv4 } from 'uuid';
import { Book, CreateBookRequest, UpdateBookRequest, BookQueryParams } from '../types/Book';
import { BookService } from '../services/BookService';

export class BookController {
  private bookService: BookService;

  constructor() {
    this.bookService = new BookService();
  }

  // 本の一覧取得
  public getBooks = async (req: Request, res: Response): Promise<void> => {
    try {
      const queryParams: BookQueryParams = {
        status: req.query.status as 'read' | 'to_read' | undefined,
        search: req.query.search as string | undefined,
        page: req.query.page ? parseInt(req.query.page as string) : 1,
        limit: req.query.limit ? parseInt(req.query.limit as string) : 10
      };

      const books = await this.bookService.getBooks(queryParams);
      
      res.status(200).json({
        success: true,
        data: books,
        pagination: {
          page: queryParams.page || 1,
          limit: queryParams.limit || 10,
          total: books.length
        }
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to fetch books',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // 本の詳細取得
  public getBookById = async (req: Request, res: Response): Promise<void> => {
    try {
      const { id } = req.params;
      const book = await this.bookService.getBookById(id);

      if (!book) {
        res.status(404).json({
          success: false,
          error: 'Book not found',
          message: `Book with id ${id} not found`
        });
        return;
      }

      res.status(200).json({
        success: true,
        data: book
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to fetch book',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // 本の追加
  public createBook = async (req: Request, res: Response): Promise<void> => {
    try {
      const bookData: CreateBookRequest = req.body;
      const book = await this.bookService.createBook(bookData);

      res.status(201).json({
        success: true,
        data: book,
        message: 'Book created successfully'
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to create book',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // 本の更新
  public updateBook = async (req: Request, res: Response): Promise<void> => {
    try {
      const { id } = req.params;
      const updateData: UpdateBookRequest = req.body;
      
      const book = await this.bookService.updateBook(id, updateData);

      if (!book) {
        res.status(404).json({
          success: false,
          error: 'Book not found',
          message: `Book with id ${id} not found`
        });
        return;
      }

      res.status(200).json({
        success: true,
        data: book,
        message: 'Book updated successfully'
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to update book',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // 本の削除
  public deleteBook = async (req: Request, res: Response): Promise<void> => {
    try {
      const { id } = req.params;
      const deleted = await this.bookService.deleteBook(id);

      if (!deleted) {
        res.status(404).json({
          success: false,
          error: 'Book not found',
          message: `Book with id ${id} not found`
        });
        return;
      }

      res.status(200).json({
        success: true,
        message: 'Book deleted successfully'
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to delete book',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // 本の検索
  public searchBooks = async (req: Request, res: Response): Promise<void> => {
    try {
      const { query } = req.params;
      const books = await this.bookService.searchBooks(query);

      res.status(200).json({
        success: true,
        data: books,
        query: query
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to search books',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };
}





