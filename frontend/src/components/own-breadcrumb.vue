<template>
  <!--<a-breadcrumb>
    <a-breadcrumb-item href="">
      <a-icon type="home" />
    </a-breadcrumb-item>
    <a-breadcrumb-item href="">
      {{this.$options.name}}
    </a-breadcrumb-item>
    <a-breadcrumb-item>
      {{this.$route.meta.breadcrumb}}
    </a-breadcrumb-item>
  </a-breadcrumb>-->
<a-breadcrumb :routes="routes">
  <template slot="itemRender" slot-scope="{route, params, routes, paths}">
    <span v-if="routes.indexOf(route) === routes.length - 1">
      {{route.breadcrumbName}}
    </span>
    <router-link v-else :to="route.path">
      {{route.breadcrumbName}}
    </router-link>
  </template>
</a-breadcrumb>
</template>

<script>
export default {
  name: 'OwnBreadCrumb',

  props: {
    routes: {
      type: Array,
      required: true
    }
  },

  data () {
    return {
      msg: ''
    };
  }

};
</script>
