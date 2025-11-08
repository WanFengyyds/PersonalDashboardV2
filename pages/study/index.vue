<script setup lang="ts">
// Authentication requirement to access the study planner page
definePageMeta({
  middleware: 'auth'
})
</script>

<template>
  <main>
    <div class="header">
      <h1 class="dashboard-title">Study Planner</h1>
      <p class="dashboard-subtitle">Organize your learning journey</p>
    </div>
    <div class="content">
      <div class="placeholder">
        <div class="icon">📚</div>
        <h2>Study Features Coming Soon</h2>
        <p>This section will help you manage your studies, track progress, and stay organized.</p>
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

.content {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 3rem;
  min-height: 400px;
}

.placeholder {
  text-align: center;
  max-width: 500px;
  padding: 3rem;
  background: rgba(255, 255, 255, 0.6);
  border-radius: 1.5rem;
  border: 1px solid rgba(167, 201, 87, 0.2);
}

.icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
}

.placeholder h2 {
  font-size: 1.8rem;
  font-weight: 600;
  color: #a7c957;
  margin-bottom: 1rem;
}

.placeholder p {
  color: rgba(56, 102, 65, 0.7);
  font-size: 1.1rem;
  line-height: 1.6;
}
</style>
