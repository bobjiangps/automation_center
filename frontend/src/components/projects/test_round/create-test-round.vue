<template>
  <div v-if="this.$store.state.token">
    <a-spin :spinning="loading">
      <a-form id="create-test-round" :form="form" @submit="submitRoundForm">
        <h3>{{header_message}}</h3>
        <a-form-item v-bind="formItemLayout" label="Name">
          <a-input
            v-decorator="[
            'name',
            {
              rules: [{
                required: true, message: 'Please input test round name',
              }]
            }
          ]"
          />
        </a-form-item>
        <a-form-item v-bind="formItemLayout" label="Test Suite">
          <a-select
            show-search
            :options="testSuites"
            v-decorator="[
            'test_suite',
            {
              rules: [{
                required: true, message: 'Please select test suite'
              }],
              initialValue: testSuites[0].value
            }
          ]"
          ></a-select>
        </a-form-item>
        <a-form-item :wrapper-col="{ span: 16, offset: 12 }">
          <a-row :gutter="16">
            <a-col :span="5">
              <a-button type="primary" html-type="submit">Save</a-button>
              <a-button @click="$router.go(-1)">Back</a-button>
            </a-col>
          </a-row>
        </a-form-item>
      </a-form>
    </a-spin>
  </div>
  <div v-else>
    <h1>Login to view this page</h1>
  </div>
</template>

<script>
export default {
  name: 'ProjectCreateTestRound',
  data() {
    return {
      formItemLayout: {
        labelCol: { span: 3 },
        wrapperCol: { span: 6 }
      },
      form: this.$form.createForm(this),
      testSuites: [{key: 0, title: ''}],
      suiteTypes: [],
      scriptAuthors: [],
      scripts: [],
      suiteScripts: [],
      filterParams: { s: '', tag: '', author: 'Select Author', page_size: 10000 },
      header_message: 'Create New Test Round',
      currentRoundId: '',
      loading: false
    };
  },

  mounted: function() {
    this.loading = true;
    this.retrieveTestSuites();
    //this.retrieveSuiteTypes();
    //this.retrieveScriptAuthors();
    //this.retrieveScripts();
    this.loading = false;
  },

  methods: {
    retrieveTestSuites() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-suites/`)
        .then(response => {
          this.testSuites = [];
          let allTestSuites = response.data["results"];
          for (let i = 0; i < allTestSuites.length; i++) {
            this.testSuites.push({
              key: allTestSuites[i]["id"],
              value: allTestSuites[i]["name"],
              label: allTestSuites[i]["name"],
              title: allTestSuites[i]["name"],
              disabled: false
            })
          }
        })
        .catch(err => {console.log(err)});
    },


    retrieveScriptAuthors() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-script-authors/`)
        .then(response => {
          this.scriptAuthors = [];
          let testScriptAuthors = response.data["test_script_authors"];
          for (let i = 0; i < testScriptAuthors.length; i++) {
            this.scriptAuthors.push({
              key: i,
              value: testScriptAuthors[i],
              label: testScriptAuthors[i],
              title: testScriptAuthors[i],
              disabled: false
            })
          }
        })
        .catch(err => {console.log(err)});
    },

    retrieveScripts(params = this.filterParams) {
      let filterParamsTemp = {};
      for (let key in params) {
        filterParamsTemp[key] = params[key];
      }
      if (filterParamsTemp["author"].indexOf("Select") != -1) {
        delete filterParamsTemp["author"];
      }
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-scripts/`, { params: filterParamsTemp })
        .then(response => {
          this.scripts = [];
          let testScripts = response.data["results"];
          for (let i = 0; i < testScripts.length; i++) {
            this.scripts.push({
              key: testScripts[i]["id"].toString(),
              title: testScripts[i]["name"],
            })
          }
        })
        .catch(err => {console.log(err)});
    },

    retrieveSuite(id) {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-suites/${this.$route.params.suite_id}/`)
        .then(response => {
          this.suiteScripts = response.data["script"].map(script => {
            return script.toString();
          });
          this.form.setFieldsValue({
            name: response.data["name"],
            suite_type: response.data["suite_type"],
            auto_script_ids: this.suiteScripts
          });
        })
        .catch(err => {console.log(err)});
    },

    searchScripts() {
      this.retrieveScripts(this.filterParams);
    },

    resetSearch() {
      this.filterParams = { s: '', tag: '', author: 'Select Author', page_size: 10000 };
      this.retrieveScripts(this.filterParams);
    },

    handleChange(targetKeys) {
      this.suiteScripts = targetKeys;
    },

    createSuite(params) {
      console.log("post create");
      return this.$http.post(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-suites/`, params);
    },

    editSuite(params) {
      return this.$http.put(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-suites/${this.currentSuiteId}/`, params);
    },


    submitRoundForm(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log(values);
        }
      });
    },

    submitRoundForm2(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          this.loading = true;
          const createSuiteParams = {
            name: values.name,
            project: this.$route.params.project_id,
            script: values.auto_script_ids,
            suite_type: values.suite_type
          };
          let request =
            this.currentSuiteId === ''
              ? this.createSuite(createSuiteParams)
              : this.editSuite(createSuiteParams);
          console.log(request);
          request
            .then(response => {
              this.$router.push({
                name: "test_suite",
                params: { project_id: this.$route.params.project_id }
              });
              this.$message.success("Save suite successfully!");
            })
            .catch(err => {console.log(err)})
            .finally(() => {
              this.loading = false;
            });
        }
      });
    },

  }

};
</script>

<style scoped>
#create-test-round {
  padding: 20px;
}
</style>
