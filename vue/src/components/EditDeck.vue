<template>
    <div class="edit-deck">
        <h1>Edit Deck</h1>
        <div class="edit-deck-form">
            <label for="deck-name">Deck Name: </label>
            <input class="form-control" type="text" name="deck-name" id="deck-name" v-model="deck.deckName">
            <label for="deck-description">Deck Description: </label>
            <textarea class="form-control" rows="5" cols="40" name="deck-description" id="deck-description" v-model="deck.deckDescription"></textarea>
            <div class="form-btn">
                <button class="small-navy-btn" v-on:click="editDeck()"><div>Submit</div></button>
                <button class="small-lt-btn" v-on:click="$router.push({name: 'mydecks'})"><div>Cancel</div></button>

            </div>
        </div>
    </div>
</template>

<script>
import deckService from "../services/DeckService";

export default{
    name: 'edit-deck',
    data(){
        return{
            isAddDeckVisible: false,
            deck: {}
        }
    },
    methods: {
        editDeck(){
            
            deckService.editDeck(this.deck).then(() => {
                this.$router.push({name: "mydecks"});
            });
        }
    },
    created() {
        deckService.getDeck(this.$route.params.deckId).then(response => {
            this.deck = response.data;
        })
    }
}
</script>

<style scoped>
.form-btn button{
    transition-duration: .2s;
    margin-top: 1vh;
}
.edit-deck h1{
    flex-grow: 1;
}
.new-deck-btn{
    height: 40px;
    width: 200px;
}
.edit-deck{
    display: flex;
    align-items: center;
}
.edit-deck-form{
    display: flex;
    flex-direction: column;
    width: 30vw;
    flex-grow: 3;
}
#deck-name{
    margin-bottom: 5px;
}
.form-btn{
    display: flex;
    justify-content: center;
    gap: 2px;
}
.form-btn > *{
    box-shadow: none;
    width: 50%;
    margin: 0;
    font-size: 20px;

}

</style>