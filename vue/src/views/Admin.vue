<template>
  <div>
        <h1 class="deck-details-name">Decks Awaiting Approval</h1>
        <admin-list-decks/>
    </div>
</template>

<script>
import AdminListDecks from '../components/AdminListDecks.vue'
export default {
  components: { AdminListDecks,  },

}
</script>

<style>

</style>