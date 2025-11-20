import { supabase } from '~/server/utils/supabase';

// POST /api/auth/signup - User registration
export default defineEventHandler(async (event) => {
  try {
    // Read the request body and extract email and password
    const body = await readBody(event);
    const { email, password } = body;

    // Check if both fields are provided
    if (!email || !password) {
      setResponseStatus(event, 400);
      return {
        error: 'Email and password are required'
      };
    }

    // Validate password length
    if (password.length < 6) {
      setResponseStatus(event, 400);
      return {
        error: 'Password must be at least 6 characters'
      };
    }

    // Call Supabase authentication method to create new user
    const { data, error } = await supabase.auth.signUp({
      email,
      password
    });

    // Log Supabase response for debugging
    console.log('Supabase signup response:', { data, error });

    // Check if Supabase returned an error
    if (error) {
      console.error('Signup error:', error);
      setResponseStatus(event, 400);
      return {
        error: error.message
      };
    }

    // If signup successful, return user data
    return {
      message: 'Signup successful. Please check your email to verify your account.',
      user: data.user,
      session: data.session
    };
  } catch (err) {
    // Catch any unexpected errors
    console.error('Signup error:', err);
    setResponseStatus(event, 500);
    return {
      error: 'Internal server error'
    };
  }
});
