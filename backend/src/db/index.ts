// src/supabase.ts
import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

// 開発環境で.envファイルをロード
dotenv.config();

const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || '';

if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error('SUPABASE_URL and SUPABASE_ANON_KEY must be defined in .env');
}

// 認証が必要な操作にはこのクライアントを使用
export const supabase = createClient(supabaseUrl, supabaseAnonKey);