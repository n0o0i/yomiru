import { EmailOptions } from "joi";
import { getSupabase } from "../db/supabase";
import { AuthSession } from '@supabase/supabase-js'

export interface SignUpResponse {
    email: string,
    userId: string,
    isConfirmed: false
}

export class AuthService {
    async isAvailable (env: any, column: string, value: string): Promise<Boolean> {
        try {
            console.log(`Checking ${value} is available`);
            console.log(`colum: ${column}`);
            console.log(`value: ${value}`);
            const supabase = getSupabase(env);
            
            const {data, error} = await supabase
            .from('profiles')
            .select(column)
            .eq(column, value)
            .maybeSingle();
            console.log(data);
            console.log(data == null);
            if(error) throw new Error(error.message);
            return data == null? true: false;
        } catch (e: any) {
            console.log(`[Error] ${e}`);
            throw new Error(e);
        }
    }
    
    async createProfile(env: any, id: String, userId: String, displayName: String, email: String): Promise<void> {
        console.log(`Creating a user profile for ${id}`);
        const supabase = getSupabase(env);
        try {
            console.log(`id: ${id}`);
            console.log(`userId: ${userId}`);
            console.log(`displayName: ${displayName}`);
            console.log(`email: ${email}`);

            const {data, error} = await supabase
            .from('profiles')
            .insert({
                id: id,
                user_id: userId,
                display_name: displayName,
                email: email
            });
            if (error) throw error.message;
        } catch (error: any) {
            console.log(`[Error] Creating a user profile for ${id}.`);
            console.log(`[Error] ${error}.`);
            throw new Error(error);
        }
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