<template>
  <div>
    <h3>{{ msg }}</h3>
    <button type="button" @click='getProjects' :style="{ margin: '10px', padding: '5px' }">get projects</button>
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
      projects: []
    }
  },

  methods: {
    getProjects() {
      axios.get('http://127.0.0.1:8000/api/projects/').then(response => {this.projects = response.data["results"], this.msg = 'get projects data from django api'});
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
