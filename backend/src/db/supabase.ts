// src/supabase.ts
import { createClient, SupabaseClient } from '@supabase/supabase-js';
import { StringLiteralUnion } from 'hono/utils/types';
// import * as dotenv from 'dotenv';

// 開発環境で.envファイルをロード
// dotenv.config();

export const getSupabase = (env: { SUPABASE_URL: string; SUPABASE_ANON_KEY: string}): SupabaseClient => {
    const supabaseUrl = env.SUPABASE_URL;
    const supabaseAnonKey = env.SUPABASE_ANON_KEY;

    if (!supabaseUrl || !supabaseAnonKey){
        throw new Error('SUPABASE_URL and SUPABASE_ANON_KEY must be defined in wrangler.toml or .dev.vars');
    }

    return createClient(supabaseUrl, supabaseAnonKey);
};

// const supabaseUrl = process.env.SUPABASE_URL || '';
// const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || '';

// if (!supabaseUrl || !supabaseAnonKey) {
//     throw new Error('SUPABASE_URL and SUPABASE_ANON_KEY must be defined in .env');
// }

// // 認証が必要な操作にはこのクライアントを使用
// export const supabase = createClient(supabaseUrl, supabaseAnonKey);