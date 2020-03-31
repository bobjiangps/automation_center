<template>
  <div style="margin: 20px;">
    <a-row type="flex" justify="space-around">
      <a-col :span="7" :style="{ padding: '10px', backgroundColor: '#FFF', textAlign: 'left', border: 'solid', borderColor: '#FFF #FFF #FFF #1874CD' }">
        <h2 :style="{ color: '#1874CD', padding: '5px 0px 0px 0px' }">Projects Total:
          <span id="projects-total-count" :style="{ color: '#1C1C1C' }">3</span>
          <font-awesome-icon :icon="[ 'fas', 'project-diagram' ]" :style="{ float: 'right', padding: '5px 0px 0px 0px' }" />
        </h2>
      </a-col>
      <a-col :span="7" :style="{ padding: '10px', backgroundColor: '#FFF', textAlign: 'left', border: 'solid', borderColor: '#FFF #FFF #FFF #6CA6CD' }">
        <h2 :style="{ color: '#6CA6CD', padding: '5px 0px 0px 0px' }">Projects Running:
          <span id="projects-running-count" :style="{ color: '#1C1C1C' }">1</span>
          <font-awesome-icon :icon="[ 'fas', 'running' ]" :style="{ float: 'right', padding: '5px 0px 0px 0px' }" />
        </h2>
      </a-col>
      <a-col :span="7" :style="{ padding: '10px', backgroundColor: '#FFF', textAlign: 'left', border: 'solid', borderColor: '#FFF #FFF #FFF #1CC88A' }">
        <h2 :style="{ color: '#1CC88A', padding: '5px 0px 0px 0px' }">Automated Cases:
          <span id="automated-cases-count" :style="{ color: '#1C1C1C' }">128</span>
          <font-awesome-icon :icon="[ 'fas', 'clipboard-check' ]" :style="{ float: 'right', padding: '5px 0px 0px 0px' }" />
        </h2>
      </a-col>
    </a-row>
    <h3>{{ msg }}</h3>
    <button type="button" @click='getProjects' :style="{ margin: '10px', padding: '5px' }">get projects</button>
    <a-button type="primary">Button</a-button>
    <a v-if="this.$store.state.token" @click="logout" :style="{ margin: '10px', padding: '5px' }">Logout</a>
    <router-link v-else to="/login" :style="{ margin: '10px', padding: '5px' }">Login</router-link>
    <p>{{ auth_text }}</p>
    <p>{{ this.$store.state.token }}</p>
    <p>{{ this.$store.state.status }}</p>
    <p>{{ this.$store.state.user }}</p>
    <p>{{ this.$store.getters.isLoggedIn }}</p>
    <p>{{ this.$store.getters.authStatus }}</p>
    <table v-if="auth.length > 0" :style="{ border: '2px solid gray', borderRadius: '5px', padding: '10px' }" align='center'>
      <tr v-for='a in auth'>
        <td>{{ a.id }}</td>
        <td>{{ a.username }}</td>
        <td>{{ a.email }}</td>
        <td>{{ a.token }}</td>
      </tr>
    </table>
    <table :style="{ border: '2px solid gray', borderRadius: '5px', padding: '10px' }" align='center'>
      <tr v-for='p in projects'>
        <td>{{ p.id }}</td>
        <td>{{ p.name }}</td>
        <td>{{ p.create_time }}</td>
        <td>{{ p.update_time }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      msg: 'Projects in Automation Center',
      projects: [],
      auth: [],
      auth_text: ''
    }
  },

 created: function() {
    if (this.$store.state.token) {
      this.auth_text = "user already logged in ";
    }
    else {
      this.auth_text = "no user logged in";
    }
  },

  methods: {
    getProjects() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/`)
      .then(response => {this.projects = response.data["results"], this.msg = 'get projects data from django api'})
      //.catch(err => {
        //if (err.response.status === 401) {
          //alert("not authenticated, please check if your token was expired")
        //}
        //this.$store.dispatch('logout')
        //this.$router.push('/login')
      //});
    },

    logout: function () {
      this.$store.dispatch('logout')
      .then(() => {
        this.$router.push('/login')
      })
    }

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
