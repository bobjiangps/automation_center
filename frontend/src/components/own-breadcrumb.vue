<template>
  <a-breadcrumb>
    <a-breadcrumb-item href="">
      <a-icon type="home" />
    </a-breadcrumb-item>
    <a-breadcrumb-item href="">
      {{this.$options.name}}
    </a-breadcrumb-item>
    <a-breadcrumb-item>
      {{this.$route.meta.breadcrumb}}
    </a-breadcrumb-item>
  </a-breadcrumb>
</template>

<script>
export default {
  name: 'OwnBreadCrumb',

  data () {
    return {
      msg: ''
    };
  }

};
</script>
