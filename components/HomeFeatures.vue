<template>
    <div class="features-section">
     <h2>Everything You Need In <span class="highlight">One Place</span></h2>
     <div class="feauture-list">
        <div class="feature-card">
            <div class="feature-icon">💰</div>
            <h3>Smart Financial Tracking</h3>
            <p>Track expenses, set budgets, and visualize your spending patterns with intuitive charts and insights.</p> 
        </div>
        <div class="feature-card">
            <div class="feature-icon">📚</div>
            <h3>Organized Study Planner</h3>
            <p>Manage your coursework, deadlines, and college schedules effectively.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📊</div>
            <h3>Powerful Analytics</h3>
            <p>Get detailed reports on your financial health and study productivity with charts and graphs.</p>
        </div>
         <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <h3>Goal Setting & Budgeting</h3>
            <p>Set and achieve your financial and academic goals with progress tracking and reminders.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🔒</div>
            <h3>Secure & Private</h3>
            <p>Your data is encrypted and protected, ensuring your privacy is maintained.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📱</div>
            <h3>Access Anywhere</h3>
            <p>Seamless experience across all your devices. Manage your life on the go.</p>
        </div>
        </div>
    </div>
</template>

<style scoped>
.features-section {
    max-width: 1400px;
    margin: 0 auto;
    padding: 4rem 2rem;
    text-align: center;
    color: white;
}

.features-section h2 {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 3rem;
    color: white;
    text-shadow: 0 0 20px rgba(255, 214, 10, 0.3);
}

.feauture-list {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    margin-top: 2rem;
}

.feature-card {
    background: rgba(30, 30, 40, 0.6);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 214, 10, 0.2);
    border-radius: 1.25rem;
    padding: 2.5rem 2rem;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
    text-align: center;
}

.feature-card:hover {
    transform: translateY(-8px);
    border-color: rgba(255, 214, 10, 0.4);
    box-shadow: 0 12px 30px rgba(255, 214, 10, 0.15);
}

.feature-icon {
    font-size: 4rem;
    margin-bottom: 1.5rem;
    display: block;
}

.feature-card h3 {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    color: #FFD60A;
}

.feature-card p {
    font-size: 1rem;
    line-height: 1.6;
    color: rgba(255, 255, 255, 0.75);
    margin: 0;
}
.highlight {
    color: #FFD60A;
    text-shadow: 0 0 15px rgba(255, 214, 10, 0.4);
}
</style>
