<script setup lang="ts">
// Authentication requirement to access the finance page
definePageMeta({
  middleware: 'auth'
})
</script>

<template>
  <main>
    <div class="header">
      <h1 class="dashboard-title">Personal finance view</h1>
      <p class="dashboard-subtitle">Track and manage your money smartly</p>
    </div>
    <div class="trasaction-history">
      <FinanceStatsLable />
      <div class="history-add">
        <AddTransaction />
        <TransactionHistory />
      </div>
    </div>
  </main>
</template>

<style scoped>
.header {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 2.5rem;
  margin-bottom: 1rem;
  gap: 0.5rem;
}
.dashboard-title {
  font-size: 3em;
  font-weight: 700;
  color: #386641;
  letter-spacing: -0.02em;
  text-shadow: 0 0 30px rgba(167, 201, 87, 0.3);
}
.dashboard-subtitle {
  color: rgba(56, 102, 65, 0.7);
  font-size: 1.15em;
  font-weight: 400;
  letter-spacing: 0.01em;
}
.trasaction-history {
  display: flex;
  flex-direction: column;
  justify-content: center;
  margin-top: 2rem;
}
.history-add {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: flex-start;
  gap: 2rem;
  margin: 0 3rem;
}
.history-add > * {
  flex: 1 1 420px;
  min-width: 320px;
  box-sizing: border-box;
}
</style>
