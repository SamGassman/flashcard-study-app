<template>
    <div class="edit-card">
        <h1>Edit Card</h1>

        <div class="edit-card-form">
            <label for="card-front">Front</label>
            <input class="form-control" type="text" name="card-front" id="card-front" v-model="card.cardFront">
            <label for="card-back">Back</label>
            <textarea class="form-control" rows="5" cols="40" name="card-back" id="card-back" v-model="card.cardBack"></textarea>
            <label for="card-image">Image URL (optional)</label>
            <input class="form-control form-img-url" type="text" name="card-image" id="card-image" v-model="card.cardImage">
            <div class="tags">
                <label for="tags-basic">Type a new tag and press enter</label>
                <input class="form-control" type="text" v-on:keyup.enter="addTag()" v-model="tag">
                    <p>Tags: </p>

                <div class="list-of-tags">
                    <div class="list-tags" v-for="tag in card.tags" v-bind:key="tag">
                        <p>{{ tag }} <img class="edit" src="../assets/close.svg" v-on:click="removeTag(tag)" /></p>

                    </div>

                </div>
            </div>
            <div class="form-btn">
                <button class="small-navy-btn" v-on:click="editCard()">Submit</button>
                <button class="small-lt-btn" v-on:click="$router.push({name: 'deck', params: {deckId: $route.params.deckId}})">Cancel</button>

            </div>
        </div>
    </div>
</template>

<script>
import cardService from "../services/CardService";

export default{
    name: 'edit-card',
    data(){
        return{
            tag: '',
            card: {
                
                cardId: 0,
                cardFront: "",
                cardBack: "",
                cardImage: "",
                tags: []
            }
        }
    },
    methods: {
        editCard(){
            
            cardService.editCard(this.card).then(() => {
                this.$router.push({name: 'deck', params: {deckId: this.$route.params.deckId}});
            });
        },
        addTag(){
            this.card.tags.push(this.tag);
            this.tag = '';
        },
        removeTag(tag){
            this.card.tags = this.card.tags.filter(a => {
                return a != tag
            })
        }
    },
    created() {
        this.card.cardId = this.$store.state.editCard.cardId
        this.card.cardFront = this.$store.state.editCard.cardFront
        this.card.cardBack = this.$store.state.editCard.cardBack
        this.card.cardImage = this.$store.state.editCard.cardImage
        this.card.tags = this.$store.state.editCard.tags
    }
}
</script>

<style scoped>
h2 {
    font-size: 50px;
    font-weight: bold;
    font-family: 'Calendas Plus';
    text-align: center;
    color: #0D3F67;
}
.list-of-tags{
    display: flex;
    gap: 10px;
}
.edit-card-btn{
    height: 40px;
    width: 200px;
}
.list-tags p img{
    filter: none;
    width: 20px;
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
.edit-card{
    display: flex;
    align-items: center;
}
.edit-card-form{
    display: flex;
    width: 50%;
    flex-direction: column;
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
.form-btn button{
    margin-top: 1vh;
    transition: .2s;
}

</style>