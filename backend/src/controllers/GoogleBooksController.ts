import { Request, Response } from 'express';
import { GoogleBooksService } from '../services/GoogleBooksService';

export class GoogleBooksController {
  private googleBooksService: GoogleBooksService;

  constructor() {
    this.googleBooksService = new GoogleBooksService();
  }

  // 本を検索
  public searchBooks = async (req: Request, res: Response): Promise<void> => {
    try {
      const { q, startIndex, maxResults, orderBy, printType, filter } = req.query;

      if (!q) {
        res.status(400).json({
          success: false,
          error: 'Query parameter is required',
          message: 'Search query (q) is required'
        });
        return;
      }

      const searchParams = {
        q: q as string,
        startIndex: startIndex ? parseInt(startIndex as string) : 0,
        maxResults: maxResults ? parseInt(maxResults as string) : 10,
        orderBy: (orderBy as 'relevance' | 'newest') || 'relevance',
        printType: (printType as 'all' | 'books' | 'magazines') || 'books',
        filter: (filter as 'partial' | 'full' | 'free-ebooks' | 'paid-ebooks' | 'ebooks') || 'partial'
      };

      const response = await this.googleBooksService.searchBooks(searchParams);
      
      // アプリ用の形式に変換
      const books = response.items.map(book => this.googleBooksService.convertToBook(book));

      res.status(200).json({
        success: true,
        data: {
          books: books,
          totalItems: response.totalItems,
          pagination: {
            startIndex: searchParams.startIndex,
            maxResults: searchParams.maxResults
          }
        }
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to search books',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // 本の詳細を取得
  public getBookDetails = async (req: Request, res: Response): Promise<void> => {
    try {
      const { volumeId } = req.params;

      const book = await this.googleBooksService.getBookById(volumeId);

      if (!book) {
        res.status(404).json({
          success: false,
          error: 'Book not found',
          message: `Book with volume ID ${volumeId} not found`
        });
        return;
      }

      const bookDetails = this.googleBooksService.convertToBook(book);

      res.status(200).json({
        success: true,
        data: bookDetails
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to get book details',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // ISBNで本を検索
  public searchByISBN = async (req: Request, res: Response): Promise<void> => {
    try {
      const { isbn } = req.params;

      const book = await this.googleBooksService.searchByISBN(isbn);

      if (!book) {
        res.status(404).json({
          success: false,
          error: 'Book not found',
          message: `Book with ISBN ${isbn} not found`
        });
        return;
      }

      const bookDetails = this.googleBooksService.convertToBook(book);

      res.status(200).json({
        success: true,
        data: bookDetails
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to search book by ISBN',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };

  // タイトルと著者で本を検索
  public searchByTitleAndAuthor = async (req: Request, res: Response): Promise<void> => {
    try {
      const { title, author } = req.query;

      if (!title) {
        res.status(400).json({
          success: false,
          error: 'Title parameter is required',
          message: 'Title is required for search'
        });
        return;
      }

      const books = await this.googleBooksService.searchByTitleAndAuthor(
        title as string,
        author as string
      );

      const convertedBooks = books.map(book => this.googleBooksService.convertToBook(book));

      res.status(200).json({
        success: true,
        data: convertedBooks
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        error: 'Failed to search books by title and author',
        message: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  };
}





