-- ============================================================================
-- CATEGORIES TABLE
-- ============================================================================
-- Purpose: Stores transaction categories in a hierarchical structure
-- Features:
--   - Supports parent-child relationships for nested categories
--   - Global categories only (user_id = NULL) - managed by admins
--   - Users can only read categories, not create/modify them
--   - Flexible metadata field for additional category properties
-- ============================================================================

CREATE TABLE categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,                                        -- Category name (e.g., "Food", "Rent")
  parent_id UUID REFERENCES categories(id) ON DELETE CASCADE, -- For subcategories (e.g., "Fast Food" under "Food")
  slug TEXT,                                                 -- URL-friendly identifier
  metadata JSONB DEFAULT '{}'::jsonb,                        -- Additional category data (color, icon, etc.)
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Unique index to prevent duplicate category names within the same parent
CREATE UNIQUE INDEX ux_categories_parent_name ON categories (
  COALESCE(parent_id, '00000000-0000-0000-0000-000000000000'::uuid),
  lower(name)
);

-- Performance index for traversing category hierarchy
CREATE INDEX idx_categories_parent_id ON categories(parent_id);

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) - Categories
-- ============================================================================
-- Users can only read categories, not create/modify/delete them
-- ============================================================================

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- SELECT: All authenticated users can read all categories
CREATE POLICY categories_select_policy ON categories
  FOR SELECT USING (true);

-- No INSERT/UPDATE/DELETE policies - only admins can modify via service role

-- ============================================================================
-- TRANSACTIONS TABLE
-- ============================================================================
-- Purpose: Records all financial transactions (income and expenses)
-- Features:
--   - Always stores positive amounts (type field determines income/expense)
--   - Links to categories for organization
--   - Supports multiple currencies
--   - Flexible metadata for receipts, notes, tags, etc.
-- ============================================================================

CREATE TABLE transactions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,  -- Owner of this transaction
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,       -- Category (nullable if category deleted)
  amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),                   -- Always positive (e.g., 50.00)
  type VARCHAR(10) NOT NULL CHECK (type IN ('income','expense')),      -- Income or Expense
  currency VARCHAR(8) DEFAULT 'USD',                                   -- Currency code (USD, EUR, etc.)
  description TEXT,                                                    -- Transaction description/note
  metadata JSONB DEFAULT '{}'::jsonb,                                  -- Additional data (receipt URL, tags, location)
  created_at TIMESTAMPTZ DEFAULT NOW(),                                -- When record was created
  updated_at TIMESTAMPTZ DEFAULT NOW()                                 -- Last modification time
);

-- Performance indexes for common queries
CREATE INDEX idx_transactions_user_created_at ON transactions (user_id, created_at DESC); -- List user's transactions by date
CREATE INDEX idx_transactions_category_id ON transactions (category_id);                  -- Filter by category

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) - Transactions
-- ============================================================================
-- Ensures complete data isolation: users can ONLY access their own transactions
-- ============================================================================

ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

-- SELECT: Users can only view their own transactions
CREATE POLICY transactions_select_policy ON transactions
  FOR SELECT USING (auth.uid() = user_id);

-- INSERT: Users can only create transactions for themselves
CREATE POLICY transactions_insert_policy ON transactions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- UPDATE: Users can only modify their own transactions
CREATE POLICY transactions_update_policy ON transactions
  FOR UPDATE USING (auth.uid() = user_id);

-- DELETE: Users can only delete their own transactions
CREATE POLICY transactions_delete_policy ON transactions
  FOR DELETE USING (auth.uid() = user_id);

-- ============================================================================
-- SAMPLE DATA - Global Categories
-- ============================================================================
-- These categories are shared by all users (user_id = NULL)
-- ============================================================================

-- Top-level categories
INSERT INTO categories (name, slug, metadata) VALUES
  ('Food & Dining', 'food-dining', '{"icon": "🍔", "color": "#FF6B6B"}'),
  ('Transportation', 'transportation', '{"icon": "🚗", "color": "#4ECDC4"}'),
  ('Shopping', 'shopping', '{"icon": "🛍️", "color": "#95E1D3"}'),
  ('Entertainment', 'entertainment', '{"icon": "🎬", "color": "#F38181"}'),
  ('Bills & Utilities', 'bills-utilities', '{"icon": "💡", "color": "#AA96DA"}'),
  ('Healthcare', 'healthcare', '{"icon": "🏥", "color": "#FCBAD3"}'),
  ('Education', 'education', '{"icon": "📚", "color": "#A8D8EA"}'),
  ('Income', 'income', '{"icon": "💰", "color": "#6BCF7F"}');

-- ============================================================================
-- SUBCATEGORIES
-- ============================================================================
-- Using the actual category IDs from your database
-- ============================================================================

