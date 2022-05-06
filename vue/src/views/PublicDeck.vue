<template>
    <div class="deck-details">
        <deck-details />

        <list-public-cards />
    </div>
</template>

<script>
import ListPublicCards from '../components/ListPublicCards.vue'
import DeckDetails from '../components/DeckDetails.vue'
export default {
    name: 'publicdeck',
    
    components: {
        ListPublicCards, 
        DeckDetails,
    },
    
}
</script>

<style>
.add-study{
    display: flex;
    justify-content: space-between;
    margin-left: 2vw;
    margin-right: 2vw;
}
.deck-start-study{
    height: 50px;
    padding: 0 30px;
}
</style>

