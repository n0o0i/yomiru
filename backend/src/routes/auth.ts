import Express from "express";
import { supabase } from '../db/index';

const router = Express.Router();

// POST /api/v1/auth/signup
router.post('/signup', async (req, res) => {
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options : {emailRedirectTo: 'http://localhost:3000/api/v1/auth/callback'}
    });

    if (error) {
        return res.status(400).json({ error: error.message });
    }

    return res.status(200).json({ 
        message: 'Sign up successfull. Confirmation email sent.',
        session: data.session
    });
});

// POST /api/v1/auth/login
router.post('/login', async (req, res) => {
    console.log('--- DEBUG: [AUTH] SIGN_IN ROUTE HIT ---');
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
    });

    if (error) {
        return res.status(401).json({ message: 'Login failed.'+ error.message });
    }

    return res.status(200).json({
        message: 'Login successful.',
        session: data.session
    });
});

// GET /api/v1/auth/callback
router.get('/callback', async (req, res) => {
    return res.status(200).send('Email confirmation successful! You can now close this window and return to the app.');
});

export default router;