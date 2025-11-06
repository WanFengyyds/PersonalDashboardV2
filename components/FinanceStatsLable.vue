<script setup lang="ts"></script>

<template>
  <main>
    <div class="stats-grid">
      <div class="stats-card">
        <!-- TODO Waiting for backend and database to load data of real money -->
        <div>
          <h1 class="balance-title">Total Balance</h1>
          <p class="balance-number money">$ 0.00</p>
        </div>
      </div>
      <div class="stats-card">
        <div>
          <h1 class="balance-title">Total income</h1>
          <p class="income-number money">$ 0.00</p>
        </div>
      </div>
      <div class="stats-card">
        <div>
          <h1 class="balance-title">Total expences</h1>
          <p class="expences-number money">$ 0.00</p>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
/* Placement for 3 cards balance income and expences */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  padding: 1.5rem;
  height: auto;
  min-height: 180px;
}
.stats-card {
  background: rgba(30, 30, 40, 0.6);
  backdrop-filter: blur(10px);
  width: 100%;
  height: auto;
  min-height: 140px;
  border-radius: 1.25rem;
  margin: 0 auto;
  padding: 1.75rem;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  border: 1px solid rgba(252, 237, 47, 0.2);
}

.stats-card::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(252, 237, 47, 0.1) 0%, transparent 70%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

/* Animation when hover card */
.stats-card:hover {
  box-shadow:
    0 12px 40px rgba(252, 237, 47, 0.15),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
  transform: translateY(-5px);
  border-color: rgba(252, 237, 47, 0.4);
}

.stats-card:hover::before {
  opacity: 1;
}

.stats-card:nth-child(2) {
  background: rgba(30, 30, 40, 0.6);
  border: 1px solid rgba(252, 237, 47, 0.2);
}

.stats-card:nth-child(3) {
  background: rgba(30, 30, 40, 0.6);
  border: 1px solid rgba(252, 237, 47, 0.2);
}

.stats-card h1 {
  color: rgba(252, 237, 47, 0.9);
}

/* Stats showing part of the cards */
.balance-title {
  font-size: 0.85em;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.6);
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 0.75rem;
}
.balance-number {
  color: #ffffff;
}
.money {
  font-size: 2.5em;
  font-weight: 700;
  color: #ffffff;
  letter-spacing: -0.02em;
  text-shadow: 0 2px 10px rgba(252, 237, 47, 0.2);
}
.income-number {
  color: #ffffff;
}
.expences-number {
  color: #ffffff;
}
</style>
