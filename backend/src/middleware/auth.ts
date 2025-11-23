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
        return res.status(401).json({ message: 'Not authorized, no token' });
    }

    try {
        // Supabaseのauth APIを使用してトークンを検証
        const { data, error } = await supabase.auth.getUser(token);

        if (error || !data.user) {
            return res.status(401).json({ message: 'Not authorized, token invalid or expired.' });
        }

        // ユーザーデータをリクエストオブジェクトに添付
        req.user = data.user;
        return next();
    } catch (error) {
        console.error('Token validation server error: ', error);
        return res.status(500).json({ message: 'Server error during token validation' });
    }
};