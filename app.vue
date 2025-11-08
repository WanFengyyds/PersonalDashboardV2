<script setup lang="ts">
const route = useRoute()

// Check if we're on the home page
const isHomePage = computed(() => {
  return route.path === '/' || route.path === '/home' || route.path === '/login';
})

// Reactive state for login status
const loggedIn = ref(false)

// Check login status on mount and watch for changes
onMounted(() => {
  if (process.client) {
    loggedIn.value = !!localStorage.getItem('session')
    
    // Listen for storage changes (e.g., from login page)
    window.addEventListener('storage', checkLoginStatus)
    
    // Listen for custom event when login happens in same tab
    window.addEventListener('login', checkLoginStatus)
    window.addEventListener('logout', checkLoginStatus)
  }
})

onUnmounted(() => {
  if (process.client) {
    window.removeEventListener('storage', checkLoginStatus)
    window.removeEventListener('login', checkLoginStatus)
    window.removeEventListener('logout', checkLoginStatus)
  }
})

function checkLoginStatus() {
  if (process.client) {
    loggedIn.value = !!localStorage.getItem('session')
  }
}

// Handle logout
function handleLogout() {
  if (process.client) {
    // Clear session from localStorage
    localStorage.removeItem('session')
    localStorage.removeItem('user')
    
    // Dispatch logout event
    window.dispatchEvent(new Event('logout'))
    
    // Redirect to home page
    navigateTo('/home')
  }
}
</script>

<template>
  <div class="navbar">
    <div>
       <NuxtLink to="/home" class="title-link"><h1 class="title">KaiPlanner</h1></NuxtLink>
      
    </div>
    <div class="options" v-if="!isHomePage">
      <nav class="button-nav">
        <NuxtLink to="/finance" class="nav-button">Finance</NuxtLink>
        <NuxtLink to="/study" class="nav-button">Study</NuxtLink>
      </nav>
    </div>
    
    <!-- Login button - only show when NOT logged in -->
    <div class="login-logout" v-if="!loggedIn">
      <NuxtLink to="/login" class="nav-button login-button">
        <span class="login-icon">🔑</span>
        Login
      </NuxtLink>
    </div>
    
    <!-- Logout button - only show when logged in -->
    <div class="login-logout" v-if="loggedIn">
      <button @click="handleLogout" class="nav-button logout-button">
        <span class="logout-icon">🚪</span>
        Logout
      </button>
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
  background: rgba(167, 201, 87, 0.25);
  backdrop-filter: blur(20px);
  border-bottom: 2px solid rgba(106, 153, 78, 0.4);
  color: #386641;
  z-index: 100;
  box-shadow: 0 4px 20px rgba(56, 102, 65, 0.15);
}

.title-link {
  text-decoration: none;
  transition: transform 0.2s ease;
  display: inline-block;
}

.title-link:hover {
  transform: scale(1.05);
}

.title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #386641;
  text-shadow: 0 0 20px rgba(106, 153, 78, 0.2);
  letter-spacing: 0.02em;
  cursor: pointer;
}

.options {
  display: flex;
  background: rgba(242, 232, 207, 0.5);
  border-radius: 0.75rem;
  padding: 0.25rem;
  border: 1px solid rgba(106, 153, 78, 0.2);
}

.button-nav {
  display: flex;
  gap: 0.25rem;
  position: relative;
  background: rgba(242, 232, 207, 0.5);
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
  background: linear-gradient(135deg, #a7c957 0%, #6a994e 100%);
  border-radius: 0.625rem;
  transition: transform 0.4s cubic-bezier(0.68, -0.55, 0.27, 1.55);
  z-index: 0;
  box-shadow: 0 2px 10px rgba(167, 201, 87, 0.4);
}

/* Move indicator for Study (2nd button) */
.button-nav:has(.nav-button:nth-child(2).router-link-exact-active)::before {
  transform: translateX(calc(100% + 0.25rem));
}

.nav-button {
  padding: 0.625rem 1.5rem;
  color: rgba(56, 102, 65, 0.7);
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
  color: #f2e8cf;
  font-weight: 700;
}

/* Login Button Special Styling */
.login-button {
  background: linear-gradient(135deg, #6a994e 0%, #386641 100%);
  color: #f2e8cf !important;
  font-weight: 700;
  border: 2px solid rgba(106, 153, 78, 0.5);
  box-shadow: 0 4px 15px rgba(106, 153, 78, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  position: relative;
  overflow: hidden;
}

.login-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.5s ease;
}

.login-button:hover::before {
  left: 100%;
}

.login-button:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 25px rgba(167, 201, 87, 0.5);
  border-color: rgba(167, 201, 87, 0.8);
}

.login-button:active {
  transform: translateY(-1px);
  box-shadow: 0 3px 15px rgba(167, 201, 87, 0.4);
}

.login-icon {
  font-size: 1.1rem;
  animation: keyBounce 2s ease-in-out infinite;
}

@keyframes keyBounce {
  0%, 100% {
    transform: translateY(0) rotate(0deg);
  }
  50% {
    transform: translateY(-3px) rotate(10deg);
  }
}

/* Logout Button Special Styling */
.logout-button {
  background: rgba(164, 184, 196, 0.15);
  color: #386641 !important;
  font-weight: 700;
  border: 2px solid rgba(106, 153, 78, 0.3);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  position: relative;
  overflow: hidden;
  cursor: pointer;
}

.logout-button::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transition: left 0.5s ease;
}

.logout-button:hover::before {
  left: 100%;
}

.logout-button:hover {
  transform: translateY(-3px);
  background: rgba(164, 184, 196, 0.25);
  border-color: rgba(106, 153, 78, 0.5);
  box-shadow: 0 6px 25px rgba(106, 153, 78, 0.2);
}

.logout-button:active {
  transform: translateY(-1px);
  box-shadow: 0 3px 15px rgba(0, 0, 0, 0.3);
}

.logout-icon {
  font-size: 1.1rem;
}

.login-logout {
  display: flex;
  align-items: center;
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
  background: #f2e8cf;
  background-attachment: fixed;
  min-height: 100vh;
  color: #386641;
  overflow-x: hidden;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Scrollbar styling */
::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background: rgba(242, 232, 207, 0.5);
}

::-webkit-scrollbar-thumb {
  background: rgba(106, 153, 78, 0.5);
  border-radius: 5px;
}

::-webkit-scrollbar-thumb:hover {
  background: rgba(106, 153, 78, 0.7);
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
