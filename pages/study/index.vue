<script setup lang="ts">
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
  color: #ffffff;
  letter-spacing: -0.02em;
  text-shadow: 0 0 30px rgba(255, 214, 10, 0.3);
}

.dashboard-subtitle {
  color: rgba(255, 255, 255, 0.6);
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
  background: rgba(30, 30, 40, 0.6);
  border-radius: 1.5rem;
  border: 1px solid rgba(255, 214, 10, 0.2);
}

.icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
}

.placeholder h2 {
  font-size: 1.8rem;
  font-weight: 600;
  color: #FFD60A;
  margin-bottom: 1rem;
}

.placeholder p {
  color: rgba(255, 255, 255, 0.7);
  font-size: 1.1rem;
  line-height: 1.6;
}
</style>
