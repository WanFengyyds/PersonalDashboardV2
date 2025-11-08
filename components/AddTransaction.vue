<script lang="ts"></script>

<template>
  <main>
    <div class="transaction-box">
      <h2 class="add-Title">Add New Transaction</h2>
      <!-- Form for adding new transaction -->
      <form-group class="transaction-form">
        <div class="form-group">
          <label for="description">Description</label>
          <input type="text" id="description" name="description" class="input-box" required />
        </div>
        <div class="form-group">
          <label for="amount">Amount</label>
          <input type="number" id="amount" name="amount" class="input-box" required />
        </div>
        <div class="form-group">
          <label for="category">Category</label>
          <select id="type" name="type" class="input-box" required>
            <option value="income">Food and Drinks</option>
            <option value="expense">Games</option>
          </select>
        </div>
        <div class="form-group">
          <label for="type">Type</label>
          <select id="type" name="type" class="input-box" required>
            <option value="income">Income</option>
            <option value="expense">Expense</option>
          </select>
        </div>
        <button type="submit">Add Transaction</button>
      </form-group>
    </div>
  </main>
</template>

<style scoped>
main {
  margin-top: 2rem;
}
.transaction-box {
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);
  color: #386641;
  padding: 2rem;
  border-radius: 1.25rem;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  width: 100%;
  box-sizing: border-box;
  border: 1px solid rgba(167, 201, 87, 0.2);
}

.add-Title {
  font-size: 1.5em;
  margin-bottom: 1.5rem;
  color: #386641;
  font-weight: 700;
  letter-spacing: -0.01em;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 1.25rem;
}

.form-group label {
  font-size: 0.85em;
  font-weight: 600;
  color: rgba(56, 102, 65, 0.7);
  margin-bottom: 0.5rem;
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.input-box {
  padding: 0.875rem 1.125rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 0.75rem;
  color: #386641;
  font-size: 1em;
  font-weight: 500;
  background: rgba(255, 255, 255, 0.4);
  transition: all 0.2s ease-in-out;
  outline: none;
  box-sizing: border-box;
}

.input-box:focus {
  border-color: rgba(167, 201, 87, 0.6);
  box-shadow: 0 0 0 3px rgba(167, 201, 87, 0.1);
  background: rgba(255, 255, 255, 0.6);
}

.input-box:hover {
  border-color: rgba(56, 102, 65, 0.2);
}

/* Placeholder styling */
.input-box::placeholder {
  color: rgba(56, 102, 65, 0.4);
  font-weight: 400;
}

/* Select specific styling */
select.input-box {
  cursor: pointer;
  appearance: none;
  background-repeat: no-repeat;
  background-position: right 0.875rem center;
  padding-right: 2.5rem;
  font-weight: 500;
}

/* Option styling */
select.input-box option {
  padding: 0.75rem 1rem;
  background-color: #1a1a2e;
  color: #386641;
  font-size: 1em;
  font-weight: 500;
  line-height: 1.6;
  cursor: pointer;
}

select.input-box option:hover {
  background-color: rgba(167, 201, 87, 0.1);
  color: #386641;
}

select.input-box option:checked {
  background-color: rgba(167, 201, 87, 0.2);
  color: #a7c957;
  font-weight: 600;
}

select.input-box option:disabled {
  color: rgba(56, 102, 65, 0.3);
  cursor: not-allowed;
}

/* Button styling */
button[type='submit'] {
  margin-top: 0.75rem;
  padding: 1rem 1.5rem;
  background: #f2e8cf 100%);
  color: #386641;
  border: none;
  border-radius: 0.75rem;
  font-size: 1.05em;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow:
    0 4px 15px rgba(167, 201, 87, 0.3),
    0 0 20px rgba(167, 201, 87, 0.1);
  width: 100%;
  letter-spacing: 0.02em;
  text-transform: uppercase;
}

button[type='submit']:hover {
  box-shadow:
    0 6px 20px rgba(167, 201, 87, 0.4),
    0 0 30px rgba(167, 201, 87, 0.2);
  transform: translateY(-2px);
}

button[type='submit']:active {
  transform: translateY(0);
  box-shadow:
    0 4px 15px rgba(167, 201, 87, 0.3),
    0 0 20px rgba(167, 201, 87, 0.1);
}
</style>
