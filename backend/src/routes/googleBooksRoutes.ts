import express from 'express';
import { GoogleBooksController } from '../controllers/GoogleBooksController';

const router = express.Router();
const googleBooksController = new GoogleBooksController();

// 本を検索
router.get('/search', googleBooksController.searchBooks);

// 本の詳細を取得
router.get('/details/:volumeId', googleBooksController.getBookDetails);

// ISBNで本を検索
router.get('/isbn/:isbn', googleBooksController.searchByISBN);

// タイトルと著者で本を検索
router.get('/search-by-title', googleBooksController.searchByTitleAndAuthor);

export { router as googleBooksRoutes };





