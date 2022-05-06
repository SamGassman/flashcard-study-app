import axios from 'axios';

export default {

  addCard(card) {
    return axios.post('/card', card)
  },
  getCardsInDeck(id){
      return axios.get(`/card/${id}`)
  },
  editCard(card){
      return axios.put(`/card`, card)
  },
  deleteCard(deckId, cardId){
      return axios.delete(`/card/${deckId}/${cardId}`)
  },
  getCardsByUser(userId){
      return axios.get(`/card/mycards/${userId}`)
  },
  addCardToDeck(cardId, deckId){
    return axios.put(`/card/${deckId}/${cardId}`)
  },
  getPublicCards(){
    return axios.get('/card')
  },
  getCardsForSearch(userId){
    return axios.get(`/card/search/${userId}`)
  }
}
