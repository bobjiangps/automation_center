<template>
  <div id="app">
    <a-layout>
      <a-layout-sider breakpoint="lg" collapsedWidth="0" @collapse="onCollapse" @breakpoint="onBreakpoint" style="background: #2F4F4F;">
        <div class="logo">
          <router-link to="/">
            <font-awesome-icon icon="chart-area" size="3x" inverse />
            <!--<font-awesome-icon :icon="['fab', 'autoprefixer']" size="3x" inverse />-->
            <h3 style="color: #fff; margin: 10px;">Automation Center</h3>
          </router-link>
        </div>
        <hr style="width: 90%;">
        <a-menu mode="inline" :openKeys="openKeys" @openChange="onOpenChange" style="background: #2F4F4F; color: #fff;">
          <a-sub-menu key="sub1">
            <span slot="title"><a-icon type="project" /><span>Projects</span></span>
            <a-menu-item key="1">ByBlog</a-menu-item>
            <a-menu-item key="2">MobileSTF</a-menu-item>
            <a-menu-item key="3">RestAPI</a-menu-item>
          </a-sub-menu>
          <a-sub-menu key="sub2">
            <span slot="title"><a-icon type="setting" /><span>Settings</span></span>
            <a-menu-item key="1">Projects</a-menu-item>
            <a-menu-item key="2">Users</a-menu-item>
          </a-sub-menu>
        </a-menu>
      </a-layout-sider>
      <a-layout>
        <a-affix style="height: 64px">
          <a-layout-header style="background: #fff; border-bottom: 1px solid #e8e8e8;">
            <div class="logo">
              <router-link to="/">
                <h1>Automation Center</h1>
              </router-link>
            </div>
          </a-layout-header>
        </a-affix>
        <a-layout-footer style="text-align: center">
          Copyright © BobJiang
        </a-layout-footer>
      </a-layout>
    </a-layout>
    <img src="./assets/icons8-automation-64.png">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App',

  data() {
    return {
      rootSubmenuKeys: ['sub1', 'sub2'],
      openKeys: ['sub1'],
    };
  },

  created: function() {
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
              })
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
  },

}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.logo {
  margin: 10px 5px;
}

.ant-menu {
  text-align: left;
}
</style>
