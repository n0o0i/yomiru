import { Request, Response, NextFunction } from "express";
import { supabase } from '../db/index';

declare global {
    namespace Express {
        interface Request {
            user?: any; // ユーザーデータを格納するためのプロパティ
        }
    }
}

export const protect = async (req: Request, res: Response, next: NextFunction) => {
    let token;

    // Authorizationヘッダーからトークンを取得
    // token = 'Bearer eyJhbGciOiJIUzI1NiI..'
    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
        token = req.headers.authorization.split(' ')[1];
    }

    if (!token) {
        return res.status(401).json({success: false, message: 'Not authorized, no token' });
    }

    try {
        // Supabaseのauth APIを使用してトークンを検証
        const { data: {user}, error } = await supabase.auth.getUser(token);

        if (error || !user) {
            return res.status(401).json({ message: 'Not authorized, token invalid or expired.' });
        }

        // ユーザーデータをリクエストオブジェクトに添付
        (req as any).user = user;
        return next();
    } catch (error) {
        console.error('Token validation server error: ', error);
        return res.status(401).json({ success: false, message: 'Server error during token validation' });
    }
};