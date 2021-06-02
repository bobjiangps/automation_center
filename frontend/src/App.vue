<template>
  <div id="app">
    <a-layout>
      <a-layout-header style="background: #fff; border-bottom: 1px solid #e8e8e8; position: fixed; z-index: 1; width: 100%;">
        <div id="header-left" style="float: left;">
          <a href="/">
            <h3><b>Automation Center</b></h3>
          </a>
        </div>
        <!--<a-input-search placeholder="input keyword..." @search="onSearch" enterButton style="width: 30%; margin: 15px 30px; float: left;" />-->
        <div id="header-right" style="float: right;">
          <a-menu mode="horizontal" :style="{ lineHeight: '64px', height: '64px', float: 'left' }">
            <a-sub-menu key="1">
              <span slot="title"><a-icon type="project" /><span>Projects</span></span>
              <a-menu-item v-for="(p, index) in this.projects" :key="index">
                <a :href="projectHref(p.id)">{{p["name"]}}</a>
              </a-menu-item>
            </a-sub-menu>
            <a-menu-item key="2">
              <a href="/workers">
                <a-icon type="cluster"/>Workers
              </a>
            </a-menu-item>
            <a-menu-item key="3">
              <a href="/admin">
                <a-icon type="setting"/>Admin
              </a>
            </a-menu-item>
          </a-menu>
          <a-divider type="vertical" />
          <font-awesome-layers class="fa-fw fa-1x">
            <font-awesome-icon :icon="[ 'fas', 'bell' ]" />
            <font-awesome-layers class="fa-layers-counter fa-layers-top-right">{{ notifications }}</font-awesome-layers>
          </font-awesome-layers>&emsp;{{ notifications }}
          <a-divider type="vertical" />
          <!--Bob Jiang
          <img src="./assets/niming-no-gender.png" style="margin: 5px; width: 30px; height: 30px; border-radius: 50%;">-->
          <img v-if="this.$store.state.token" src="./assets/niming-no-gender.png" style="margin: 5px; width: 30px; height: 30px; border-radius: 50%;">
          <span v-if="this.$store.state.token">Hi, {{ this.$store.state.user.name }}</span>
          <a v-if="this.$store.state.token" @click="logout" :style="{ margin: '10px', padding: '5px' }">Logout</a>
          <router-link v-else to="/login" :style="{ margin: '10px', padding: '5px' }">Login</router-link>
          <!--<a v-else @click="login" :style="{ margin: '10px', padding: '5px' }">Login</a>-->
        </div>
      </a-layout-header>
      <a-layout-content :style="{ marginTop: '64px' }">
        <router-view/>
      </a-layout-content>
    </a-layout>
  </div>
</template>

<script>
export default {
  name: 'App',

  data() {
    return {
      projects: [],
      notifications: 3,
    };
  },

  created: function() {
    this.$http.get(`${this.$http.defaults.baseURL}/projects/`)
      .then(response => {
        this.projects = response.data["results"];
      })
      .catch(err => {console.log(err)});

  },

  methods: {
    logout: function () {
      this.$store.dispatch('logout')
      .then(() => {
        this.$router.push('/');
      })
    },

    login: function() {
      this.$router.push('/login');
    },

    onSearch(value) {
        console.log(value + "not implement yet");
    },

    projectHref(project_id) {
      return "/projects/" + project_id;
    },
  },

}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  height: 100%;
}

.ant-menu {
  text-align: left;
}
</style>
