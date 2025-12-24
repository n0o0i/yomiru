// import express from 'express';
import { Hono } from 'hono';
import { BookController } from '../controllers/BookController';
// import { validateBook } from '../middleware/validation';

// const router = express.Router();
const router = new Hono();
const bookController = new BookController();

// 本の一覧取得
router.get('/', (c) => bookController.getBooks(c));

// 本の詳細取得
router.get('/:id', (c) => bookController.getBookById(c));

// 本の追加
router.post('/', (c) => validateBook, bookController.createBook(c));

// 本の更新
router.put('/:id', (c) => validateBook, bookController.updateBook(c));

// 本の削除
router.delete('/:id', (c) => bookController.deleteBook(c));

// 本の検索
router.get('/search/:query', (c) => bookController.searchBooks(c));

export { router as bookRoutes };





