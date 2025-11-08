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
    color: #386641;
}

.features-section h2 {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 3rem;
    color: #386641;
    text-shadow: 0 0 20px rgba(106, 153, 78, 0.2);
}

.feauture-list {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    margin-top: 2rem;
}

.feature-card {
    background: rgba(164, 184, 196, 0.4);
    backdrop-filter: blur(10px);
    border: 2px solid rgba(106, 153, 78, 0.3);
    border-radius: 1.25rem;
    padding: 2.5rem 2rem;
    box-shadow: 0 4px 15px rgba(56, 102, 65, 0.1);
    transition: all 0.3s ease;
    text-align: center;
}

.feature-card:hover {
    transform: translateY(-8px);
    background: rgba(164, 184, 196, 0.5);
    border-color: rgba(106, 153, 78, 0.6);
    box-shadow: 0 12px 30px rgba(106, 153, 78, 0.2);
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
    color: #386641;
}

.feature-card p {
    font-size: 1rem;
    line-height: 1.6;
    color: rgba(56, 102, 65, 0.8);
    margin: 0;
}
.highlight {
    color: #6a994e;
    text-shadow: 0 0 15px rgba(167, 201, 87, 0.4);
}
</style>
