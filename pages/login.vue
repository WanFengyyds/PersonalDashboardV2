<script setup lang="ts">
import { ref, onMounted } from 'vue';

// Initialize variables
const email = ref('');
const password = ref('');
const loading = ref(false);
const error = ref('');

// Before starting doing the hole thing, check if user already logged in
// Wrapped in onMounted to only run on client-side
onMounted(() => {
  if (localStorage.getItem('session')) {
    navigateTo('/finance', { replace: true });
  }
});

// Handle login form submission
const handleLogin = async () => {
  error.value = '';
  loading.value = true;

  try {
    // Call login API from login.post.ts using /api/auth/login
    const response: any = await $fetch('/api/auth/login', {
      method: 'POST',
      body: {
        email: email.value,
        password: password.value
      }
    });

    // If successful, store session data to local storage, and redirect to finance page
    if (response?.session) {
        // Dont need to store user data beacause it can be fetched from session from a ramdom bug
        localStorage.setItem('session', JSON.stringify(response.session));
        // Redirect to finance page
        navigateTo('/finance');
    }
  } catch (err: any) {
    console.error('Login failed:', err);
    error.value = err.data?.error || 'Login failed. Please try again.';
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <main class="login-container">
    <div class="login-box">
      <div class="login-header">
        <h1 class="login-title">KaiPlanner</h1>
        <p class="login-subtitle">Sign in to your account</p>
      </div>

      <form @submit.prevent="handleLogin" class="login-form">
        <div v-if="error" class="error-message">
          {{ error }}
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input
            type="email"
            id="email"
            v-model="email"
            class="input-box"
            placeholder="Enter your email"
            required
            :disabled="loading"
          />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            v-model="password"
            class="input-box"
            placeholder="Enter your password"
            required
            :disabled="loading"
          />
        </div>

        <button type="submit" class="login-button" :disabled="loading">
          <span v-if="!loading">Sign In</span>
          <span v-else>Signing in...</span>
        </button>

        <div class="login-footer">
          <p>Don't have an account? <a href="#" class="signup-link">Sign up</a></p>
        </div>
      </form>
    </div>
  </main>
</template>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.login-box {
  background: rgba(30, 30, 40, 0.8);
  backdrop-filter: blur(20px);
  border-radius: 1.5rem;
  padding: 3rem;
  width: 100%;
  max-width: 450px;
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 214, 10, 0.2);
}

.login-header {
  text-align: center;
  margin-bottom: 2.5rem;
}

.login-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #FFD60A;
  text-shadow: 0 0 30px rgba(255, 214, 10, 0.3);
  margin-bottom: 0.5rem;
  letter-spacing: -0.01em;
}

.login-subtitle {
  color: rgba(255, 255, 255, 0.7);
  font-size: 1.1rem;
  font-weight: 400;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.error-message {
  background: rgba(248, 113, 113, 0.15);
  border: 1px solid rgba(248, 113, 113, 0.3);
  color: #fca5a5;
  padding: 1rem;
  border-radius: 0.75rem;
  font-size: 0.9rem;
  text-align: center;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-group label {
  font-size: 0.9rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.8);
  letter-spacing: 0.02em;
  text-transform: uppercase;
  font-size: 0.85rem;
}

.input-box {
  padding: 1rem 1.25rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 0.75rem;
  color: #ffffff;
  font-size: 1rem;
  font-weight: 500;
  background: rgba(20, 20, 30, 0.6);
  transition: all 0.2s ease-in-out;
  outline: none;
}

.input-box:focus {
  border-color: rgba(255, 214, 10, 0.6);
  box-shadow: 0 0 0 3px rgba(255, 214, 10, 0.1);
  background: rgba(20, 20, 30, 0.8);
}

.input-box:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.input-box::placeholder {
  color: rgba(255, 255, 255, 0.4);
  font-weight: 400;
}

.login-button {
  margin-top: 1rem;
  padding: 1.125rem 1.5rem;
  background: linear-gradient(135deg, #FFD60A 0%, #ffa500 100%);
  color: #1a1a1a;
  border: none;
  border-radius: 0.75rem;
  font-size: 1.05rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow:
    0 4px 15px rgba(255, 214, 10, 0.3),
    0 0 20px rgba(255, 214, 10, 0.1);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.login-button:hover:not(:disabled) {
  box-shadow:
    0 6px 20px rgba(255, 214, 10, 0.4),
    0 0 30px rgba(255, 214, 10, 0.2);
  transform: translateY(-2px);
}

.login-button:active:not(:disabled) {
  transform: translateY(0);
  box-shadow:
    0 4px 15px rgba(255, 214, 10, 0.3),
    0 0 20px rgba(255, 214, 10, 0.1);
}

.login-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.login-footer {
  text-align: center;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.login-footer p {
  color: rgba(255, 255, 255, 0.6);
  font-size: 0.95rem;
}

.signup-link {
  color: #FFD60A;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.2s ease;
}

.signup-link:hover {
  color: #ffa500;
  text-decoration: underline;
}

@media (max-width: 640px) {
  .login-box {
    padding: 2rem 1.5rem;
  }

  .login-title {
    font-size: 2rem;
  }

  .login-subtitle {
    font-size: 1rem;
  }
}
</style>
