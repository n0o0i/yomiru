import { getSupabase } from "../db/supabase";
import { AuthSession } from '@supabase/supabase-js'

export interface SignUpResponse {
    email: string,
    userId: string,
    isConfirmed: false
}

export class AuthService {
    async isAvailable (env: any, column: string, value: string): Promise<Boolean> {
        const supabase = getSupabase(env);

        const existing = await supabase
            .from('profiles')
            .select(column)
            .eq(column, value)
            .maybeSingle();

            return existing.data == null ? true : false;
        
        // const existingEmail = await isAvailable('email', email);        
        // if (existingEmail) throw new Error ('CONFLICT_EMAIL');
        
        // const existingUserId = await isAvailable('user_id', userId);
        // if (existingUserId) throw new Error ('CONFLICT_USER_ID');
        
        // console.log('calling supabase signup');
        // console.log(`${env.API_URL}/api/v1/auth/callback`);
        // const { data, error } = await supabase.auth.signUp({
        //     email,
        //     password,
        //     options : {emailRedirectTo: `${env.API_URL}/api/v1/auth/callback`}
        // });

        // if (error) throw error;

        // if (data.user) {
        //     await supabase.from('profiles').insert({ id: data.user.id, user_id: userId, email: email});
        // } 

        // return false;
    }

    async exchangeCodeForSession(env: any, code: any) {
        const supabase = getSupabase(env);
        return await supabase.auth.exchangeCodeForSession(code);
    }
    
    async login (env: any, email: string, password: string): Promise<{session: AuthSession | null, user: any | null}> {
        const supabase = getSupabase(env);
        
        const {data, error} = await supabase.auth.signInWithPassword({email, password});
        if (error) throw new Error(error.message);
        return {session: data.session, user: data.user};
    }
    
    async refreshToken (env:any, refreshToken: string) {
        const supabase = getSupabase(env);
        
        const {data, error} = await supabase.auth.refreshSession({refresh_token: refreshToken});
        if (error) throw new Error(error?.message || 'Failed to refresh session.');
        if (!data.session) throw new Error('Failed to retrieve new session');
        
        return {
            access_token: data.session.access_token,
            refresh_token: data.session.refresh_token
        };
    }
    
    async logout(env: any) {
        const supabase = getSupabase(env);

        const {error} = await supabase.auth.signOut();
        if (error) console.log("Supabase sign out error: ", error.message);
    }
}