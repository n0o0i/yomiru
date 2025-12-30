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
            console.log('calling service.signUp');
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
        // console.log('🔥🔥 Honoのコールバックが呼ばれました！');
        // const code = c.req.query('code');
        // console.log('🔥🔥 code！', code);
            const allQueries = c.req.query(); // すべてのクエリを取得
            console.log('届いたクエリ一覧:', allQueries);

            const code = c.req.query('code');
            const tokenHash = c.req.query('token_hash'); // PKCEでない場合に届くことがある

            console.log('Code:', code);
            console.log('Token Hash:', tokenHash);
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