// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './utils/store'
import axios from './utils/axios'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.less'
import VueNumber from "vue-number-animation";
import echarts from 'echarts'
import { library } from '@fortawesome/fontawesome-svg-core'
//import { faAutoprefixer } from '@fortawesome/free-brands-svg-icons'
import { faChartArea, faBell, faProjectDiagram, faRunning, faClipboardCheck } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon, FontAwesomeLayers, FontAwesomeLayersText } from '@fortawesome/vue-fontawesome'
import ownbreadcrumb from '@/components/own-breadcrumb'

library.add(faChartArea, faBell, faProjectDiagram, faRunning, faClipboardCheck)
//library.add(faAutoprefixer)

Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.component('font-awesome-layers', FontAwesomeLayers)
Vue.component('font-awesome-layers-text', FontAwesomeLayersText)

Vue.use(Antd)
Vue.use(VueNumber);

Vue.use(ownbreadcrumb)
Vue.component('ownbreadcrumb', ownbreadcrumb)

Vue.prototype.$http = axios;
Vue.prototype.$echarts = echarts

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
