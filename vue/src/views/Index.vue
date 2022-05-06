<template>
    <div class="main index">
        <div class="logo-text">
            <img class="logo logo-animate" src="../assets/flasher-logo.png" >
            <h1>Flasher</h1>

            <div class="login-register">

            <router-link class="login btn btn-lg btn-primary btn-block signin-button" v-bind:to="{ name: 'login' }" v-if="$store.state.token == '' && $route.path == '/'">
            <div class="login-text">Login</div></router-link>
            <router-link class="register btn btn-lg btn-primary btn-block signin-button" v-bind:to="{ name: 'register' }" v-if="$store.state.token == '' && $route.path == '/'">
            <div class="register-text">Register</div></router-link>
            

            </div>
        </div>
    </div>
</template>

<script>
export default {
    created(){
        this.$store.commit("LOGOUT");

    }
}
</script>

<style>
.index{
    background-image: url("../assets/wrtiting-tools.jpg");
    background-repeat: no-repeat;
    background-size: cover;
}
.register, .login{
  background-color: #6B48FF;
  width: 350px;
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: skew(-13deg);
  margin: 15px;
}
.login-text, .register-text{
  transform: skew(13deg);
  font-size: 20px;
  font-weight: bold;
}
.main{
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: flex-start;
    flex-direction: column;
}
.logo{
  width: 350px;
  margin: auto;
}
.logo-animate, .logo-text{
    opacity: 0;
    animation-name: logo-load;
    animation-delay: .1s;
    animation-duration: .2s;
    animation-fill-mode: forwards;
    animation-timing-function: ease-in;
}
@keyframes logo-load {
    from{opacity: 0;}
    to{opacity: 1;}
}
.logo-text{
    display: flex;
    flex-direction: column;
    align-items: center;
}
h1{
    font-size: 100px;
    font-weight: 100;
}
</style>