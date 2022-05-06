<template>
  <div class="start-study-session">
    <form
      class="session-form"
      v-on:submit.prevent="
        startSession = true;
        onSubmit();
      "
      v-if="!startSession"
    >
      <button
        class="small-purple-btn skew-btn"
        v-bind:class="{ 'session-form-selected': isRandom }"
        id="isRandom"
        v-on:click.prevent="isRandom = !isRandom"
      >
        <div>Randomize Cards</div>
      </button>
      <button
        class="small-purple-btn skew-btn"
        id="isTimed"
        v-bind:class="{ 'session-form-selected': isTimed }"
        v-on:click.prevent="isTimed = !isTimed"
      >
        <div>Add Timer</div>
      </button>
      <label for="timer" v-if="isTimed">Seconds Per Card</label>
      <input
        type="number"
        id="timer"
        placeholder="Time per card in seconds"
        v-model="timerInput"
        min="1"
        v-if="isTimed"
      />
      <button class="session-form-submit small-navy-btn skew-btn" type="submit">
        <div>Begin Session</div>
      </button>
    </form>
    <div id="show-cards" v-else>
      <deck-details class="study-deck-name" />
      <div
        class="card-timer small-navy-btn skew-btn"
        v-if="isTimed && !endSession"
      >
        <div>{{ timer }}</div>
      </div>
      <div class="current-study-session" v-if="!endSession">
        <button class="current-flash-card purple-btn" v-on:click="toggleFlip()">
          <h3 class="current-card-front" v-show="!showBack">
            {{ currentCard.cardFront }}
          </h3>
          <img
            id="card-image-study"
            :src="currentCard.cardImage"
            alt="card image"
            v-show="!showBack && currentCard.cardImage"
          />
          <h3 class="current-card-back" v-show="showBack">
            {{ currentCard.cardBack }}
          </h3>
        </button>
        <div
          class="answer-btns"
          v-bind:class="{ 'answer-btns-fade-in': showBack }"
        >
          <button
            class="mark-incorrect skew-btn small-purple-btn"
            v-show="showBack"
            v-on:click="markIncorrect"
          >
            <div>Incorrect</div>
          </button>

          <button
            class="mark-correct skew-btn small-new-teal-btn"
            v-show="showBack"
            v-on:click="markCorrect"
          >
            <div>Correct</div>
          </button>
        </div>
        <div style="background-color: white"><button
          class="end-study-session-btn small-navy-btn skew-btn"
          v-on:click="endSession = true"
          v-if="!endSession"
        >
          <div>End Study Session</div>
        </button></div>
      </div>

      <div class="end-study-session" v-else>
        <div>
          <button
            class="small-new-teal-btn cards-correct"
            v-bind:class="{ 'cards-correct-animate': endSession }"
          >
            <h3>{{ correct }}</h3>
          </button>
          <img
            class="results-correct-check"
            src="../assets/checkmark-outline.svg"
            v-bind:class="{ 'cards-correct-check-animate': endSession }"
            alt=""
          />
        </div>
        <div>
          <button
            class="small-navy-btn cards-incorrect"
            v-bind:class="{ 'cards-correct-animate': endSession }"
          >
            <h3>{{ incorrect }}</h3>
          </button>
          <img
            class="results-incorrect-check"
            src="../assets/close.svg"
            v-bind:class="{ 'cards-incorrect-check-animate': endSession }"
            alt=""
          />
        </div>
        <div style="background-color: white; position: absolute; bottom: 30px"><button
          class="
            end-study-session-btn
            small-navy-btn
            skew-btn
            results-start-new-session
          "
          v-on:click="$router.push({ name: 'studysession' })"
        >
          <div>Start A New Session</div>
        </button></div>
      </div>
    </div>
  </div>
</template>

<script>
import cardService from "../services/CardService";
import DeckDetails from "./DeckDetails.vue";
export default {
  name: "start-study-session",
  components: {
    DeckDetails,
  },
  data() {
    return {
      cards: [],
      randomCards: [],
      currentCard: {},
      currentCardIndex: 0,
      showBack: false,
      correct: 0,
      incorrect: 0,
      endSession: false,
      timer: 10,
      timerInput: 10,
      isTimed: false,
      isRandom: false,
      startSession: false,
      testTimer: false,
    };
  },
  methods: {
    toggleFlip() {
      const cardClasses = document.querySelector(".current-flash-card");
      cardClasses.classList.remove("flip-card-animate");
      setTimeout(() => {
        cardClasses.classList.add("flip-card-animate");
      }, 50);

      setTimeout(() => {
        this.showBack = !this.showBack;
      }, 200);
    },
    toggleFlipAnimate(cardId) {
      console.log(cardId);
    },
    markCorrect() {
      this.correct++;
      if (this.cards.length > this.currentCardIndex + 1) {
        this.currentCardIndex++;
        this.currentCard = this.cards[this.currentCardIndex];
        this.showBack = false;
        this.timer = this.timerInput;
        if (this.isRandom) {
          this.currentCard = this.randomCards[this.currentCardIndex];
        }
        if (!this.isRandom) {
          this.currentCard = this.cards[this.currentCardIndex];
        }
      } else {
        this.endSession = true;
      }
    },
    markIncorrect() {
      this.incorrect++;
      if (this.cards.length > this.currentCardIndex + 1) {
        this.currentCardIndex++;

        this.showBack = false;
        this.timer = this.timerInput;
        if (this.isRandom) {
          this.currentCard = this.randomCards[this.currentCardIndex];
        }
        if (!this.isRandom) {
          this.currentCard = this.cards[this.currentCardIndex];
        }
      } else {
        this.endSession = true;
      }
    },
    studyTimer() {
      if (this.isTimed === true) {
        if (this.timer > 0) {
          setTimeout(() => {
            this.timer -= 1;
            this.studyTimer();
          }, 1000);
        }
        if (!this.endSession && this.timer === 0) {
          this.markIncorrect();
          this.timer = this.timerInput;
          this.studyTimer();
        }
        if (this.endSession === true) {
          return;
        }
      }
    },
    randomizeDeck(cards) {
      if (this.isRandom === true) {
        for (var i = cards.length; --i; ) {
          var j = Math.floor(Math.random() * (i + 1));
          var temp = cards[i];
          cards[i] = cards[j];
          cards[j] = temp;
        }
      }
      this.randomCards = cards;
    },

    onSubmit() {
      if (this.isRandom) {
        this.randomizeDeck(this.cards);
        this.currentCard = this.randomCards[0];
      }
      if (this.isTimed) {
        this.timer = this.timerInput;
        this.studyTimer();
      }
    },
  },
  created() {
    cardService.getCardsInDeck(this.$route.params.deckId).then((response) => {
      this.cards = response.data;
      this.currentCard = this.cards[0];
    });
  },
  
};
</script>

