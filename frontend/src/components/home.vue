<template>
  <div>
    <h3>{{ msg }}</h3>
    <button type="button" @click='getProjects' :style="{ margin: '10px', padding: '5px' }">get projects</button>
    <button v-if="auth.length == 0" type="button" @click='getToken' :style="{ margin: '10px', padding: '5px' }">Sign In</button>
    <button v-else type="button" :style="{ margin: '10px', padding: '5px' }">Sign Out</button>
    <p>{{ auth_text }}</p>
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
import axios from 'axios'
export default {
  name: 'Home',
  data () {
    return {
      msg: 'Projects in Automation Center',
      projects: [],
      auth: [],
      auth_text: 'not sign in'
    }
  },

  methods: {
    getProjects() {
      axios.get('http://127.0.0.1:8000/automation/api/projects/').then(response => {this.projects = response.data["results"], this.msg = 'get projects data from django api'});
    },

    getToken() {
      axios.post('http://127.0.0.1:8000/automation/api/api-token-auth/', {
          "username": "bo",
          "password": "111111"
      }).then(response => {
          this.auth_text = "Hello, bo"
          this.auth.push(response.data)
      }).catch(error => {
          this.auth_text = "Error when sign in "
          console.log(error)});
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