-- Food & Dining Subcategories (parent_id: bede6f72-6021-4527-9746-059af5e22bc7)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Fast Food', 'bede6f72-6021-4527-9746-059af5e22bc7', 'fast-food', '{"icon": "🍟", "color": "#FF6B6B"}'),
  ('Bar', 'bede6f72-6021-4527-9746-059af5e22bc7', 'bar', '{"icon": "🍺", "color": "#FF6B6B"}'),
  ('Canteen', 'bede6f72-6021-4527-9746-059af5e22bc7', 'canteen', '{"icon": "🍱", "color": "#FF6B6B"}'),
  ('Restaurants', 'bede6f72-6021-4527-9746-059af5e22bc7', 'restaurants', '{"icon": "🍽️", "color": "#FF6B6B"}'),
  ('Groceries', 'bede6f72-6021-4527-9746-059af5e22bc7', 'groceries', '{"icon": "🛒", "color": "#FF6B6B"}'),
  ('Coffee Shop', 'bede6f72-6021-4527-9746-059af5e22bc7', 'coffee-shop', '{"icon": "☕", "color": "#FF6B6B"}');

-- Transportation Subcategories (parent_id: 8c2dfab6-9109-41d7-8d9a-485ef9242dde)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Gas', '8c2dfab6-9109-41d7-8d9a-485ef9242dde', 'gas', '{"icon": "⛽", "color": "#4ECDC4"}'),
  ('Public Transit', '8c2dfab6-9109-41d7-8d9a-485ef9242dde', 'public-transit', '{"icon": "🚇", "color": "#4ECDC4"}'),
  ('Parking', '8c2dfab6-9109-41d7-8d9a-485ef9242dde', 'parking', '{"icon": "🅿️", "color": "#4ECDC4"}'),
  ('Taxi/Ride Share', '8c2dfab6-9109-41d7-8d9a-485ef9242dde', 'taxi-ride-share', '{"icon": "🚕", "color": "#4ECDC4"}'),
  ('Car Maintenance', '8c2dfab6-9109-41d7-8d9a-485ef9242dde', 'car-maintenance', '{"icon": "🔧", "color": "#4ECDC4"}');

-- Shopping Subcategories (parent_id: 14185939-108e-409e-af8a-647a12ffc016)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Clothing', '14185939-108e-409e-af8a-647a12ffc016', 'clothing', '{"icon": "👕", "color": "#95E1D3"}'),
  ('Electronics', '14185939-108e-409e-af8a-647a12ffc016', 'electronics', '{"icon": "💻", "color": "#95E1D3"}'),
  ('Home & Garden', '14185939-108e-409e-af8a-647a12ffc016', 'home-garden', '{"icon": "🏡", "color": "#95E1D3"}'),
  ('Personal Care', '14185939-108e-409e-af8a-647a12ffc016', 'personal-care', '{"icon": "🧴", "color": "#95E1D3"}'),
  ('Books & Media', '14185939-108e-409e-af8a-647a12ffc016', 'books-media', '{"icon": "📖", "color": "#95E1D3"}');

-- Entertainment Subcategories (parent_id: 32285c3d-0c09-4993-83c4-a7fa29fe2b0c)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Movies', '32285c3d-0c09-4993-83c4-a7fa29fe2b0c', 'movies', '{"icon": "🎥", "color": "#F38181"}'),
  ('Games', '32285c3d-0c09-4993-83c4-a7fa29fe2b0c', 'games', '{"icon": "🎮", "color": "#F38181"}'),
  ('Concerts', '32285c3d-0c09-4993-83c4-a7fa29fe2b0c', 'concerts', '{"icon": "🎵", "color": "#F38181"}'),
  ('Sports', '32285c3d-0c09-4993-83c4-a7fa29fe2b0c', 'sports', '{"icon": "⚽", "color": "#F38181"}'),
  ('Hobbies', '32285c3d-0c09-4993-83c4-a7fa29fe2b0c', 'hobbies', '{"icon": "🎨", "color": "#F38181"}');

-- Bills & Utilities Subcategories (parent_id: 80fee450-272c-4d48-9a5a-95e114ba0362)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Electricity', '80fee450-272c-4d48-9a5a-95e114ba0362', 'electricity', '{"icon": "⚡", "color": "#AA96DA"}'),
  ('Water', '80fee450-272c-4d48-9a5a-95e114ba0362', 'water', '{"icon": "💧", "color": "#AA96DA"}'),
  ('Internet', '80fee450-272c-4d48-9a5a-95e114ba0362', 'internet', '{"icon": "🌐", "color": "#AA96DA"}'),
  ('Phone', '80fee450-272c-4d48-9a5a-95e114ba0362', 'phone', '{"icon": "📱", "color": "#AA96DA"}'),
  ('Rent', '80fee450-272c-4d48-9a5a-95e114ba0362', 'rent', '{"icon": "🏠", "color": "#AA96DA"}');

