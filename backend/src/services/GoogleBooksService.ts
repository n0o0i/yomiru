import axios from 'axios';
import { GoogleBooksResponse, GoogleBooksSearchParams, GoogleBooksVolume } from '../types/GoogleBooks';

export class GoogleBooksService {
  private readonly baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  private readonly apiKey: string;

  constructor() {
    this.apiKey = process.env.GOOGLE_BOOKS_API_KEY || '';
  }

  // 本を検索
  public async searchBooks(params: GoogleBooksSearchParams): Promise<GoogleBooksResponse> {
    try {
      const searchParams = {
        q: params.q,
        startIndex: params.startIndex || 0,
        maxResults: params.maxResults || 10,
        orderBy: params.orderBy || 'relevance',
        printType: params.printType || 'books',
        filter: params.filter || 'partial',
        key: this.apiKey
      };

      const response = await axios.get<GoogleBooksResponse>(this.baseUrl, {
        params: searchParams,
        timeout: 10000
      });

      return response.data;
    } catch (error) {
      console.error('Google Books API Error:', error);
      throw new Error('Failed to search books from Google Books API');
    }
  }

  // 本の詳細を取得
  public async getBookById(volumeId: string): Promise<GoogleBooksVolume | null> {
    try {
      const response = await axios.get<GoogleBooksVolume>(`${this.baseUrl}/${volumeId}`, {
        params: { key: this.apiKey },
        timeout: 10000
      });

      return response.data;
    } catch (error) {
      console.error('Google Books API Error:', error);
      return null;
    }
  }

  // ISBNで本を検索
  public async searchByISBN(isbn: string): Promise<GoogleBooksVolume | null> {
    try {
      const response = await this.searchBooks({
        q: `isbn:${isbn}`,
        maxResults: 1
      });

      return response.items.length > 0 ? response.items[0] : null;
    } catch (error) {
      console.error('Google Books API Error:', error);
      return null;
    }
  }

  // タイトルと著者で本を検索
  public async searchByTitleAndAuthor(title: string, author?: string): Promise<GoogleBooksVolume[]> {
    try {
      let query = `intitle:${title}`;
      if (author) {
        query += `+inauthor:${author}`;
      }

      const response = await this.searchBooks({
        q: query,
        maxResults: 10
      });

      return response.items;
    } catch (error) {
      console.error('Google Books API Error:', error);
      return [];
    }
  }

  // 画像URLを取得（最適なサイズを選択）
  public getImageUrl(volumeInfo: any, size: 'small' | 'medium' | 'large' = 'medium'): string | null {
    if (!volumeInfo.imageLinks) {
      return null;
    }

    const imageLinks = volumeInfo.imageLinks;
    
    switch (size) {
      case 'small':
        return imageLinks.smallThumbnail || imageLinks.thumbnail || null;
      case 'medium':
        return imageLinks.thumbnail || imageLinks.small || imageLinks.medium || null;
      case 'large':
        return imageLinks.large || imageLinks.extraLarge || imageLinks.medium || imageLinks.thumbnail || null;
      default:
        return imageLinks.thumbnail || null;
    }
  }

  // Google BooksのデータをアプリのBook形式に変換
  public convertToBook(googleBook: GoogleBooksVolume): any {
    const volumeInfo = googleBook.volumeInfo;
    
    return {
      googleBooksId: googleBook.id,
      title: volumeInfo.title,
      subtitle: volumeInfo.subtitle,
      author: volumeInfo.authors ? volumeInfo.authors.join(', ') : 'Unknown Author',
      authors: volumeInfo.authors || [],
      publisher: volumeInfo.publisher,
      publishedDate: volumeInfo.publishedDate,
      description: volumeInfo.description,
      isbn: this.extractISBN(volumeInfo.industryIdentifiers),
      pageCount: volumeInfo.pageCount,
      categories: volumeInfo.categories || [],
      averageRating: volumeInfo.averageRating,
      ratingsCount: volumeInfo.ratingsCount,
      imageUrl: this.getImageUrl(volumeInfo, 'medium'),
      language: volumeInfo.language,
      previewLink: volumeInfo.previewLink,
      infoLink: volumeInfo.infoLink
    };
  }

  // ISBNを抽出
  private extractISBN(industryIdentifiers?: Array<{type: string, identifier: string}>): string | null {
    if (!industryIdentifiers) return null;
    
    const isbn13 = industryIdentifiers.find(id => id.type === 'ISBN_13');
    const isbn10 = industryIdentifiers.find(id => id.type === 'ISBN_10');
    
    return isbn13?.identifier || isbn10?.identifier || null;
  }
}





