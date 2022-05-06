<template>
  <div class="list-decks">
    <div class="deck navy-btn btn btn-lg btn-primary btn-block" id="ld-deck"
      v-on:mouseover="currentdeck = deck.deckId" 
      v-on:mouseleave="currentdeck = 0" 
      v-for="deck in decks" 
      v-bind:key="deck.deckId" 
      v-on:click.self="viewDeck(deck)">
      <div class="hover-btn">
        <img class="edit" src="../assets/cog.svg" v-show="currentdeck == deck.deckId" v-on:click="editDeck(deck)" />
        <img class="edit" src="../assets/close.svg" v-show="currentdeck == deck.deckId" v-on:click="deleteDeck(currentdeck)" />

      </div>
      <h3 class="listdecks-deck-text" v-on:click.self="viewDeck(deck)">{{ deck.deckName }}</h3>
    </div>
  </div>
</template>

<script>
import deckService from "../services/DeckService";
export default {
  name: "list-decks",
  data() {
    
    return {
      showbutton: false,
      currentdeck: 0
      
      
    };
  },
  methods: {
    viewDeck(deck){
      this.$store.commit("EDIT_DECK", deck)
      this.$router.push({name: 'deck', params: {deckId: deck.deckId}})
    },
    editDeck(deck) {
      this.$store.commit("EDIT_DECK", deck)
      this.$router.push({name: "editdeck", params: {deckId: this.currentdeck}})
    },
    deleteDeck(id){
      deckService.deleteDeck(id).then(() => {
        deckService.myDecks(this.$store.state.user.userId).then((response) => {this.$store.commit("SET_DECKS", response.data )});
      });
    }
  },
  created() {

    deckService.myDecks(this.$store.state.user.userId).then((response) => {this.$store.commit("SET_DECKS", response.data )});
  },
  computed: {
    decks(){
      return this.$store.state.decks
    }
  }
};
</script>

<style>
.deck {
  width: 30%;
  height: 20vh !important;
  padding: 10px;
  display: flex;
  flex-direction: column;
  border-width: 3px;
  border-color: rgba(255, 255, 255, 0.301);
  border-style: solid;
}
#ld-deck.deck{
  cursor: default !important;
}
.deck:hover{
  border-color: rgba(255, 255, 255, 0.753);
}
.listdecks-deck-text{
  pointer-events: none;
  text-align: center;
}
button {
  background-color: grey;
}
.list-decks{
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
  margin-top: 40px;
}
a:hover{
  text-decoration: none;

}
h3{
  flex-grow: 1;
}
.hover-btn{
  height: 40px;
  width: 100%;
  display: flex;
  justify-content: space-between;
}
.edit{
  width: 40px;
  filter: invert();
}
</style>