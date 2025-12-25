import { getSupabase } from "../db/supabase";
import { AuthSession } from '@supabase/supabase-js'

export class AuthService {
    
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