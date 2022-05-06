<template>
  <div id="login" class="text-center">
    <div class="logo-header">
            <img class="logo" src="../assets/flasher-logo.png" >
            <h1>Flasher</h1>
      </div>
    <form class="form-signin" @submit.prevent="login">
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <div
        class="alert alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid email or password!</div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.</div>
      <label for="username" class="sr-only">Email</label>
      <input
        type="email"
        id="username"
        class="form-control"
        placeholder="Email"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <button type="submit" class="btn btn-lg btn-primary btn-block signin-button">Sign in</button>
      <router-link class="btn btn-lg btn-primary btn-block signin-button" :to="{ name: 'register' }">Need an account?</router-link>

    </form>
  </div>
</template>

<script>
import authService from "../services/AuthService";

export default {
  name: "login",
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/home");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style >
.form-signin{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 25%;
}
.signin-button{
  background-color: #6B48FF;
  border-color: #6B48FF;
  margin-top: 7px;
  box-shadow: 0px 4px 5px gray;
}
.signin-button:hover{
  background-color: #1ee3cf;
  border-color: #1ee3cf;
}
#login{
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  width: 100%;
  justify-content: flex-start;
}
#login{
    background-image: url("../assets/wrtiting-tools.jpg");
    background-repeat: no-repeat;
    background-size: cover;
}
.logo{
  width: 350px;
  margin: auto;
}

h1{
    font-size: 100px;
    font-weight: 100;
}
</style>
