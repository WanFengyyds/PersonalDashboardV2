import { supabase } from '~/server/utils/supabase';

// POST /api/auth/login - User login, Endpoint to authenticate users
export default defineEventHandler(async (event) => {
  try {
    // Read the request body and extract email and password
    const body = await readBody(event);
    const { email, password } = body;

    // Test if i recived the mail
    console.log('Login attempt for email:', email);

    // Check if both fields are provided
    if (!email || !password) {
      // If not provided, set response status to bad request
      setResponseStatus(event, 400);
      return {
        error: 'Email and password are required'
      };
    }

    // if everything went well, Call Supabase authentication method to verify credentials
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password
    });

    // Log Supabase response for debugging
    console.log('Supabase response data:', data);
    console.log('Supabase response error:', error);

    // check if supabase returned an error, if yes, handle it
    if (error) {
      console.error('Login error:', error);
      // Set response status to 401 (Unauthorized)
      setResponseStatus(event, 401);
      return {
        error: error.message
      };
    }

    // If login successful, return user data and session token
    return {
      message: 'Login successful',
      user: data.user,
      session: data.session
    };
  } catch (err) {
    // Catch any unexpected errors
    console.error('Login error:', err);
    // Set response status to 500 (Internal Server Error)
    setResponseStatus(event, 500);
    return {
      error: 'Internal server error'
    };
  }
});