-- Healthcare Subcategories (parent_id: eb888260-8813-4e33-a787-506f68299c50)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Doctor', 'eb888260-8813-4e33-a787-506f68299c50', 'doctor', '{"icon": "👨‍⚕️", "color": "#FCBAD3"}'),
  ('Pharmacy', 'eb888260-8813-4e33-a787-506f68299c50', 'pharmacy', '{"icon": "💊", "color": "#FCBAD3"}'),
  ('Dental', 'eb888260-8813-4e33-a787-506f68299c50', 'dental', '{"icon": "🦷", "color": "#FCBAD3"}'),
  ('Insurance', 'eb888260-8813-4e33-a787-506f68299c50', 'insurance', '{"icon": "🛡️", "color": "#FCBAD3"}'),
  ('Fitness', 'eb888260-8813-4e33-a787-506f68299c50', 'fitness', '{"icon": "💪", "color": "#FCBAD3"}');

-- Education Subcategories (parent_id: b4da6070-1a14-4965-ba02-1facfbe83b67)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Tuition', 'b4da6070-1a14-4965-ba02-1facfbe83b67', 'tuition', '{"icon": "🎓", "color": "#A8D8EA"}'),
  ('Books & Supplies', 'b4da6070-1a14-4965-ba02-1facfbe83b67', 'books-supplies', '{"icon": "📚", "color": "#A8D8EA"}'),
  ('Online Courses', 'b4da6070-1a14-4965-ba02-1facfbe83b67', 'online-courses', '{"icon": "💻", "color": "#A8D8EA"}'),
  ('Exam Fees', 'b4da6070-1a14-4965-ba02-1facfbe83b67', 'exam-fees', '{"icon": "📝", "color": "#A8D8EA"}'),
  ('Student Loans', 'b4da6070-1a14-4965-ba02-1facfbe83b67', 'student-loans', '{"icon": "🏦", "color": "#A8D8EA"}');

-- Income Subcategories (parent_id: 344c15dd-961b-4939-bef5-68b92345be33)
INSERT INTO categories (name, parent_id, slug, metadata) VALUES
  ('Salary', '344c15dd-961b-4939-bef5-68b92345be33', 'salary', '{"icon": "💼", "color": "#6BCF7F"}'),
  ('Freelance', '344c15dd-961b-4939-bef5-68b92345be33', 'freelance', '{"icon": "💻", "color": "#6BCF7F"}'),
  ('Investment', '344c15dd-961b-4939-bef5-68b92345be33', 'investment', '{"icon": "📈", "color": "#6BCF7F"}'),
  ('Gifts', '344c15dd-961b-4939-bef5-68b92345be33', 'gifts', '{"icon": "🎁", "color": "#6BCF7F"}'),
  ('Refunds', '344c15dd-961b-4939-bef5-68b92345be33', 'refunds', '{"icon": "↩️", "color": "#6BCF7F"}');

-- ============================================================================
-- SAMPLE DATA - Transactions
-- ============================================================================
-- Example transactions (replace <user_id> and <category_id> with actual UUIDs)
-- ============================================================================

-- NOTE: In production, replace these placeholder IDs with real ones from your auth.users table
-- EXAMPLE:
-- INSERT INTO transactions (user_id, category_id, amount, type, description) VALUES
--   ('<your_user_id>', '<food_category_id>', 45.50, 'expense', 'Dinner at Italian restaurant'),
--   ('<your_user_id>', '<food_category_id>', 85.20, 'expense', 'Weekly grocery shopping'),
--   ('<your_user_id>', '<income_category_id>', 3500.00, 'income', 'Monthly salary'),
--   ('<your_user_id>', '<transportation_id>', 60.00, 'expense', 'Gas fill-up'),
--   ('<your_user_id>', '<entertainment_id>', 25.00, 'expense', 'Movie tickets'),
--   ('<your_user_id>', '<bills_category_id>', 120.00, 'expense', 'Electric bill'),
--   ('<your_user_id>', '<shopping_category_id>', 75.99, 'expense', 'New shoes'),
--   ('<your_user_id>', '<income_category_id>', 500.00, 'income', 'Freelance project payment');

-- ============================================================================
-- USAGE NOTES
-- ============================================================================
-- 1. Run this script in your Supabase SQL editor
-- 2. After creating categories, query their IDs: SELECT id, name FROM categories;
-- 3. Get your user_id from: SELECT id FROM auth.users WHERE email = 'your@email.com';
-- 4. Replace placeholder IDs in INSERT statements with real UUIDs
-- 5. The RLS policies ensure users only see their own data automatically
-- ============================================================================