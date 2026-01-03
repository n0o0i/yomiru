// import Express from "express";
import { Context } from 'hono';
import { AuthService } from '../services/auth.service';
import app, { Bindings, Variables } from '../index';

type AppContext = Context<{ Bindings: Bindings, Variables: Variables}>;

export class AuthController {
    private authService = new AuthService();

    public isAvailable = async (c: AppContext) => {
        console.log('--- Auth isAvailable Started ---');
        try {
            const { column, value } = await c.req.json();
            console.log(`Checking ${value} is available.`);
            const isEmailAvailable = await this.authService.isAvailable(c.env, column, value);
            
            if(!isEmailAvailable){
                console.log(`[Error] ${value} already exists`);
                return c.json({
                    success: false,
                    message: 'CONFLICT_VALUE'
                }, 409);
            } else {   
                console.log(`[Success] ${value} is available`);
                return c.json({
                    success: true,
                    message: `${value} is available.`,
                }, 200);
            }
        } catch (e: any) {
            console.log(`[Error] This value already exists`);
            const status = e.message === 'CONFLICT_VALUE' ? 409: 400;
            return c.json({
                success: false,
                message: e.message
            }, status);
        }
    }
    
    public createProfile = async (c: Context) => {
        console.log('--- Auth createProfile Started ---');
        try {
            const {id, userId, displayName, email} = await c.req.json();
            console.log(`Creating a user profile. User ID: ${id}`);
            await this.authService.createProfile(c.env, id, userId,displayName, email);
            console.log(`[Success] User profile created for ${id}`);
            return c.json({
                success: true,
                message: 'Success to create a user profile'
            }, 201)
        } catch (e: any) {
            console.log(`[Error] Failed to created a user profile. Error message: ${e.message}`);
            return c.json({
                success: false,
                message: e.message
            }, 400);
        }
    }
    
    public signUpCallback = async (c: Context) => {
        console.log('--- Auth Callback Started ---');
        const code = c.req.query('code');
        if (!code) {
            return c.text('無効なリクエストです（コードが見つかりません）', 400);
        }
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