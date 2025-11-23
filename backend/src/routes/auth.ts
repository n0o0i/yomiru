import Express from "express";
import { supabase } from '../db/index';

const router = Express.Router();

// POST /api/v1/auth/signup
router.post('/signup', async (req, res) => {
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options : {emailRedirectTo: 'http://localhost:8080/auth/callback'}
    });

    if (error) {
        return res.status(400).json({ error: error.message });
    }

    return res.status(200).json({ 
        message: 'Sign up successfull. Confirmation emain sent.',
        session: data.session
    });
});

// POST /api/v1/auth/login
router.post('/login', async (req, res) => {
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

export default router;