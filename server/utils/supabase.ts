import { createClient } from '@supabase/supabase-js';

// Get Supabase URL and API key from environment variables
const supabaseUrl = process.env.SUPABASE_URL || '';
const supabaseKey = process.env.SUPABASE_KEY || '';

// Validate environment variables
if (!supabaseUrl || !supabaseKey) {
  console.warn('⚠️ Supabase credentials not found in environment variables');
}

// Create and export a Supabase client instance
export const supabase = createClient(supabaseUrl, supabaseKey);
