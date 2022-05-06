<template>
    <div class="add-card">
            <button class="new-card-btn small-new-teal-btn btn btn-lg btn-primary btn-block skew-btn" 
                v-on:click="isAddCardVisible = !isAddCardVisible" 
                v-show="!isAddCardVisible"><div>New Card</div></button>


            <button v-show="!isAddCardVisible" v-on:click="$router.push({name: 'startstudysession', params: {deckId: $route.params.deckId}})" class="deck-start-study small-new-teal-btn skew-btn"><div>Study Session</div></button>
            <button v-show="!isAddCardVisible && !isPublic" v-on:click="submitCard()" class="deck-start-study small-new-teal-btn skew-btn"><div>Make Public</div></button>


        <div class="add-card-form"  v-show="isAddCardVisible">
            <input class="form-control" type="text" required name="card-front" id="card-front" placeholder="Card Front" v-model="card.cardFront">
            <textarea class="form-control" rows="5" cols="40" required name="card-back" id="card-back" placeholder="Card Back" v-model="card.cardBack"></textarea>
            <input class="form-control form-img-url" type="text" name="card-image" id="card-image" placeholder="Image URL (optional)" v-model="card.cardImage">
            <div class="tags">
                <input class="form-control"  type="text" v-on:keyup.enter="addTag()" placeholder="Type a new tag and press enter" v-model="tag">
                <p>Tags: </p>
                <div class="list-of-tags">
                    <div class="list-tags" v-for="tag in card.tags" v-bind:key="tag">
                        <p>{{ tag }} <img class="remove-tag-btn" src="../assets/close.svg" v-on:click="removeTag(tag)" /></p>

                    </div>

                </div>
            </div>
            <div class="form-btn">
                <button class="small-navy-btn" v-on:click="addCard()">Submit</button>
                <button class="small-lt-btn" v-on:click="isAddCardVisible = false">Cancel</button>

            </div>
        </div>
    </div>
</template>

<script>
import cardService from "../services/CardService";
import deckService from "../services/DeckService"

export default{
    name: 'add-card',
    data(){
        return{
            isAddCardVisible: false,
            deckDescription: '',
            isPublic: false,
            tag: '',
            card: {
                cardFront: "",
                cardBack: "",
                cardImage:"",
                deckId: parseInt(this.$route.params.deckId),
                userId: this.$store.state.user.userId,
                tags: []
            }
        }
    },
    methods: {
        addCard(){
            
            cardService.addCard(this.card).then(() => {
                cardService.getCardsInDeck(parseInt(this.$route.params.deckId)).then((response) => {this.$store.commit('SET_CARDS',response.data)})

                this.card.cardFront = "";
                this.card.cardBack = "";
                this.card.cardImage= "";
                this.isAddCardVisible = false;
                this.card.tags = [];
            });
            
        },
        addTag(){
            
            this.tag = this.tag[0].toUpperCase() + this.tag.substring(1)
            this.card.tags.push(this.tag);
            this.tag = '';
        },
        removeTag(tag){
            this.card.tags = this.card.tags.filter(a => {
                return a != tag
            })
        },
        submitCard(){
            deckService.submitDeckForAdminApproval(parseInt(this.$route.params.deckId))
        }
    },
    created(){
        deckService.getDeck(this.$route.params.deckId).then((response) => {
            this.isPublic = response.data.isDeckPublic
        })
    }
    
}
</script>

<style>
.add-card-form{
    padding: 50px;
    
}
.add-card-input{
    display: flex;
    justify-content: center;
}
.list-of-tags{
    display: flex;
    gap: 10px;
}
.list-tags{
    background-color: #1ee3cf;
    border-width: 3px;
    border-color: rgba(255, 255, 255, 0.521);
    border-style: solid;
    padding: 5px;
    height: 40px;
    border-radius: 10px;
    transition-duration: .2s;
}
.form-btn button{
    transition: .2s;
}
.new-card-btn{
    height: 50px;
    padding: 0;
    width: 200px;
}
.new-card-btn:hover{
    color: black;
}
#card-image.form-img-url{
    height: 40px !important;
    width: 100% !important;
    max-width: 100% !important;
    margin: 0;
    border-color: lightgray;
    border-width: 1px;
    border-radius: 4px;
    border-style: solid;
}
.add-card{
    display: flex;
    justify-content: space-around;
}
.add-card-form{
    display: flex;
    flex-direction: column;
    gap: 5px;
}
#card-name{
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
.remove-tag-btn{
    width: 20px;
    margin-bottom: 4px;
    cursor: pointer;
}
</style>