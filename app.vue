<script setup lang="ts">
</script>

<template>
  <div class="navbar">
    <div>
      <h1 class="title">KaiPlanner</h1>
    </div>
    <div class="options">
      <nav class="button-nav">
        <NuxtLink to="/finance" class="nav-button">Finance</NuxtLink>
        <NuxtLink to="/study" class="nav-button">Study</NuxtLink>
      </nav>
    </div>
  </div>

  <NuxtPage />
</template>

<style scoped>
.page-enter-active,
.page-leave-active {
  transition: all 0.3s ease;
}

.page-enter-from,
.page-leave-to {
  opacity: 0;
  transform: translateY(10px);
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.navbar {
  display: flex;
  position: sticky;
  top: 0;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  padding: 0.75rem 2%;
  background: rgba(30, 30, 40, 0.8);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(252, 237, 47, 0.2);
  color: white;
  z-index: 100;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #fced2f;
  text-shadow: 0 0 20px rgba(252, 237, 47, 0.3);
  letter-spacing: 0.02em;
}

.options {
  display: flex;
  background: rgba(20, 20, 30, 0.6);
  border-radius: 0.75rem;
  padding: 0.25rem;
  border: 1px solid rgba(252, 237, 47, 0.15);
}

.button-nav {
  display: flex;
  gap: 0.25rem;
  position: relative;
  background: rgba(20, 20, 30, 0.6);
  border-radius: 0.75rem;
  padding: 0.25rem;
}

/* Sliding background indicator */
.button-nav::before {
  content: '';
  position: absolute;
  top: 0.25rem;
  left: 0.25rem;
  width: calc(50% - 0.35rem);
  height: calc(100% - 0.5rem);
  background: linear-gradient(135deg, #fced2f 0%, #ffa500 100%);
  border-radius: 0.625rem;
  transition: transform 0.4s cubic-bezier(0.68, -0.55, 0.27, 1.55);
  z-index: 0;
  box-shadow: 0 2px 10px rgba(252, 237, 47, 0.4);
}

/* Move indicator for Study (2nd button) */
.button-nav:has(.nav-button:nth-child(2).router-link-exact-active)::before {
  transform: translateX(calc(100% + 0.25rem));
}

.nav-button {
  padding: 0.625rem 1.5rem;
  color: rgba(255, 255, 255, 0.6);
  font-weight: 600;
  font-size: 0.9rem;
  text-decoration: none;
  border-radius: 0.625rem;
  transition: all 0.3s ease;
  cursor: pointer;
  position: relative;
  z-index: 1;
  flex: 1;
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.nav-button.router-link-exact-active {
  color: #1a1a1a;
  font-weight: 700;
}

@media (max-width: 640px) {
  .navbar {
    padding: 1rem;
  }

  .title {
    font-size: 1.5rem;
  }

  .nav-button {
    padding: 0.6rem 1.5rem;
    font-size: 0.95rem;
  }
}
</style>

<style>
/* Global Styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html {
  font-size: 16px;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  background: linear-gradient(135deg, #0f0f1e 0%, #1a1a2e 50%, #16213e 100%);
  background-attachment: fixed;
  min-height: 100vh;
  color: #ffffff;
  overflow-x: hidden;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Scrollbar styling */
::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
}

::-webkit-scrollbar-thumb {
  background: rgba(252, 237, 47, 0.4);
  border-radius: 5px;
}

::-webkit-scrollbar-thumb:hover {
  background: rgba(252, 237, 47, 0.6);
}

/* Page transitions */
.page-enter-active,
.page-leave-active {
  transition: all 0.3s ease;
}

.page-enter-from,
.page-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
</style>