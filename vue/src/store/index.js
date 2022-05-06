import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if (currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    token: currentToken || '',
    user: currentUser || {},
    editDeck: {
      deckId: 0,
      deckName: "",
      deckDescription: "",
      subId: 0
    },
    editCard: {
      cardId: 0,
      cardFront: "",
      cardBack: "",
      cardImage: "",
      tags: []
    },
    cards: [],
    decks: [],
  },

  mutations: {
    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user', JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    },
    SET_CARDS(state, cards){
      state.cards = cards;
    },
    SET_DECKS(state, decks){
      state.decks = decks;
    },
    EDIT_DECK(state, deck) {
      state.editDeck.deckId = deck.deckId;
      state.editDeck.deckName = deck.deckName;
      state.editDeck.deckDescription = deck.deckDescription;
      state.editDeck.subId = deck.subId;
    },
    EDIT_CARD(state, card) {
      state.editCard.cardId = card.cardId;
      state.editCard.cardFront = card.cardFront;
      state.editCard.cardBack = card.cardBack;
      state.editCard.cardImage = card.cardImage;
      state.editCard.tags = card.tags;
    },
    
  }
})
