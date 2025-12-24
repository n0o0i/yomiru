import Express from "express";
import { supabase } from '../db/supabase';
import {AuthService} from '../services/auth.service';
import { protect } from '../middleware/auth'
import { rootCertificates } from "tls";

const router = Express.Router();
const authService = new AuthService;

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
router.post('/login', async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const result = await authService.login(email, password);    
                
        return res.status(200).json({success: true, data: {session: result.session}});
    } catch (e) {
        return next(e); 
    }
});

// POST /api/v1/auth/logout
router.post('/logout', protect, async (req, res, next) => {
    try {
        await authService.logout();    
        return res.status(200).json({success: true});
    } catch (e) {
        return next(e); 
    }
});

// POST /api/v1/auth/token/refresh
router.post('/token/refresh', async (req, res, next) => {
    try {
        const {refresh_token} = req.body;
        if (!refresh_token) {
            return res.status(400).json({success: false, message:'Refresh token is required.'});
        }

        const tokens = await authService.refreshToken(refresh_token);
        return res.status(200).json({sucess: true, data:tokens});
    } catch (e) {
        return res.status(401).json({success: false, message: "Invalid or expired refresh token."});
    }
})


// GET /api/v1/auth/callback
router.get('/callback', async (req, res) => {
    return res.status(200).send('Email confirmation successful! You can now close this window and return to the app.');
});

export default router;