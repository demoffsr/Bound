import Foundation
import Supabase

/// Shared Supabase client instance.
/// Replace URL and key with your actual Supabase project credentials.
let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://YOUR_PROJECT.supabase.co")!,
    supabaseKey: "YOUR_ANON_KEY"
)
