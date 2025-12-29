// import Express from "express";
import { Hono } from 'hono';
import { getSupabase } from '../db/supabase';
import { AuthController } from '../controllers/AuthContoller';
import { protect } from '../middleware/auth'
import { Bindings, Variables } from '../index';
import { rootCertificates } from "tls";

import { AuthService } from '../services/auth.service';
const authService = new AuthService();
// DELETE ME!!!!!!!!!!!!

// const router = Express.Router();
const router = new Hono<{Bindings: Bindings, Variables: Variables}>();
const authController = new AuthController;

// POST /api/v1/auth/signup
router.post('/signup', authController.signUp);

router.get('/callback', authController.signUpCallback);

// POST /api/v1/auth/login
router.post('/login', async (c) => {
    try {
        const { email, password } = await c.req.json();
        const result = await authService.login(c.env, email, password);    
        
        return c.json({
            success: true,
            data: {session: result.session}
        }, 200);
    } catch (e: any) {
        return c.json({
            success: false,
            message: e.message
        }, 400);
    }
});

// POST /api/v1/auth/logout
router.post('/logout', protect, async (c) => {
    try {
        await authService.logout(c.env);    
        return c.json({success: true}, 200);
    } catch (e: any) {
        return c.json({success: false, message: e.message}, 500); 
    }
});

// POST /api/v1/auth/token/refresh
router.post('/token/refresh', async (c) => {
    try {
        const {refresh_token} = await c.req.json();
        if (!refresh_token) {
            return c.json({success: false, message: 'Refresh token is required.'}, 400);
        }

        const tokens = await authService.refreshToken(c.env, refresh_token);
        return c.json({success: true, data: tokens}, 200);
    } catch (e) {
        return c.json({success: false, message: 'Invalid or expired refresh token.'}, 400);
    }
})


// GET /api/v1/auth/callback

export {router as authRoutes};