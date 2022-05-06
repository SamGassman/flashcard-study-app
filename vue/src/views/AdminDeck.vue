<template>
    <div class="deck-details">
        <admin-deck-details />

        <admin-list-cards />
    </div>
</template>

<script>
import AdminListCards from '../components/AdminListCards.vue'
import AdminDeckDetails from '../components/AdminDeckDetails.vue'
export default {
    name: 'deck',
    
    components: {
        AdminListCards, 
        AdminDeckDetails,
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

