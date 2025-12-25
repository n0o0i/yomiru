import { createMiddleware } from 'hono/factory';
import { getSupabase } from '../db/supabase';
import { Bindings, Variables} from '../index';

// declare global {
//     namespace Express {
//         interface Request {
//             user?: any; // ユーザーデータを格納するためのプロパティ
//         }
//     }
// }

export const protect = createMiddleware<{ Bindings: Bindings, Variables: Variables}>(async (c, next)=> {
    let token: string | undefined;

    const authHeader = c.req.header('Authorization');
    if (authHeader && authHeader.startsWith('Bearer')) {
        token = authHeader.split(' ')[1];
    }

    if (!token) {
        return c.json({success: false, message: 'Not authorized, no token.'}, 401);
    }

    try {
        const supabase = getSupabase(c.env);
        const { data: { user }, error} = await supabase.auth.getUser(token);

        if (error || !user) {
            return c.json({success: false, message: 'Not authorized, invalid token.'});
        }

        c.set('user', user);

        return await next();
    } catch (error) {
        console.error('Token validation server error:', error);
        return c.json({success: false, message: 'Server error'}, 401);
    }
});