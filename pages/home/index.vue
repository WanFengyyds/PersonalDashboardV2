<script setup lang="ts">
</script>

<template>
    <div class="home-page">
        <div class="home-hero">
            <HomeHero />
        </div>
        <div class="features-section">
            <HomeFeatures />
        </div>
    </div>
</template>


<style scoped>
.home-page {
    width: 100%;
}

.home-hero {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    width: 100%;
    background-color: #f2e8cf;
}

.features-section {
    padding: 4rem 2rem;
    background-color: #e8dfc7;
}
</style>

