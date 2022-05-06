import axios from 'axios';

export default {

  addDeck(deck) {
    return axios.post('/deck', deck)
  },
  myDecks(id){
      return axios.get(`/deck/mydecks/${id}`)
  },
  editDeck(deck) {
    return axios.put('/deck/mydecks', deck)
  },
  deleteDeck(id){
    return axios.delete(`/deck/mydecks/${id}`)
  },
  getDeck(deckId){
    return axios.get(`/deck/${deckId}`)
  },
  getPublicDecks(){
    return axios.get('/deck')
  },
  getDecksForStudy(userId){
    return axios.get(`/deck/study/${userId}`)
  },
  submitDeckForAdminApproval(deckId){
    return axios.post(`/deck/submit/${deckId}`)
  },
  getDecksAwaitingApproval(){
    return axios.get('deck/admin')
  },
  adminApproveDeck(subId){
    return axios.put(`/deck/admin/approve/${subId}`)
  },
  adminDenyDeck(subId){
    return axios.delete(`/deck/admin/deny/${subId}`)
  }
}
