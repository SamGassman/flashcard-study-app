<template>
  <div class="home">
    <h2 class="home-header">Welcome to Flasher<br> <h3 class="home-header home-header-small">Your Flash Card Study App</h3></h2>
    <div class="home-options">
      <button class="navy-btn skew-btn" v-on:click="$router.push({name: 'communitydecks'})"><div>Community Decks</div></button>
      <button class="purple-btn skew-btn" v-on:click="$router.push({name: 'communitycards'})"><div>Community Cards</div></button>
      <button class="new-teal-btn skew-btn" v-on:click="$router.push({name: 'mydecks'})"><div>My Decks</div></button>
      <button class="lt-btn skew-btn" v-on:click="$router.push({name: 'mycards'})"><div>My Cards</div></button>
      <button v-show="$store.state.user.role == 'admin'" class="purple-btn skew-btn" id="admin-home-btn" v-on:click="$router.push({name: 'admin'})"><div>Approve Decks And Cards</div></button>


    </div>
  </div>
</template>

<script>

export default {
  name: "home",
  data() {
    return {
      
    }
  }
};
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');

.home-header {
  color: #071E3D;
  font-family: 'Pacifico';
  font-size: 5vw;
  text-align: center;
}
.home-header-small{
  font-size: 3vw;
}
.home-options button {
  width: 40%;
  height: 20vh;
  border-width: 3px;
  border-style: solid;
  transition: .2s;
}
.home-options button div{
  font-family: 'Pacifico';
  font-size: 5vh;
}
button#admin-home-btn{
  width: 82%;
  height: 12vh;
  padding: 0;
}
.home-options{
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
  margin-top: 10vh;
}
a:hover{
  text-decoration: none;

}
</style>