<style>
.session-form {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
#card-image-study {
  max-height: 100%;
  max-width:50%;
  border-width: 4px;
  border-color: rgba(255, 255, 255, 0.603);
  border-style: solid;
  border-radius: 10px;
}
.session-form button {
  height: 50px;
  padding: 0;
  transition: 0.2s;
}
.session-form-submit {
  height: 70px !important;
  margin-top: 50px;
  transition: 0.2s;
}
.session-form label {
  text-align: center;
}
.session-form-selected {
  
  box-shadow: 0 0 2px 5px aqua;
}
.study-deck-name {
  flex-grow: 1;
}
.card-timer {
  text-align: center;
  width: 10%;
  margin: auto;
}
.current-study-session {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  height: 30vh;
  flex-grow: 2;
}
.start-study-session {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.end-study-session-btn {
  margin-bottom: 40px;
  height: 50px;
  padding: 5px 30px;
  transition: 0.2s;
}
.end-study-session {
  flex-grow: 3;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.end-study-session div button h3 {
  font-size: 6vw;
  font-weight: bold;
}
.results-start-new-session {
  position: relative;
}
.end-study-session div {
  display: flex;
  justify-content: center;
  gap: 3vw;
}
.cards-correct,
.cards-incorrect {
  width: 18vw;
  height: 20vh;
  opacity: 0;
  border-color: rgba(255, 255, 255, 0.589);
  border-style: solid;
}
.cards-correct:hover,
.cards-incorrect:hover {
  cursor: default;
}
.cards-correct {
  animation-delay: 0.5s;
}
.cards-incorrect {
  animation-delay: 1.5s;
}
.cards-correct-animate {
  animation-name: cards-correct-animate;
  animation-duration: 0.3s;
  animation-fill-mode: forwards;
}
@keyframes cards-correct-animate {
  0% {
    transform: rotateX(90deg);
  }
  10% {
    opacity: 1;
  }
  80% {
    transform: rotateX(0deg);
    transform: scale(1.1);
    border-width: 2px;
  }
  90% {
    border-width: 20px;
  }
  100% {
    border-width: 4px;
    opacity: 1;
  }
}
.results-correct-check,
.results-incorrect-check {
  width: 13vw;
  border-radius: 20vh;
  opacity: 0;
}
.results-incorrect-check {
  opacity: 0;
}
.cards-correct-check-animate {
  animation-name: cards-correct-check-animate;
  animation-duration: 1s;
  animation-delay: 1s;
  animation-fill-mode: forwards;
}
.cards-incorrect-check-animate {
  animation-name: cards-correct-check-animate;
  animation-duration: 1s;
  animation-delay: 2s;
  animation-fill-mode: forwards;
}
@keyframes cards-correct-check-animate {
  0% {
    transform: scale(0);
  }
  10% {
    opacity: 1;
  }
  20% {
    transform: scale(1.1);
  }
  30% {
    transform: scale(1);
  }
  40% {
    box-shadow: 0 0 5px aqua;
  }
  50% {
    box-shadow: 0 0 20px aqua;
  }
  60% {
    box-shadow: 0 0 5px aqua;
  }

  100% {
    box-shadow: none;
    opacity: 1;
  }
}
.answer-btns {
  flex-grow: 1;
  width: 50%;
  display: flex;
  opacity: 0;
  transition: opacity 0.2s;
  transition-delay: 0.1s;
  justify-content: center;
}
.answer-btns-fade-in {
  opacity: 1;
}
@keyframes answer-btns-fadein {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
#show-cards {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 100%;
}
.current-flash-card {
  height: 30vh;
  width: 30vw;
  box-shadow: 0px 3px 8px gray;
  display: flex;
  border-width: 4px;
  border-style: solid;
  transition: 0.2s;
  border-color: rgba(255, 255, 255, 0.315);
}
.current-flash-card:hover {
  border-color: aqua;
}
.mark-correct,
.mark-incorrect {
  height: 5vh;
  padding: 0 15px;
  transition: 0.2s;
  
}
.skew-btn {
  transform: skew(-13deg);
}
.skew-btn > * {
  transform: skew(13deg);
}
</style>