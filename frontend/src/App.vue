<template>
  <div id="app">
    <a-layout>
      <a-layout-sider
        breakpoint="lg"
        collapsedWidth="0"
        @collapse="onCollapse"
        @breakpoint="onBreakpoint"
      >
      <div class="logo">
        <router-link to="/">
          <font-awesome-icon icon="chart-area" size="3x" inverse />
        </router-link>
      </div>
        <a-menu theme="dark" mode="inline" :defaultSelectedKeys="['4']">
          <a-menu-item key="1">
            <a-icon type="user" />
            <span class="nav-text">nav 1</span>
          </a-menu-item>
          <a-menu-item key="2">
            <a-icon type="video-camera" />
            <span class="nav-text">nav 2</span>
          </a-menu-item>
          <a-menu-item key="3">
            <a-icon type="upload" />
            <span class="nav-text">nav 3</span>
          </a-menu-item>
          <a-menu-item key="4">
            <a-icon type="user" />
            <span class="nav-text">nav 4</span>
          </a-menu-item>
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
  }

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
</style>
