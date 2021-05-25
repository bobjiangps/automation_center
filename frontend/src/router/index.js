import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/home'
import Login from '@/components/login'
import Project from '@/components/project'
import PageBase from '@/components/page-base'
import ProjectDashboard from '@/components/projects/dashboard'
import TestSuite from '@/components/projects/test_suite/test-suite'
import CreateTestSuite from '@/components/projects/test_suite/create-test-suite'
import TestScript from '@/components/projects/test-script'
import TestReport from '@/components/projects/test-report'
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
          path: 'test-suites',
          name: 'test_suites_base',
          component: PageBase,
          meta: {
             breadcrumb: 'Test Suites'
          },
          children: [
            {
              path: '',
              name: 'test_suite',
              component: TestSuite,
            },
            {
              path: 'create',
              name: 'create_test_suite',
              component: CreateTestSuite,
              meta: {
                breadcrumb: 'Create'
              },
            },
            {
              path: ':suite_id',
              name: 'edit_test_suite',
              component: CreateTestSuite,
              meta: {
                breadcrumb: 'Edit'
              },
            },
          ]
        },
        {
          path: 'test-scripts',
          name: 'test_scripts',
          component: TestScript,
          meta: {
             breadcrumb: 'Test Scripts'
          },
        },
        {
          path: 'test-reports',
          name: 'test_reports',
          component: TestReport,
          meta: {
             breadcrumb: 'Test Reports'
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
