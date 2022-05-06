<template>
    <div class="my-cards">
        <search-cards class="search-cards-view" />
    </div>
</template>

<script>
import SearchCards from '../components/SearchCards.vue'
export default {
    name: 'my-cards',
    data(){
        return {
        }
    },
    components: {
        SearchCards,
    },
}
</script>

<style>
.search-cards-view{
    margin: 0;
}
</style>