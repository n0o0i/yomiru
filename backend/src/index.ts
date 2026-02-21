// import express from 'express';
// import cors from 'cors';
// import helmet from 'helmet';
// import morgan from 'morgan';
// import * as dotenv from 'dotenv';
import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { logger } from 'hono/logger';
import { secureHeaders } from 'hono/secure-headers';
import { v1 } from './routes/v1';
import { User } from '@supabase/supabase-js';

import { bookRoutes } from './routes/bookRoutes';
import { errorHandler } from './middleware/errorHandler';
import mybooksRoutes from './routes/mybooks';
import { timeStamp } from 'console';

// 環境変数を読み込み
// dotenv.config();
export type Variables = {
  user: User;
}

export type Bindings = {
  SUPABASE_URL : string;
  SUPABASE_ANON_KEY: string;
  RAKUTEN_APP_ID: string;
  RAKUTEN_APP_SECRET: string;
  RAKUTEN_AFFILIATE_ID: string;
}

const app = new Hono<{ Bindings: Bindings, Variables: Variables}>();

// const app = express();
// const PORT = process.env.PORT || 3000;

// ミドルウェアの設定
// app.use(helmet()); // セキュリティヘッダー
// app.use(cors()); // CORS設定
// app.use(morgan('combined')); // ログ出力
// app.use(express.json()); // JSONパーサー
// app.use(express.urlencoded({ extended: true })); // URLエンコードパーサー
app.use('*', secureHeaders());
app.use('*', cors(
  {
  origin: 'https://f420041b.yomiru.pages.dev', // Flutter Webの実行URL（ポート番号に注意）
  allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowHeaders: ['Content-Type', 'Authorization'],
  exposeHeaders: ['Content-Length'],
  maxAge: 600,
  credentials: true,
}
));
app.use('*', logger());

// ルートの設定
// app.use('/api/v1/auth', authRoutes);
// app.use('/api/books', bookRoutes);
// app.use('/api/google-books', googleBooksRoutes);
// app.use('/api/v1/mybooks', mybooksRoutes);

// ヘルスチェックエンドポイント
// app.get('/api/v1/health', (req, res) => {
//   res.status(200).json({
//     status: 'OK',
//     message: 'Yomiru Backend API is running',
//     timestamp: new Date().toISOString()
//   });
// });
app.route('/api/v1', v1);

// 404ハンドラー
// app.use('*', (req, res) => {
//   res.status(404).json({
//     error: 'Not Found',
//     message: `Route ${req.originalUrl} not found`
//   });
// });
app.notFound((c) => {
  return c.json({
    error: 'Not Found',
    message: `Route ${c.req.path} not found`
  });
});

// エラーハンドラー
// app.use(errorHandler);
app.onError((err, c) => {
  console.error(`${err}`);
  return c.json({
    error: 'Internal Server Error',
    message: err.message
  }, 500);
});

// サーバー起動
// app.listen(PORT, () => {
//   console.log(`🚀 Server is running on port ${PORT}`);
//   console.log(`📚 Yomiru Backend API is ready!`);
// });

export default app;