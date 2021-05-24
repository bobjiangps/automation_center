<template>
  <div v-if="this.$store.state.token">
    <a-form id="create-test-suite" :form="form" @submit="createTestSuite">
      <h3>Create New Test Suite</h3>
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
      <a-form-item :labelCol="{ span: 3 }" :wrapperCol="{ span: 16 }" label="Scripts Selector">
        <a-row :gutter="10">
          <a-col :span="7">
            <a-input v-model="filterParams.s" placeholder="Search by script name" @pressEnter="searchScripts"/>
          </a-col>
          <a-col :span="5">
            <a-input v-model="filterParams.tag" placeholder="Search by tag" @pressEnter="searchScripts"/>
          </a-col>
          <a-col :span="5">
            <a-select
              v-model="filterParams.author"
              :options="scriptAuthors"
            />
          </a-col>
          <a-col :span="4">
            <a-button @click="searchScripts" type="primary">
              <a-icon type="search"/>
            </a-button>
            <a-button @click="resetSearch">
              <a-icon type="reload"/>
            </a-button>
          </a-col>
        </a-row>
      </a-form-item>
      <a-form-item :labelCol="{ span: 3 }" :wrapperCol="{ span: 16, offset: 1 }">
        <a-transfer
          :listStyle="{
            width: '250px',
            height: '300px'
          }"
          showSearch
          :dataSource="scripts"
          :targetKeys="suiteScripts"
          @change="handleChange"
          @search="handleSearch"
          :render="item=>item.title"
          v-decorator="[
          'auto_script_ids',
          {
            rules: [{
              required: true, message: 'Please select at least 1 script!',
            }]
          }
        ]"
        ></a-transfer>
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
      scriptAuthors: [],
      scripts: [],
      suiteScripts: [],
      filterParams: { s: '', tag: '', author: 'Select Author', page_size: 10000 },
      loading: false
    };
  },

  created: function() {
    this.loading = true;
    this.retrieveSuiteTypes();
    this.retrieveScriptAuthors();
    this.retrieveScripts();
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
              key: i.toString(),
              title: testScripts[i]["name"],
            })
          }
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

    handleSearch(dir, value) {
      console.log('search:', dir, value);
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
