import { supabase  } from "../db/index";
import { AuthSession } from '@supabase/supabase-js'

export class AuthService {
    async login (email: string, password: string): Promise<{session: AuthSession | null, user: any | null}> {
        const {data, error} = await supabase.auth.signInWithPassword({email, password});
        if (error) throw new Error(error.message);
        return {session: data.session, user: data.user};
    }

    async refreshToken (refreshToken: string) {
        const {data, error} = await supabase.auth.refreshSession({refresh_token: refreshToken});
        if (error) throw new Error(error?.message || 'Failed to refresh session.');
        if (!data.session) throw new Error('Failed to retrieve new session');

        return {
            access_token: data.session.access_token,
            refresh_token: data.session.refresh_token
        };
    }

    async logout() {
        const {error} = await supabase.auth.signOut();
        if (error) console.log("Supabase sign out error: ", error.message);
    }
}