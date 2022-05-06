<template>
    <div class="public-cards">
        <search-public-cards class="search-cards-view" />
    </div>
</template>

<script>
import SearchPublicCards from '../components/SearchPublicCards.vue'
export default {
    name: 'my-cards',
    data(){
        return {
        }
    },
    components: {
        SearchPublicCards,
    },
}
</script>

<style>
.search-cards-view{
    margin: 0;
}
</style>