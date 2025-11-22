export interface Book {
  id: string;
  title: string;
  author: string;
  publisher?: string;
  isbn?: string;
  status: 'read' | 'to_read';
  rating?: number;
  dateAdded: string;
  dateRead?: string;
  memo?: string;
  tags?: string[];
  createdAt: string;
  updatedAt: string;
}

export interface CreateBookRequest {
  title: string;
  author: string;
  publisher?: string;
  isbn?: string;
  status: 'read' | 'to_read';
  rating?: number;
  dateRead?: string;
  memo?: string;
  tags?: string[];
}

export interface UpdateBookRequest {
  title?: string;
  author?: string;
  publisher?: string;
  isbn?: string;
  status?: 'read' | 'to_read';
  rating?: number;
  dateRead?: string;
  memo?: string;
  tags?: string[];
}

export interface BookQueryParams {
  status?: 'read' | 'to_read';
  search?: string;
  page?: number;
  limit?: number;
}





