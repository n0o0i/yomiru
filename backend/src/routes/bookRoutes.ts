import express from 'express';
import { BookController } from '../controllers/BookController';
import { validateBook } from '../middleware/validation';

const router = express.Router();
const bookController = new BookController();

// 本の一覧取得
router.get('/', bookController.getBooks);

// 本の詳細取得
router.get('/:id', bookController.getBookById);

// 本の追加
router.post('/', validateBook, bookController.createBook);

// 本の更新
router.put('/:id', validateBook, bookController.updateBook);

// 本の削除
router.delete('/:id', bookController.deleteBook);

// 本の検索
router.get('/search/:query', bookController.searchBooks);

export { router as bookRoutes };





