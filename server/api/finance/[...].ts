import { createRouter, defineEventHandler, useBase, readBody, setResponseStatus } from 'h3';
import { supabase } from '~/server/utils/supabase';

const router = createRouter();

router.post('/description', defineEventHandler(async (event) => {
    try {
        const body = await readBody(event);
        const { user_id } = body;
        
        console.log('Received request body:', body);
        console.log('User ID:', user_id);
        
        // Validate required fields
        if (!user_id) {
            setResponseStatus(event, 400);
            return { error: 'User ID is required' };
        }

        // Fetch descriptions from Supabase
        const { data, error } = await supabase
            .from('transactions')
            .select('description')
            .eq('user_id', user_id)
            .order('description', { ascending: true });
            
        if (error) {
            console.error('Error fetching descriptions:', error); 
            setResponseStatus(event, 500);
            return { error: error.message };
        }
        
        console.log('Fetched data:', data);
        
        return {
            success: true,
            data: data || []
        };
    } catch (err) {
        console.error('Description fetch error:', err);
        setResponseStatus(event, 500);
        return { error: 'Internal server error' };
    }
}));

export default useBase('/api/finance', router.handler);