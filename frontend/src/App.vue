<template>
  <div id="app">
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
  margin-top: 60px;
}
</style>
