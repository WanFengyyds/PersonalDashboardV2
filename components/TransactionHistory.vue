<script lang="ts"></script>

<template>
  <main>
    <div class="transaction-history-box">
      <h2 class="history-Title">Transaction History</h2>
      <!-- Placeholder for transaction history list -->
      <ul class="transaction-list">
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 1</span>
          <span class="transaction-amount money">-$50.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
        <li class="transaction-item">
          <span class="transaction-description">Sample Transaction 2</span>
          <span class="transaction-amount money">+$200.00</span>
        </li>
      </ul>
    </div>
  </main>
</template>

<style scoped>
.transaction-history-box {
  background: rgba(30, 30, 40, 0.6);
  backdrop-filter: blur(10px);
  color: #ffffff;
  padding: 2rem;
  border-radius: 1.25rem;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  width: 100%;
  height: 420px;
  box-sizing: border-box;
  margin-top: 2rem;
  border: 1px solid rgba(255, 214, 10, 0.2);
}
.history-Title {
  font-size: 1.5em;
  margin-bottom: 1.5rem;
  color: #ffffff;
  font-weight: 700;
  letter-spacing: -0.01em;
}
.transaction-list {
  list-style-type: none;
  padding: 0;
  max-height: 320px;
  overflow-y: auto;
}

.transaction-list::-webkit-scrollbar {
  width: 6px;
}

.transaction-list::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
}

.transaction-list::-webkit-scrollbar-thumb {
  background: rgba(255, 214, 10, 0.4);
  border-radius: 10px;
}

.transaction-list::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 214, 10, 0.6);
}

.transaction-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 0.75rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
  transition: all 0.2s ease;
  border-radius: 0.5rem;
  margin-bottom: 0.25rem;
}

.transaction-item:hover {
  background-color: rgba(255, 214, 10, 0.05);
  transform: translateX(4px);
  border-left: 3px solid rgba(255, 214, 10, 0.6);
}

.transaction-item:last-child {
  border-bottom: none;
}

.transaction-description {
  font-size: 1.05em;
  color: rgba(255, 255, 255, 0.9);
  font-weight: 500;
}
.transaction-amount {
  font-size: 1.15em;
  font-weight: 700;
  letter-spacing: -0.01em;
}
.money {
  color: rgba(255, 255, 255, 0.8);
}

.transaction-amount.positive {
  color: #4ade80;
}

.transaction-amount.negative {
  color: #f87171;
}
</style>
