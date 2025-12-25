import { v4 as uuidv4 } from 'uuid';
import { Book, CreateBookRequest, UpdateBookRequest, BookQueryParams } from '../types/Book';
import { getSupabase } from '../db/supabase';

export class BookService {
  // 本の一覧取得
  public async getBooks(env: any, queryParams: BookQueryParams): Promise<Book[]> {
    const supabase = getSupabase(env);

    let query = supabase
      .from('books')
      .select('*');
    
    if (queryParams.status) {
      query = query.eq('status', queryParams.status);
    }

    if (queryParams.search) {
      query = query.or(`title.ilike.%${queryParams.search}%,author.ilke.%${queryParams.search}%`);
    }

    const page = queryParams.page || 1;
    const limit = queryParams.limit || 10;
    const from = (page - 1) * limit;
    const to = from + limit - 1;
    query = query.range(from, to).order('created_at', {ascending: false});

    const {data, error} = await query;

    if (error) {
      throw new Error(`Supabase error: ${error.message}`);
    }

    return data as Book[];
  }

  public async createBook(env: any, bookData: CreateBookRequest): Promise<Book>{
    const supabase = getSupabase(env);

    const { data, error } = await supabase
      .from('books')
      .insert([
        {
          ...bookData,
          // tags: bookData.tags || [],
        }
      ])
      .select()
      .single();

    if (error) {
      throw new Error(`Supabase error: ${error.message}`);
    }

    return data as Book;  
  }
}