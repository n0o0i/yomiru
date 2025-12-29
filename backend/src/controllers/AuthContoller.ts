// import Express from "express";
import { Context } from 'hono';
import { AuthService } from '../services/auth.service';
import app, { Bindings, Variables } from '../index';

type AppContext = Context<{ Bindings: Bindings, Variables: Variables}>;

export class AuthController {
    private authService = new AuthService();

    public signUp = async (c: AppContext) => {
        try {
            const { email, password, userId } = await c.req.json();
            
            const result = await this.authService.signUp(c.env, email, password, userId);
            return c.json({
                success: true,
                message: 'Confirmation email sent.',
                data: result
            }, 201);
        } catch (e: any) {
            const status = e.message === 'CONFLICT_USER_ID' || 'CONFLICT_EMAIL' ? 409: 400;
            return c.json({
                success: false,
                message: e.message
            }, status);
        }
    }

    public signUpCallback = async (c: Context) => {
        const queries = c.req.queries();

        const appUrl = `yomiru://login-callback?access_token=${queries.access_token}`;

        return c.html(`
            <html>
                <head><meta http-equiv="refresh" content="0;url=${appUrl}"></head>
                <body>
                    <p>認証に成功しました！自動的にアプリに戻ります。</p>
                    <a href="${appUrl}">戻らない場合はこちらをタップ</a>
                </body>
            </html>
        `);
    }
}