<template>
    <div class="my-decks">
        <h1>My Flashcard Decks</h1>
        <add-deck class="add-deck" />
        <list-decks class="list-decks" />
    </div>
</template>

<script>
import AddDeck from '../components/AddDeck.vue'
import ListDecks from '../components/ListDecks.vue'

export default {
    name: 'my-decks',
    data(){
        return {
        }
    },
    components: {
        AddDeck,
        ListDecks,
    },
}
</script>

<style scoped>
h1{
    text-align: center;
}
</style>