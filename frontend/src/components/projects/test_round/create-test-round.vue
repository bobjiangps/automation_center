<template>
  <div v-if="this.$store.state.token">
    <a-spin :spinning="loading">
      <a-form id="create-test-round" :form="form" @submit="submitRoundForm">
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
            placeholder="Select Test Suite"
            :options="testSuites"
            optionFilterProp="children"
            v-decorator="[
            'test_suite',
            {
              rules: [{
                required: true, message: 'Please select test suite'
              }],
            }
          ]"
          ></a-select>
        </a-form-item>
        <a-form-item v-bind="formItemLayout" label="Test Environment">
          <a-select
            show-search
            placeholder="Select Test Environment"
            :options="environments"
            optionFilterProp="children"
            v-decorator="[
            'environment',
            {
              rules: [{
                required: true, message: 'Please select test environment'
              }],
            }
          ]"
          ></a-select>
        </a-form-item>
        <a-form-item v-bind="formItemLayout" label="Platform OS">
          <a-select
            show-search
            placeholder="Select Platform OS"
            :options="platform_os"
            optionFilterProp="children"
            v-decorator="[
            'platform_os',
            {
              rules: [{
                required: true, message: 'Please select platform os'
              }],
            }
          ]"
          ></a-select>
        </a-form-item>
        <span>* If web testing, please select one browser type to run script</span>
        <a-form-item v-bind="formItemLayout" label="Browser">
          <a-select
            show-search
            placeholder="Select Browser"
            :options="browsers"
            optionFilterProp="children"
            v-decorator="[
            'browser',
            ]"
          ></a-select>
        </a-form-item>
        <span>* If mobile testing, please select device and mobile system to run script</span>
        <a-form-item v-bind="formItemLayout" label="Device">
          <a-select
            show-search
            placeholder="Select Device"
            :options="devices"
            optionFilterProp="children"
            v-decorator="[
            'device',
            ]"
          ></a-select>
        </a-form-item>
        <a-form-item v-bind="formItemLayout" label="Mobile OS">
          <a-select
            show-search
            placeholder="Select Mobile OS"
            :options="mobile_os"
            optionFilterProp="children"
            v-decorator="[
            'mobile_os',
            ]"
          ></a-select>
        </a-form-item>
        <a-form-item v-bind="formItemLayout" label="Extra Info">
          <a-input v-decorator="[
              'extra_info'
            ]" />
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
        labelCol: { span: 9 },
        wrapperCol: { span: 6 }
      },
      form: this.$form.createForm(this),
      testSuites: [],
      environments: [],
      devices: [],
      browsers: [],
      mobile_os: [],
      platform_os: [],
      loading: false
    };
  },

  mounted: function() {
    this.loading = true;
    this.retrieveTestSuites();
    this.retrieveExecutionInfo();
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
              value: allTestSuites[i]["id"],
              label: allTestSuites[i]["name"],
              title: allTestSuites[i]["name"],
              disabled: false
            })
          }
        })
        .catch(err => {console.log(err)});
    },

    retrieveExecutionInfo() {
      this.$http.get(`${this.$http.defaults.baseURL}/execution/`)
        .then(response => {
          let env_info = response.data["env"];
          let device_info = response.data["devices"];
          let browser_info = response.data["browsers"];
          let mobile_os_info = response.data["mobile_os"];
          let platform_os_info = response.data["platform_os"];
          this.environments = [];
          for (let i = 0; i < env_info.length; i++) {
            this.environments.push({
              key: env_info[i]["id"],
              value: env_info[i]["id"],
              label: env_info[i]["value"],
              title: env_info[i]["value"],
              disabled: false
            })
          }
          this.devices = [];
          for (let i = 0; i < device_info.length; i++) {
            this.devices.push({
              key: device_info[i]["id"],
              value: device_info[i]["id"],
              label: device_info[i]["value"],
              title: device_info[i]["value"],
              disabled: false
            })
          }
          this.browsers = [];
          for (let i = 0; i < browser_info.length; i++) {
            this.browsers.push({
              key: browser_info[i]["id"],
              value: browser_info[i]["id"],
              label: browser_info[i]["value"],
              title: browser_info[i]["value"],
              disabled: false
            })
          }
          this.mobile_os = [];
          for (let i = 0; i < mobile_os_info.length; i++) {
            this.mobile_os.push({
              key: mobile_os_info[i]["id"],
              value: mobile_os_info[i]["id"],
              label: mobile_os_info[i]["value"],
              title: mobile_os_info[i]["value"],
              disabled: false
            })
          }
          this.platform_os = [];
          for (let i = 0; i < platform_os_info.length; i++) {
            this.platform_os.push({
              key: platform_os_info[i]["id"],
              value: platform_os_info[i]["id"],
              label: platform_os_info[i]["value"],
              title: platform_os_info[i]["value"],
              disabled: false
            })
          }
        })
        .catch(err => {console.log(err)});
    },

    createRound(params) {
      return this.$http.post(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-rounds/`, params);
    },

    submitRoundForm(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          this.loading = true;
          let createRoundParams = {
            name: values.name,
            project: this.$route.params.project_id,
            test_suite: values.test_suite,
            test_environment: values.environment,
            platform_os: values.platform_os,
            creator: this.$store.state.user.id
          }
          if (values.browser) {
            createRoundParams.browser = values.browser;
          }
          if (values.device) {
            createRoundParams.device = values.device;
          }
          if (values.mobile_os) {
            createRoundParams.mobile_os = values.mobile_os;
          }
          if (values.extra_info) {
            createRoundParams.extra_info = values.extra_info;
          }
          this.createRound(createRoundParams)
            .then(response => {
              this.$router.push({
                name: "test_round",
                params: { project_id: this.$route.params.project_id }
              });
              this.$message.success("Save round successfully!");
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
