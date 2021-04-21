import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/home'
import Login from '@/components/login'
import Project from '@/components/project'
import ProjectDashboard from '@/components/projects/dashboard'
import TestScript from '@/components/projects/test-script'
import store from '../utils/store'

Vue.use(Router)

const ifNotAuthenticated = (to, from, next) => {
  if (!store.getters.isLoggedIn) {
    next()
    return
  }
  next('/')
}

const ifAuthenticated = (to, from, next) => {
  if (store.getters.isLoggedIn) {
    next()
    return
  }
  next('/login')
}

const projectToDashboard = (to, from, next) => {
  next(to.fullPath + 'dashboard')
}

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
      beforeEnter: ifNotAuthenticated,
    },

//    {
//      path: '/projects/:project_id',
//      name: 'project_dashboard',
//      component: ProjectDashboard,
//      meta: {
//         breadcrumb: 'Dashboard'
//      },
//      // component: Project,
//      // beforeEnter: projectToDashboard,
//    },
//    {
//      path: '/projects/:project_id/test-scripts',
//      name: 'test_scripts',
//      component: TestScript,
//      meta: {
//         breadcrumb: 'Test Scripts'
//      },
//    },

    {
      path: '/projects/:project_id',
      name: 'project',
      component: Project,
      children: [
        {
          path: '',
          name: 'project_dashboard',
          component: ProjectDashboard,
          meta: {
             breadcrumb: 'Dashboard'
          },
        },
        {
          path: 'test-scripts',
          name: 'test_scripts',
          component: TestScript,
          meta: {
             breadcrumb: 'Test Scripts'
          },
        },
      ]
    },

    {
      path: '/test',
      name: 'test',
      component: Home,
      beforeEnter: ifAuthenticated,
      // meta: { requireAuth: true }
    }
  ]
});
