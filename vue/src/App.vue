<template>
  <div id="app">
    <div class="app-overlay">
      <div id="header"></div>
      <div id="footer"></div>
    </div>
    <div class="left-head-nav">
      <router-link class="home-btn" v-bind:to="{ name: 'home' }"><img class="logo-nav" src="./assets/flasher-logo-gray-small.png" ></router-link>
      <router-link class="my-decks-btn" v-bind:to="{ name: 'mydecks' }" v-if="$store.state.token != ''"><div class="nav-btn-text">My Decks</div></router-link>
      <router-link class="my-cards-btn" v-bind:to="{ name: 'mycards' }" v-if="$store.state.token != ''">My Cards</router-link>
      <router-link class="study-btn" v-bind:to="{ name: 'studysession' }" v-if="$store.state.token != ''">Study</router-link>
      <router-link class="logout" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
    </div>
    <router-view class="main" v-bind:class="{view: $route.path != '/'&& $route.path != '/login' && $route.path != '/register'}" />
  </div>
</template>

<style>
html, body, #app{
  height: 100%;
}
@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
h1{
  font-family: 'Pacifico';
  font-weight: 100;
}
.home-icon{
  width: 35px;
}
.menu-icon{
  width: 40px;
}
.logo-nav{
  width: 12vh;
  opacity: 0;
  animation-name: logo-nav-load;
  animation-delay: .6s;
  animation-duration: .1s;
  animation-fill-mode: forwards;
  animation-timing-function: ease-out;
  transition: .2s;
}
.logo-nav:hover{
  width: 12.5vh;
}
@keyframes logo-nav-load {
  from {opacity: 0; transform: scale(0);}
  to{opacity: 1; transform: scale(100%);}
}
.logout, .logout-slide{
  top: 32vh;
}
.home-btn{
  position: fixed;
  left: 40px;
  top: 20px;
  transition: .2s;
}
.home-btn:hover{
  left:37px;
  top: 17px;
}
.my-decks-btn, .my-decks-slide{
  top: 20vh;
  
}
.my-cards-btn, .my-cards-slide{
  top: 23vh;
}
.study-btn, .study-slide{
  top: 26vh;
}
.my-decks-btn, .logout, .my-cards-btn, .study-btn, .my-decks-slide, .my-cards-slide, .study-slide, .logout-slide{
  padding: 0 10px 0 10px;
  font-size: 2vh;
  font-weight:bold;
  position: fixed;
  color: #092c49;
  transition: .2s;
}
.my-decks-btn:hover, .logout:hover, .my-cards-btn:hover, .study-btn:hover{
  color: white;
}
#header{
  width: calc(30vw + 100px);
  height: 100vh;
  left: -30vw;
  top: -100vh;
  background-color: #1ee3cf;
  transform: skew(-13deg);
  position:fixed;
  box-shadow:  inset 0 0 10px  gray;
    box-shadow:  0 0 7px  gray;
  animation-name: header-load;
  animation-delay: .1s;
  animation-duration: .4s;
  animation-fill-mode: forwards;
  animation-timing-function: ease-out;
}
@keyframes header-load {
  from {top: -100vh;}
  to {top: 0; }
}
#footer{
  width: calc(30vw + 100px);
  height: 100vh;
  left: 95vw;
  top: 100vh;
  background-color: #1ee3cf;
  transform: skew(-13deg);
  position:fixed;
  box-shadow:  inset 0 0 10px  gray;
  animation-name: footer-load;
  animation-delay: .1s;
  animation-duration: .4s;
  animation-fill-mode: forwards;
  animation-timing-function: ease-out;

}
@keyframes footer-load {
  from {top: 100vh;}
  to {top: 0; }
}
.view{
  grid-area: view;
  width: 75% !important;
}
#app{
  display: flex;
  position: relative;
  background-color: rgba(245, 245, 245, 0.486);
}
.app-overlay{
  overflow: hidden;
  
  height: 100% !important;
}
*{
  font-family:sans-serif;
}
#nav a{
  text-decoration: none;
  color: rgb(71, 71, 71);
  font-weight: bold;
}
.router-link-active {
  color: white;
}
.main{
  padding: 30px;
  margin: auto;
  
}
* > .teal-btn{
  background-color: #1ee3cf;
  border: none;
  border-radius: 20px;
  box-shadow: -2px 3px 5px lightgray;
  justify-content: center;
  align-items: center;
  color: black;
  font-size: 22px;

}
* > .teal-btn:hover{
    background-color: #1ac0af;

}
* > .new-teal-btn{
  background-color: #1ee3cf;
  width: 300px;
  height: 200px;
  padding: 20px;
  margin: 10px;
  border: none;
  border-radius: 20px;
  box-shadow: 0px 3px 5px gray;
  justify-content: center;
  align-items: center;
  color: black;
  font-size: 22px;
}
* > .new-teal-btn:hover{
  background-color: #1ac0af;

}
* > .small-new-teal-btn{
  background-color: #1ee3cf;
  padding: 15px;
  margin: 10px;
  border: none;
  border-radius: 10px;
  box-shadow: -2px 3px 5px lightgray;
  justify-content: center;
  align-items: center;
  color: black;
  font-size: 26px;

}
* > .small-new-teal-btn:hover{
  background-color: #1ac0af;
}
* > .purple-btn{
  background-color: #593cda;
  width: 18vw;
  height: 20vh;
  padding: 20px;
  margin: 10px;
  border: none;
  border-radius: 20px;
  box-shadow: 0px 3px 7px gray;
  justify-content: center;
  align-items: center;
  color: whitesmoke;
  font-size: 22px;
}
* > .purple-btn:hover{
  background-color: #4b32bb;
}
* > .small-purple-btn{
  background-color: #593cda;
  padding: 20px;
  margin: 10px;
  border: none;
  border-radius: 10px;
  box-shadow: -2px 3px 5px lightgray;
  justify-content: center;
  align-items: center;
  color: whitesmoke;
  font-size: 26px;
}
* > .small-purple-btn:hover{
  background-color: #4b32bb;
}
* > .lt-btn{
  background-color: #cacaca;
  width: 300px;
  height: 200px;
  padding: 20px;
  margin: 10px;
  border: none;
  border-radius: 20px;
  box-shadow: 0px 3px 5px gray;
  justify-content: center;
  align-items: center;
  color: black;
  font-size: 22px;
}
* > .lt-btn:hover{
  background-color: #afafaf;
}
* > .small-lt-btn{
  background-color: #cacaca;
  padding: 20px;
  margin: 10px;
  border: none;
  border-radius: 10px;
  box-shadow: -2px 3px 5px lightgray;
  justify-content: center;
  align-items: center;
  color: black;
  font-size: 26px;
}
* > .small-lt-btn:hover{
  background-color: #afafaf;
}
* > .navy-btn{
  background-color: #0D3F67;
  width: 20vw;
  height: 200px;
  padding: 20px;
  margin: 10px;
  border: none;
  border-radius: 20px;
  box-shadow: 0px 3px 7px gray;
  justify-content: center;
  align-items: center;
  color: whitesmoke;
  font-size: 22px;
  /* cursor:default !important; */
}
* > .navy-btn:hover{
  background-color: #092c49;
}
* > .small-navy-btn{
  background-color: #0D3F67;
  width: 300px;
  margin: 10px;
  border: none;
  border-radius: 10px;
  box-shadow: px 3px 5px gray;
  justify-content: center;
  align-items: center;
  color: whitesmoke;
  font-size: 26px;
}
* > .small-navy-btn:hover{
  background-color: #092c49;
}
</style>
