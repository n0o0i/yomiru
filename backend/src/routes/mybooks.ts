import express from 'express';
import { protect } from '../middleware/auth';
import { supabase } from '../db/supabase';

const router = express.Router();

/**
 * GET /api/v1/mybooks
 * 認証済みユーザーの読書ログ一覧を取得します。
 */
router.get('/', protect, async (req, res) => {
    const userId = req.user.id;
    try {
        const { data: userBooks, error } = await supabase
            .from('user_book_relations')
            .select('*, books(*)')
            .eq('user_id', userId);
    
        if (error) {
            console.error('Database fetch error: ', error);
            return res.status(500).json({ message: 'Failed to fetch user books.', details: error.message});
        }

        return res.status(200).json({ 
            message: 'My book list retrieved successfully.',
            data: userBooks
        });

    } catch (error) {
        console.error('Server error: ', error);
        return res.status(500).json({ message: 'Server error while fetching user books.'});
    }
});

/**
 * POST /api/v1/mybooks
 * 認証済みユーザーが新しい書籍を読書ログに登録します。
 */
router.post('/', protect, async (req, res) => {
    const userId = req.user.id;

    // FIXME!!!!!!!! add needed items
    const {
        book_id,
        status,
        rating,
        notes
    } = req.body;

    const newRelation = {
        user_id: userId,
        book_id: book_id,
        status: status,
        rating: rating,
        notes: notes,
    };

    try {
        const { data, error } = await supabase
            .from('user_book_relations')
            .insert([newRelation])
            .select();

        if (error) {
            //既に登録済の場合もエラーを返す
            return res.status(400).json({ message: 'Failed to add book to log', details: error.message });
        }

        return res.status(201).json({ 
            message: 'Book successfully added to your log.',
            data: data
        }); 

    } catch (error) {
        console.error('Server error: ', error);
        return res.status(500).json({ message: 'Internal server error.'});
    }
});

export default router;