// middleware/auth.js
export default defineNuxtRouteMiddleware((to, from) => {
  // Check if session exists in localStorage
  // Use process.client to ensure this only runs on client-side
  if (process.client) {
    const session = localStorage.getItem('session')
    
    if (!session) {
      // Redirect to login if no session
      return navigateTo('/login')
    }
  }
})