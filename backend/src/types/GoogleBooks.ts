export interface GoogleBooksVolumeInfo {
  title: string;
  subtitle?: string;
  authors?: string[];
  publisher?: string;
  publishedDate?: string;
  description?: string;
  industryIdentifiers?: Array<{
    type: string;
    identifier: string;
  }>;
  pageCount?: number;
  categories?: string[];
  averageRating?: number;
  ratingsCount?: number;
  imageLinks?: {
    smallThumbnail?: string;
    thumbnail?: string;
    small?: string;
    medium?: string;
    large?: string;
    extraLarge?: string;
  };
  language?: string;
  previewLink?: string;
  infoLink?: string;
  canonicalVolumeLink?: string;
}

export interface GoogleBooksVolume {
  id: string;
  volumeInfo: GoogleBooksVolumeInfo;
  saleInfo?: {
    country: string;
    saleability: string;
    isEbook: boolean;
  };
  accessInfo?: {
    country: string;
    viewability: string;
    embeddable: boolean;
    publicDomain: boolean;
  };
}

export interface GoogleBooksResponse {
  kind: string;
  totalItems: number;
  items: GoogleBooksVolume[];
}

export interface GoogleBooksSearchParams {
  q: string;
  startIndex?: number;
  maxResults?: number;
  orderBy?: 'relevance' | 'newest';
  printType?: 'all' | 'books' | 'magazines';
  filter?: 'partial' | 'full' | 'free-ebooks' | 'paid-ebooks' | 'ebooks';
}





