import { createRouter, defineEventHandler, useBase } from 'h3';
import { supabase } from '~/server/utils/supabase';

const router = createRouter();

// GET /api/nested/finance - Get all finance transactions
router.get('/finance', defineEventHandler(async (event) => {
  try {
    // Fetch finance data from Supabase
    const { data, error } = await supabase
      .from('transactions') // Replace with your actual table name
      .select('*')
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching finance data:', error);
      setResponseStatus(event, 500);
      return { error: error.message };
    }

    // Calculate totals
    const balance = data?.reduce((acc, t) => acc + (t.type === 'income' ? t.amount : -t.amount), 0) || 0;
    const income = data?.filter(t => t.type === 'income').reduce((acc, t) => acc + t.amount, 0) || 0;
    const expenses = data?.filter(t => t.type === 'expense').reduce((acc, t) => acc + t.amount, 0) || 0;

    return {
      success: true,
      data: {
        balance,
        income,
        expenses,
        transactions: data || []
      }
    };
  } catch (err) {
    console.error('Finance fetch error:', err);
    setResponseStatus(event, 500);
    return { error: 'Internal server error' };
  }
}));

// POST /api/nested/finance/transaction - Add new transaction
router.post('/finance/transaction', defineEventHandler(async (event) => {
  try {
    const body = await readBody(event);
    const { amount, description, type, category } = body;

    // Validate required fields
    if (!amount || !description || !type) {
      setResponseStatus(event, 400);
      return { error: 'Amount, description, and type are required' };
    }

    // Insert transaction into Supabase
    const { data, error } = await supabase
      .from('transactions') // Replace with your actual table name
      .insert([
        {
          amount,
          description,
          type,
          category,
          created_at: new Date().toISOString()
        }
      ])
      .select();

    if (error) {
      console.error('Error adding transaction:', error);
      setResponseStatus(event, 500);
      return { error: error.message };
    }

    return {
      success: true,
      message: 'Transaction added successfully',
      data: data?.[0]
    };
  } catch (err) {
    console.error('Transaction add error:', err);
    setResponseStatus(event, 500);
    return { error: 'Internal server error' };
  }
}));

// GET /api/nested/study - Get study data
router.get('/study', defineEventHandler(async (event) => {
  try {
    // Fetch study data from Supabase
    const { data, error } = await supabase
      .from('study_tasks') // Replace with your actual table name
      .select('*')
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching study data:', error);
      setResponseStatus(event, 500);
      return { error: error.message };
    }

    return {
      success: true,
      data: {
        tasks: data || []
      }
    };
  } catch (err) {
    console.error('Study fetch error:', err);
    setResponseStatus(event, 500);
    return { error: 'Internal server error' };
  }
}));

// POST /api/nested/study/task - Add new study task
router.post('/study/task', defineEventHandler(async (event) => {
  try {
    const body = await readBody(event);
    const { title, description, deadline } = body;

    // Validate required fields
    if (!title) {
      setResponseStatus(event, 400);
      return { error: 'Title is required' };
    }

    // Insert task into Supabase
    const { data, error } = await supabase
      .from('study_tasks') // Replace with your actual table name
      .insert([
        {
          title,
          description,
          deadline,
          created_at: new Date().toISOString()
        }
      ])
      .select();

    if (error) {
      console.error('Error adding task:', error);
      setResponseStatus(event, 500);
      return { error: error.message };
    }

    return {
      success: true,
      message: 'Task added successfully',
      data: data?.[0]
    };
  } catch (err) {
    console.error('Task add error:', err);
    setResponseStatus(event, 500);
    return { error: 'Internal server error' };
  }
}));

export default useBase('/api/nested', router.handler);
