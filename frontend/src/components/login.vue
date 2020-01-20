<template>
 <div>
   <form class="login" @submit.prevent="login">
     <h1>Sign in</h1>
     <label>username</label>
     <input required v-model="username" type="text" placeholder="Name"/>
     <label>Password</label>
     <input required v-model="password" type="password" placeholder="Password"/>
     <button type="submit">Login</button>
   </form>
   <p style="color: red;">{{ msg }}</p>
 </div>
</template>

<script>
export default {
  data () {
    return {
      username : '',
      password : '',
      msg: ''
    };
  },

  methods: {
    login: function () {
      const { username, password } = this
      this.$store.dispatch('login', { username, password })
        .then(() => this.$router.push('/'))
        .catch(err => {
          console.log(err)
          this.msg = 'wrong username or password'
        })
    }
  }
};
</script>
