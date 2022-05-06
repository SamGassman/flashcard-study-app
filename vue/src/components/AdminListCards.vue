<template>
  <div>
    <button
      v-on:click="approveDeck()"
      class="deck-start-study small-new-teal-btn skew-btn">
      <div>Approve Deck</div>
    </button>
    <button
      v-on:click="denyDeck()"
      class="deck-start-study small-lt-btn skew-btn">
      <div>Deny Deck</div>
    </button>
    <div class="list-cards">
      <button
        class="card purple-btn btn btn-lg btn-primary btn-block"
        id="card"
        v-for="card in cards"
        v-bind:key="card.cardId"
        v-bind:value="card.cardId"
        v-on:click="
          toggleFlipAnimate(card.cardId);
          toggleFlip(card.cardId);
        "
        v-on:mouseover="currentCard = card.cardId"
        v-on:mouseleave="currentCard = 0"
      >
        
        <div class="hover-btn">
          <h3
            class="list-cards-text"
            v-show="!showBack.includes(card.cardId)"
          ></h3>
          <h3
            class="list-cards-text"
            v-show="showBack.includes(card.cardId)"
          ></h3>
        </div>
        
        <h3 class="list-cards-text" v-show="!showBack.includes(card.cardId)">
          {{ card.cardFront }}
        </h3>
        <img
          id="card-image"
          :src="card.cardImage"
          alt="card image"
          v-show="!showBack.includes(card.cardId) && card.cardImage"
        />
        <h3 class="list-cards-text" v-show="showBack.includes(card.cardId)">
          {{ card.cardBack }}
        </h3>

      </button>
    </div>
  </div>
</template>

<script>
import cardService from "../services/CardService";
import deckService from "../services/DeckService";
export default {
  name: "list-cards",
  data() {
    return {
      showBack: [],
      currentCard: 0,
    };
  },
  methods: {
    toggleFlip(cardId) {
      if (!this.showBack.includes(cardId)) {
        setTimeout(() => {
          this.showBack.push(cardId);
        }, 200);
      } else {
        setTimeout(() => {
          this.showBack = this.showBack.filter((a) => {
            return a != cardId;
          });
        }, 200);
      }
    },
    toggleFlipAnimate(cardId) {
      console.log(cardId);
      const cardClasses = document.getElementsByClassName("card");
      for (let i = 0; i < cardClasses.length; i++) {
        if (cardClasses[i].value == cardId) {
          cardClasses[i].classList.remove("flip-card-animate");
          setTimeout(() => {
            cardClasses[i].classList.add("flip-card-animate");
          }, 50);
        }
      }
    },
    approveDeck() {
      deckService
        .adminApproveDeck(this.$store.state.editDeck.subId)
        .then(() => {
            deckService.getDecksAwaitingApproval(this.$store.state.user.userId).then((response) => {this.$store.commit("SET_DECKS", response.data )})
            this.$router.push({ name: "admin" })
        });
    },
    denyDeck() {
      deckService
        .adminDenyDeck(this.$store.state.editDeck.subId)
        .then(() => {
            deckService.getDecksAwaitingApproval(this.$store.state.user.userId).then((response) => {this.$store.commit("SET_DECKS", response.data )})
            this.$router.push({ name: "admin" })
        });
    },
  },
  created() {
    cardService
      .getCardsInDeck(parseInt(this.$route.params.deckId))
      .then((response) => {
        this.$store.commit("SET_CARDS", response.data);
      });
  },
  computed: {
    cards() {
      return this.$store.state.cards;
    },
  },
};
</script>

<style>
.card {
  width: 30% !important;
  height: 20vh !important;
  display: flex;
  cursor: default !important;
  overflow: scroll;
  border-width: 3px;
  border-color: rgba(255, 255, 255, 0.301);
  border-style: solid;
  transition: 0.5s;
}
#card-image {
  height: 12vh;
  width: auto;
  margin-bottom: 5px;
}
button#card.card {
  justify-content: center !important;
  align-items: center !important;
  padding: 0 !important;
}
.card-inner {
  height: 100%;
  width: 100%;
  padding: 5px;
  transition-delay: 0.2s;
  transition-duration: 10ms;
}
.flip-card {
  transform: rotateX(180deg);
  box-shadow: 0 -3px 5px gray !important;
}
.flip-card-animate {
  animation-name: flip-card-animate;
  animation-duration: 0.3s;
  animation-fill-mode: forwards;
}
@keyframes flip-card-animate {
  0% {
    transform: rotate3d(0);
  }
  50% {
    transform: rotate3d(1, 0.02, 0, 90deg);
  }
  100% {
    transform: rotate3d(0);
  }
}
.flip-text {
  transform: rotateX(180deg);
}
.card:hover {
  border-color: rgb(56, 255, 255) !important;
}
.card:focus {
  background-color: #593cda;
  border-color: rgba(255, 255, 255, 0.301);

  box-shadow: 0 3px 5px gray;
}
.card::-webkit-scrollbar {
  width: 0px;
  height: 0;
}
.card::-webkit-scrollbar-corner {
  opacity: 0;
}
.list-cards {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 10px;
  margin-top: 40px;
}
a:hover {
  text-decoration: none;
}
.list-cards-text {
  pointer-events: none;
}
.hover-btn {
  height: 40px;
  width: 100%;
  display: flex;
  justify-content: space-between;
}
h3.list-cards-text {
  font-size: 2.2vh;
}
.edit {
  width: 35px;
  cursor: pointer;
  animation-name: hover-btn-fade;
  animation-duration: 0.4s;
}
@keyframes hover-btn-fade {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
.flip-card {
  width: 300px;
  height: 200px;
  perspective: 1000px;
}
.flip-card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  text-align: center;
  transition: transform 0.8s;
  transform-style: preserve-3d;
}
.flip-card.clicked .flip-card-inner {
  transform: rotateY(-180deg);
}
.flip-card-front,
.flip-card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  -webkit-backface-visibility: hidden;
  backface-visibility: hidden;
}
.flip-card-back {
  transform: rotateY(-180deg);
}
</style>