// import Express from "express";
import { Context } from 'hono';
import { AuthService } from '../services/auth.service';
import app, { Bindings, Variables } from '../index';

type AppContext = Context<{ Bindings: Bindings, Variables: Variables}>;

export class AuthController {
    private authService = new AuthService();

    public isEmailAndIdAvailable = async (c: AppContext) => {
        try {
            const { email, userId } = await c.req.json();
            const isEmailAvailable = await this.authService.isAvailable(c.env, 'email', email);
            const isIdAvailable = await this.authService.isAvailable(c.env, 'user_id', userId);

            if(!isEmailAvailable){
                return c.json({
                    success: false,
                    message: 'CONFLICT_EMAIL'
                }, 409);
            } else if (!isIdAvailable){
                return c.json({
                    success: false,
                    message: 'CONFLICT_USER_ID'
                }, 409);
            } else {   
                return c.json({
                    success: true,
                    message: 'The email and ID are available.',
                }, 200);
            }
        } catch (e: any) {
            const status = e.message === 'CONFLICT_USER_ID' || 'CONFLICT_EMAIL' ? 409: 400;
            return c.json({
                success: false,
                message: e.message
            }, status);
        }
    }

    public createProfile = async (c: Context) => {
        try {
            const {id, userId, displayName, email} = await c.req.json();
            const result = await this.authService.createProfile(c.env, id, userId,displayName, email);
            console.log(result);
            if(result.status == 201) {
                return c.json({
                    success: true,
                    message: result.statusText
                }, 201)
            } else {
                return c.json({
                    success: false,
                    message: 'Failed to create user profile'
                }, 400)
            }
        } catch (e: any) {
            console.log(e);
            return c.json({
                success: false,
                message: e.message
            }, 400);
        }
    }

    public signUpCallback = async (c: Context) => {
        const code = c.req.query('code');
        if (!code) {
            return c.text('無効なリクエストです（コードが見つかりません）', 400);
        }

        // const { data, error} = await this.authService.exchangeCodeForSession(c.env, code);

        // if (error || !data.session) {
        //     return c.text('認証に失敗しました', 401);
        // }

        // const accessToken = data.session.access_token;
        // const refreshToken = data.session.refresh_token;

        // const appUrl = `yomiru://login-callback?access_token=${accessToken}&refresh_token=${refreshToken}`;
        const appUrl = `yomiru://login-callback?code=${code}`;

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