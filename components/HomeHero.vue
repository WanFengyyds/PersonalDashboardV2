<script setup lang="ts">
</script>
    
<template>
    <div class="hero">
        <div class="hero-content">
            <h1 class="hero-title">
                Master your <span class="highlight">money</span> & <span class="highlight">studies</span>
            </h1>
            <p class="hero-subtitle">
                The all-in-one platform to track your finances, manage your budget, and stay on top of your academic goals. Simple, powerful, and designed for students.
            </p>
            <div class="hero-actions">
                <NuxtLink to="/login" class="btn btn-primary">
                    <span class="icon">🚀</span>
                    Get Started
                </NuxtLink>
                <NuxtLink to="/finance" class="btn btn-secondary">
                    <span class="icon">👁️</span>
                    View Demo
                </NuxtLink>
            </div>
        </div>
        <div class="hero-preview">
            <div class="preview-content">
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Track Finances</h3>
                    <p>Monitor your income, expenses, and savings in real-time</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🎯</div>
                    <h3>Set Goals</h3>
                    <p>Plan your budget and achieve your financial targets</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📖</div>
                    <h3>Study Smart</h3>
                    <p>Organize your coursework and never miss a deadline</p>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.hero {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
    min-height: 100vh;
    width: 100%;
    max-width: 1400px;
    margin: 0 auto;
    gap: 4rem;
    padding: 2rem 3rem;
}

.hero-content {
    display: flex;
    flex-direction: column;
    gap: 2rem;
    width: 50%;
    flex: 1;
}

.hero-title {
    font-size: 4rem;
    line-height: 1.2;
    margin: 0;
    color: white;
    font-weight: 800;
    letter-spacing: -0.02em;
}

.highlight {
    color: #fced2f;
    text-shadow: 0 0 20px rgba(252, 237, 47, 0.5);
}

.hero-subtitle {
    font-size: 1.25rem;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.75);
    margin: 0;
    max-width: 600px;
}

.hero-actions {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin-top: 1rem;
}

.btn {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 2rem;
    font-size: 1rem;
    font-weight: bold;
    text-decoration: none;
    border-radius: 0.75rem;
    transition: all 0.3s ease;
    cursor: pointer;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

.btn .icon {
    font-size: 1.5rem;
}

.btn-primary {
    background: linear-gradient(135deg, #fced2f 0%, #ffa500 100%);
    color: #1a1a1a;
    box-shadow: 0 4px 15px rgba(252, 237, 47, 0.3);
}

.btn-primary:hover {
    box-shadow: 0 6px 20px rgba(252, 237, 47, 0.5);
    transform: translateY(-2px);
}

.btn-secondary {
    background: rgba(255, 255, 255, 0.1);
    color: #ffffff;
    border: 2px solid rgba(252, 237, 47, 0.3);
    backdrop-filter: blur(10px);
}

.btn-secondary:hover {
    background: rgba(255, 255, 255, 0.15);
    border-color: rgba(252, 237, 47, 0.5);
    transform: translateY(-2px);
}

.hero-preview {
    display: flex;
    flex: 1;
    width: 50%;
    justify-content: center;
    align-items: center;
    padding: 2rem;
}

.preview-content {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1.5rem;
    width: 100%;
    max-width: 500px;
}

.feature-card {
    background: rgba(30, 30, 40, 0.6);
    backdrop-filter: blur(10px);
    border-radius: 1rem;
    border: 1px solid rgba(252, 237, 47, 0.2);
    padding: 1.5rem;
    transition: all 0.3s ease;
}

.feature-card:hover {
    transform: translateY(-4px);
    border-color: rgba(252, 237, 47, 0.4);
    box-shadow: 0 8px 24px rgba(252, 237, 47, 0.15);
}

.feature-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.feature-card h3 {
    font-size: 1.25rem;
    color: #fced2f;
    margin: 0 0 0.5rem 0;
    font-weight: 700;
}

.feature-card p {
    font-size: 0.95rem;
    color: rgba(255, 255, 255, 0.7);
    margin: 0;
    line-height: 1.5;
}
</style>
