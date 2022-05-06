<template>
  <div id="register" class="text-center">
    <div class="logo-header">
            <img class="logo" src="../assets/flasher-logo.png" >
            <h1>Flasher</h1>
      </div>
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        {{ registrationErrorMsg }}
      </div>
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
      <input
        type="password"
        id="confirmPassword"
        class="form-control"
        placeholder="Confirm Password"
        v-model="user.confirmPassword"
        required
      />
      <button class="btn btn-lg btn-primary btn-block signin-button" type="submit">
        Create Account
      </button>
      <router-link class="btn btn-lg btn-primary btn-block signin-button" :to="{ name: 'login' }">Have an account?</router-link>

    </form>
  </div>
</template>

<script>
import authService from '../services/AuthService';

export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style >
.form-register{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 25%;
}
#register{
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
  justify-content: flex-start;
}
#register{
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
