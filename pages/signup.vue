<script setup lang="ts">
import { ref, onMounted } from 'vue';

const email = ref('');
const password = ref('');
const confirmPassword = ref('');
const loading = ref(false);
const error = ref('');
const success = ref(false);

onMounted(() => {
  if (localStorage.getItem('session')) {
    navigateTo('/finance', { replace: true });
  }
});

const handleSignup = async () => {
  error.value = '';
  loading.value = true;

  if (password.value !== confirmPassword.value) {
    error.value = 'Passwords do not match';
    loading.value = false;
    return;
  }

  if (password.value.length < 6) {
    error.value = 'Password must be at least 6 characters';
    loading.value = false;
    return;
  }

  try {
    const response: any = await $fetch('/api/auth/signup', {
      method: 'POST',
      body: {
        email: email.value,
        password: password.value
      }
    });

    if (response?.user) {
      success.value = true;
      setTimeout(() => {
        navigateTo('/login');
      }, 2000);
    }
  } catch (err: any) {
    console.error('Signup failed:', err);
    error.value = err.data?.error || 'Signup failed. Please try again.';
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <main class="signup-container">
    <div class="signup-box">
      <div class="signup-header">
        <h1 class="signup-title">KaiPlanner</h1>
        <p class="signup-subtitle">Create your account</p>
      </div>

      <form @submit.prevent="handleSignup" class="signup-form">
        <div v-if="error" class="error-message">
          {{ error }}
        </div>

        <div v-if="success" class="success-message">
          Account created successfully! Redirecting to login...
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
            :disabled="loading || success"
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
            :disabled="loading || success"
          />
        </div>

        <div class="form-group">
          <label for="confirmPassword">Confirm Password</label>
          <input
            type="password"
            id="confirmPassword"
            v-model="confirmPassword"
            class="input-box"
            placeholder="Confirm your password"
            required
            :disabled="loading || success"
          />
        </div>

        <button type="submit" class="signup-button" :disabled="loading || success">
          <span v-if="!loading && !success">Sign Up</span>
          <span v-else-if="loading">Creating account...</span>
          <span v-else>Success!</span>
        </button>

        <div class="signup-footer">
          <p>Already have an account? <NuxtLink to="/login" class="login-link">Sign in</NuxtLink></p>
        </div>
      </form>
    </div>
  </main>
</template>

<style scoped>
.signup-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.signup-box {
  background: rgba(164, 184, 196, 0.4);
  backdrop-filter: blur(20px);
  border-radius: 1.5rem;
  padding: 3rem;
  width: 100%;
  max-width: 450px;
  box-shadow: 
    0 8px 32px rgba(56, 102, 65, 0.15),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
  border: 2px solid rgba(106, 153, 78, 0.3);
}

.signup-header {
  text-align: center;
  margin-bottom: 2.5rem;
}

.signup-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #386641;
  text-shadow: 0 0 30px rgba(167, 201, 87, 0.2);
  margin-bottom: 0.5rem;
  letter-spacing: -0.01em;
}

.signup-subtitle {
  color: rgba(56, 102, 65, 0.7);
  font-size: 1.1rem;
  font-weight: 400;
}

.signup-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.error-message {
  background: rgba(248, 113, 113, 0.15);
  border: 1px solid rgba(248, 113, 113, 0.3);
  color: #dc2626;
  padding: 1rem;
  border-radius: 0.75rem;
  font-size: 0.9rem;
  text-align: center;
  font-weight: 500;
}

.success-message {
  background: rgba(167, 201, 87, 0.15);
  border: 1px solid rgba(106, 153, 78, 0.3);
  color: #386641;
  padding: 1rem;
  border-radius: 0.75rem;
  font-size: 0.9rem;
  text-align: center;
  font-weight: 500;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-group label {
  font-size: 0.85rem;
  font-weight: 600;
  color: rgba(56, 102, 65, 0.9);
  letter-spacing: 0.02em;
  text-transform: uppercase;
}

.input-box {
  padding: 1rem 1.25rem;
  border: 2px solid rgba(106, 153, 78, 0.2);
  border-radius: 0.75rem;
  color: #386641;
  font-size: 1rem;
  font-weight: 500;
  background: rgba(242, 232, 207, 0.6);
  transition: all 0.2s ease-in-out;
  outline: none;
}

.input-box:focus {
  border-color: rgba(106, 153, 78, 0.6);
  box-shadow: 0 0 0 3px rgba(167, 201, 87, 0.1);
  background: rgba(242, 232, 207, 0.9);
}

.input-box:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.input-box::placeholder {
  color: rgba(56, 102, 65, 0.4);
  font-weight: 400;
}

.signup-button {
  margin-top: 1rem;
  padding: 1.125rem 1.5rem;
  background: linear-gradient(135deg, #6a994e 0%, #386641 100%);
  color: #f2e8cf;
  border: none;
  border-radius: 0.75rem;
  font-size: 1.05rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow:
    0 4px 15px rgba(106, 153, 78, 0.3),
    0 0 20px rgba(106, 153, 78, 0.1);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.signup-button:hover:not(:disabled) {
  box-shadow:
    0 6px 20px rgba(106, 153, 78, 0.4),
    0 0 30px rgba(106, 153, 78, 0.2);
  transform: translateY(-2px);
}

.signup-button:active:not(:disabled) {
  transform: translateY(0);
  box-shadow:
    0 4px 15px rgba(106, 153, 78, 0.3),
    0 0 20px rgba(106, 153, 78, 0.1);
}

.signup-button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.signup-footer {
  text-align: center;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 1px solid rgba(106, 153, 78, 0.2);
}

.signup-footer p {
  color: rgba(56, 102, 65, 0.7);
  font-size: 0.95rem;
}

.login-link {
  color: #a7c957;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.2s ease;
}

.login-link:hover {
  color: #6a994e;
  text-decoration: underline;
}

@media (max-width: 640px) {
  .signup-box {
    padding: 2rem 1.5rem;
  }

  .signup-title {
    font-size: 2rem;
  }

  .signup-subtitle {
    font-size: 1rem;
  }
}
</style>