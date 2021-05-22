<template>
  <div v-if="this.$store.state.token">
    <a-form id="create-test-suite" :form="form" @submit="createTestSuite">
      <a-form-item v-bind="formItemLayout" label="Name">
        <a-input
          v-decorator="[
          'name',
          {
            rules: [{
              required: true, message: 'Please input test suite name',
            }]
          }
        ]"
        />
      </a-form-item>
      <a-form-item v-bind="formItemLayout" label="Suite Type">
        <a-select
          :options="suiteTypes"
          v-decorator="[
          'suite_type_id',
          {
            rules: [{
              required: true, message: 'Please select test suite type'
            }],
            initialValue: 1
          }
        ]"
        ></a-select>
      </a-form-item>
    </a-form>
  </div>
  <div v-else>
    <h1>Login to view this page</h1>
  </div>
</template>

<script>
export default {
  name: 'ProjectCreateTestSuite',
  data() {
    return {
      formItemLayout: {
        labelCol: { span: 3 },
        wrapperCol: { span: 6 }
      },
      form: this.$form.createForm(this, { name: 'coordinated' }),
      suiteTypes: [],
      loading: false
    };
  },

  created: function() {
    this.loading = true;
    this.retrieveSuiteTypes()
    this.loading = false;
  },

  methods: {
    retrieveSuiteTypes() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/test-suite-types/`)
        .then(response => {
          this.suiteTypes = [];
          let testSuiteTypes = response.data["test_suite_types"];
          for (let i = 0; i < testSuiteTypes.length; i++) {
            this.suiteTypes.push({
              key: i,
              value: i,
              label: testSuiteTypes[i],
              title: testSuiteTypes[i],
              disabled: false
            })
          }
        })
        .catch(err => {console.log(err)});
    },

    createTestSuite(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log('Received values of form: ', values);
        }
      });
    },

  }

};
</script>

<style scoped>
#create-test-suite {
  padding: 20px;
}
</style>
