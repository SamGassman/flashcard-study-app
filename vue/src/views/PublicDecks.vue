<template>
    <div class="my-decks">
        <h1>Community Flashcard Decks</h1>
        <list-public-decks class="list-decks" />
    </div>
</template>

<script>
import ListPublicDecks from '../components/ListPublicDecks.vue'

export default {
    name: 'public-decks',
    data(){
        return {
        }
    },
    components: {
        ListPublicDecks,
    },
}
</script>

<style scoped>
h1{
    text-align: center;
}

</style>