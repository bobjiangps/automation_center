<template>
  <div>
    <a-layout style="height: 100%;">
      <a-layout-sider breakpoint="lg" collapsedWidth="0" @collapse="onCollapse" @breakpoint="onBreakpoint" style="background: #2F4F4F;">
        <div class="logo">
          <font-awesome-icon icon="chart-area" size="3x" inverse />
        </div>
        <hr style="width: 90%;">
        <a-menu mode="inline" :openKeys="openKeys" @openChange="onOpenChange" style="background: #2F4F4F; color: #fff;">
          <a-sub-menu key="sub1">
            <span slot="title"><a-icon type="menu" /><span>Pages</span></span>
            <a-menu-item v-for="(p, index) in this.project_sider_items" :key="index">
              <router-link :to="projectSubHref(p.link)">{{p["name"]}}</router-link>
            </a-menu-item>
          </a-sub-menu>
          <a-sub-menu key="sub2">
            <span slot="title"><a-icon type="profile" /><span>Document</span></span>
            <a-menu-item key="1">Framework</a-menu-item>
            <a-menu-item key="2">Platform</a-menu-item>
            <a-menu-item key="3">Environment</a-menu-item>
          </a-sub-menu>
          <a-sub-menu key="sub3">
            <span slot="title"><a-icon type="control" /><span>Settings</span></span>
            <a-menu-item key="1">Layout</a-menu-item>
            <a-menu-item key="2">Notification</a-menu-item>
          </a-sub-menu>
        </a-menu>
      </a-layout-sider>
      <a-layout>
        <div id="breadcrumb">
          <ownbreadcrumb style="margin: 15px 25px -5px; float: left;" :routes="this.breadcrumbList" />
        </div>
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
  name: 'Project',

  data() {
    return {
      rootSubmenuKeys: ['sub1', 'sub2', 'sub3'],
      openKeys: ['sub1'],
      projects: [],
      breadcrumbList: [],
      notifications: 3,
      copyRightPrefix: "Copyright © ",
      copyRightSuffix: " BobJiang | byincd.com",
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
    this.retrieveProjects();

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
            if (match.meta && match.meta.breadcrumb) {
              let path = match.path;
              for (let key in this.$route.params) {
                path = path.replace(`:${key}`, this.$route.params[key]);
              }
              if (match.name.toLowerCase() != "project") {
                this.breadcrumbList.push({"path": path, "breadcrumbName": match.meta.breadcrumb});
              }
            }
          }
        })
        .catch(err => {console.log(err)})
    },
  },

  computed: {
    fullCopyRight: function(){
      return this.copyRightPrefix + new Date().getFullYear() + this.copyRightSuffix;
    }
  },

  watch:{
    $route(to,from){
      // this.breadcrumbList = [];
      // this.retrieveProjects();
      this.breadcrumbList = this.breadcrumbList.slice(0, 1);
      for (var match of this.$route.matched) {
        if (match.meta && match.meta.breadcrumb) {
          let path = match.path;
          for (let key in to.params) {
            path = path.replace(`:${key}`, to.params[key]);
          }
          if (match.name.toLowerCase() != "project") {
            this.breadcrumbList.push({"path": path, "breadcrumbName": match.meta.breadcrumb});
          }
        }
      }
    }
  },

}
</script>

<style>
.logo {
  margin: 10px 5px;
}

.ant-menu {
  text-align: left;
}
</style>
