<template>
  <div class="deck-details">
    <h1 class="deck-details-name">
      {{ deckName }}
      
    </h1>
    <h4 class="deck-details-desc" v-if="$route.name != 'startstudysession'">{{ deckDescription }}</h4>
  </div>
</template>

<script>
import deckService from "../services/DeckService";
export default {
  name: "deck-details",
  data() {
    return {
      deckName: "",
      deckDescription: "",
    };
  },

  created() {
    deckService.getDeck(this.$route.params.deckId).then((response) => {
      this.deckName = response.data.deckName;
      this.deckDescription = response.data.deckDescription;
    });
  },
};
</script>

<style>
.deck-details-name, .deck-details-desc{
    text-align: center;
    margin-bottom: 20px;
}
.deck-details-name{
    line-height: 15vh;
    font-size: 7vh;

}
.deck-details-desc{
    margin-bottom: 50px;
    
}

</style>