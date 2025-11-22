import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import dotenv from 'dotenv';
import { bookRoutes } from './routes/bookRoutes';
import { googleBooksRoutes } from './routes/googleBooksRoutes';
import { errorHandler } from './middleware/errorHandler';

// 環境変数を読み込み
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// ミドルウェアの設定
app.use(helmet()); // セキュリティヘッダー
app.use(cors()); // CORS設定
app.use(morgan('combined')); // ログ出力
app.use(express.json()); // JSONパーサー
app.use(express.urlencoded({ extended: true })); // URLエンコードパーサー

// ルートの設定
app.use('/api/books', bookRoutes);
app.use('/api/google-books', googleBooksRoutes);

// ヘルスチェックエンドポイント
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'Yomiru Backend API is running',
    timestamp: new Date().toISOString()
  });
});

// 404ハンドラー
app.use('*', (req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Route ${req.originalUrl} not found`
  });
});

// エラーハンドラー
app.use(errorHandler);

// サーバー起動
app.listen(PORT, () => {
  console.log(`🚀 Server is running on port ${PORT}`);
  console.log(`📚 Yomiru Backend API is ready!`);
});

export default app;
