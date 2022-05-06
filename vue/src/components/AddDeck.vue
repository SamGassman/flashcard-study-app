<template>
    <div class="add-deck">
        <button class="new-deck-btn small-new-teal-btn skew-btn btn btn-lg btn-primary btn-block" v-on:click="isAddDeckVisible = !isAddDeckVisible" v-if="!isAddDeckVisible"><div>New Deck</div></button>

        <div class="add-deck-form" v-if="isAddDeckVisible">
            <input class="form-control" type="text" name="deck-name" id="deck-name" placeholder="Deck Name" required v-model="deck.deckName">
            <textarea class="form-control" rows="5" cols="40" name="deck-description" id="deck-description" placeholder="Deck Description" v-model="deck.deckDescription"></textarea>
            <div class="form-btn">
                <button class="small-navy-btn" v-on:click="addDeck()"><div>Submit</div></button>
                <button class="small-lt-btn" v-on:click="isAddDeckVisible = false"><div>Cancel</div></button>

            </div>
        </div>
    </div>
</template>

<script>
import deckService from "../services/DeckService";

export default{
    name: 'add-deck',
    data(){
        return{
            isAddDeckVisible: false,
            deck: {
                deckName: "",
                deckDescription: "",
                userId: this.$store.state.user.userId,
            }
        }
    },
    methods: {
        addDeck(){

            this.deck.deckName = this.deck.deckName[0].toUpperCase() + this.deck.deckName.substring(1);
            if(this.deck.deckDescription){
                this.deck.deckDescription = this.deck.deckDescription[0].toUpperCase() + this.deck.deckName.substring(1);
            }

            deckService.addDeck(this.deck).then(() => {
                deckService.myDecks(this.$store.state.user.userId).then((response) => {this.$store.commit("SET_DECKS", response.data )});
                this.deck.deckName = "";
                this.deck.deckDescription = "";
                this.isAddDeckVisible = !this.isAddDeckVisible;
                
            });
            
        }
    },
}
</script>

<style>
.new-deck-btn{
    width: 200px;
    padding: 0;
    height: 50px;
}
.form-btn button{
    margin-top: 1vh;
}
.new-deck-btn:hover{
    color: black;
}
.add-deck{
    display: flex;
    justify-content: center;
}
.add-deck-form{
    display: flex;
    flex-direction: column;
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
