<template>
  <div id="app">
    <a-layout style="height: 100%;">
      <a-layout-sider breakpoint="lg" collapsedWidth="0" @collapse="onCollapse" @breakpoint="onBreakpoint" style="background: #2F4F4F;">
        <div class="logo">
          <a href="/">
            <font-awesome-icon icon="chart-area" size="3x" inverse />
            <!--<font-awesome-icon :icon="['fab', 'autoprefixer']" size="3x" inverse />-->
            <h3 style="color: #fff; margin: 10px;">Automation Center</h3>
          </a>
        </div>
        <hr style="width: 90%;">
        <a-menu mode="inline" :openKeys="openKeys" @openChange="onOpenChange" style="background: #2F4F4F; color: #fff;">
          <a-sub-menu v-if="this.in_home_page" key="sub1">
            <span slot="title"><a-icon type="project" /><span>Projects</span></span>
            <a-menu-item v-for="(p, index) in this.projects" :key="index">
              <a :href="projectHref(p.id)">{{p["name"]}}</a>
              <!--<router-link :to="{ name: 'projects', params: { id: p.id }}">{{p["name"]}}</router-link>-->
            </a-menu-item>
          </a-sub-menu>
          <a-sub-menu v-else key="sub1">
            <span slot="title"><a-icon type="menu" /><span>Pages</span></span>
            <a-menu-item v-for="(p, index) in this.project_sider_items" :key="index">
              <router-link :to="projectSubHref(p.link)">{{p["name"]}}</router-link>
            </a-menu-item>
          </a-sub-menu>
          <a-sub-menu v-if="this.in_home_page == false" key="sub2">
            <span slot="title"><a-icon type="project" /><span>Projects</span></span>
            <a-menu-item v-for="(p, index) in this.projects" :key="index">
              <a :href="projectHref(p.id)">{{p["name"]}}</a>
            </a-menu-item>
          </a-sub-menu>
          <a-sub-menu key="sub3">
            <span slot="title"><a-icon type="setting" /><span>Settings</span></span>
            <a-menu-item key="1">Projects</a-menu-item>
            <a-menu-item key="2">Users</a-menu-item>
          </a-sub-menu>
        </a-menu>
      </a-layout-sider>
      <a-layout>
        <a-layout-header style="background: #fff; border-bottom: 1px solid #e8e8e8;">
          <a-input-search placeholder="input keyword..." @search="onSearch" enterButton style="width: 40%; margin: 15px 0px; float: left;" />
          <div id="header-right" style="float: right;">
            <!--<font-awesome-layers full-width class="fa-2x">
              <font-awesome-icon :icon="[ 'fas', 'bell' ]" />
              <span class="fa-layers-counter">10+</span>
            </font-awesome-layers>
            <font-awesome-layers>
              <font-awesome-icon :icon="['fas', 'bell']" />
              <font-awesome-layers-text counter value="3" position="top-right" />
            </font-awesome-layers>&emsp;3-->
            <font-awesome-layers class="fa-fw fa-1x">
              <font-awesome-icon :icon="[ 'fas', 'bell' ]" />
              <font-awesome-layers class="fa-layers-counter fa-layers-top-right">{{ notifications }}</font-awesome-layers>
            </font-awesome-layers>&emsp;{{ notifications }}
            <a-divider type="vertical" />
            <!--Bob Jiang
            <img src="./assets/niming-no-gender.png" style="margin: 5px; width: 30px; height: 30px; border-radius: 50%;">-->
            <img v-if="this.$store.state.token" src="./assets/niming-no-gender.png" style="margin: 5px; width: 30px; height: 30px; border-radius: 50%;">
            <span v-if="this.$store.state.token">Hi, {{ this.$store.state.user }}</span>
            <a v-if="this.$store.state.token" @click="logout" :style="{ margin: '10px', padding: '5px' }">Logout</a>
            <!--<router-link v-else to="/login" :style="{ margin: '10px', padding: '5px' }">Login</router-link>-->
            <a v-else @click="login" :style="{ margin: '10px', padding: '5px' }">Login</a>
          </div>
        </a-layout-header>
        <ownbreadcrumb :routes="this.breadcrumbList" />
        <router-view/>
        <a-layout-footer style="text-align: center;">
          {{ fullCopyRight }}
        </a-layout-footer>
      </a-layout>
    </a-layout>
  </div>
</template>

<script>
export default {
  name: 'App',

  data() {
    return {
      rootSubmenuKeys: ['sub1', 'sub2', 'sub3'],
      openKeys: ['sub1'],
      projects: [],
      breadcrumbList: [],
      notifications: 3,
      copyRightPrefix: "Copyright © ",
      copyRightSuffix: " BobJiang | byincd.com",
      in_home_page: true,
      project_sider_items: [
        { "name": "Dashboard", "link": "" },
        { "name": "Rounds", "link": "test-rounds" },
        { "name": "Suites", "link": "test-suites" },
        { "name": "Scripts", "link": "test-scripts" },
        { "name": "Reports", "link": "test-reports" }
      ]
    };
  },

  created: function() {
    if (this.$route.path.indexOf("/projects/") >= 0) {
      this.in_home_page = false;
      this.retrieveProjects();
    }
    else {
      this.in_home_page = true;
      this.retrieveProjects();
    }

    this.$http.interceptors.response.use(
      response => {
        return response;
      },
      error => {
        if (error.response) {
          switch (error.response.status) {
            case 401:
              // 返回 401 清除token信息并跳转到登录页面
              console.log('unauthorized or expired, Please login first')
              this.$store.dispatch('logout');
              this.$router.replace({
                path: 'login',
                query: {redirect: this.$router.currentRoute.fullPath}
              });
          }
        }
      return Promise.reject(error.response.data)   // 返回接口返回的错误信息
    });

  },

  methods: {
    onCollapse(collapsed, type) {
      console.log(collapsed, type);
    },

    onBreakpoint(broken) {
      console.log(broken);
    },

    onOpenChange(openKeys) {
      const latestOpenKey = openKeys.find(key => this.openKeys.indexOf(key) === -1);
      if (this.rootSubmenuKeys.indexOf(latestOpenKey) === -1) {
        this.openKeys = openKeys;
      } else {
        this.openKeys = latestOpenKey ? [latestOpenKey] : [];
      }
    },

    onSearch(value) {
        console.log(value);
    },

    logout: function () {
      this.$store.dispatch('logout')
      .then(() => {
        this.$router.push('/login');
        this.in_home_page = true;
      })
    },

    login: function() {
      this.$router.push('/login');
      this.in_home_page = true;
    },

    projectHref(project_id) {
      return "/projects/" + project_id;
    },

    projectSubHref(link) {
      return `/projects/${this.$route.params.project_id}/${link}`;
    },

    retrieveProjects: function() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/`)
        .then(response => {
          this.projects = response.data["results"];
          for (var p of this.projects) {
            if (p.id == this.$route.params.project_id) {
              this.breadcrumbList.push({"path": this.projectHref(p.id), "breadcrumbName": p.name});
              break;
            }
          }
          for (var match of this.$route.matched) {
            this.breadcrumbList.push({"path": match.path, "breadcrumbName": match.meta.breadcrumb});
          }
        })
        .catch(err => {console.log(err)})
    },
  },

  computed: {
    fullCopyRight: function(){
      return this.copyRightPrefix + new Date().getFullYear() + this.copyRightSuffix;
    }
  }

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

.logo {
  margin: 10px 5px;
}

.ant-menu {
  text-align: left;
}
</style>
