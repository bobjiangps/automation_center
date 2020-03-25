// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './utils/store'
import axios from './utils/axios'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.less'
import { library } from '@fortawesome/fontawesome-svg-core'
//import { faAutoprefixer } from '@fortawesome/free-brands-svg-icons'
import { faChartArea } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(faChartArea)
//library.add(faAutoprefixer)

Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(Antd)

Vue.prototype.$http = axios;
const token = localStorage.getItem('token')
if (token) {
  Vue.prototype.$http.defaults.headers.common['Authorization'] = 'Token ' + token
}

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
