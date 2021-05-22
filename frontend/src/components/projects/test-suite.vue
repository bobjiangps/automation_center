<template>
  <div>
    <a-table
      :columns="suiteColumns"
      :data-source="suiteData"
      :loading="loading"
      :pagination="pagination"
      :rowKey="record => record.id"
      @change="handleTableChange"
      size="small"
    >
      <template slot="title">
        <div>
          <a-row>
            <a-col :span="12" id="search" style="text-align: left; padding: 0 5px 0;">
              <a-input-search
                v-model="filterParams.s"
                placeholder="search"
                style="width: 200px;"
                @search="searchByKeyword"
              />
            </a-col>
            <a-col :span="12" style="text-align: right; padding: 0 10px 0;">
              <a-button type="primary" v-if="this.$store.state.token">
                <router-link :to="{ name: 'create_test_suite' }">Create</router-link>
              </a-button>
            </a-col>
          </a-row>
        </div>
      </template>
    </a-table>
  </div>
</template>

<script>
export default {
  name: 'ProjectTestScripts',
  data() {
    return {
      suiteData: [],
      suiteColumns: '',
      suites: '',
      pagination: {},
      filterParams: { s: '' },
      results_per_page: '',
      loading: false
    };
  },

  created: function() {

    this.suiteColumns = [
      { title: 'Name', dataIndex: 'name', key: 'name', sorter: true},
      { title: 'Type', dataIndex: 'suite_type', key: 'suite_type', sorter: true },
      { title: 'Script Amount', dataIndex: 'script_amount', key: 'script_amount' },
      { title: 'Case Amount', dataIndex: 'case_amount', key: 'case_amount' },
    ];

  },

  mounted: function() {
    this.retrieveSuites();
  },

  methods: {
    retrieveSuites(params = this.filterParams) {
      this.loading = true;
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-suites/`, { params: params })
        .then(response => {
          const pagination = { ...this.pagination };
          if (this.results_per_page == '') {
            this.results_per_page = response.data["results"].length;
          }
          pagination.pageSize = this.results_per_page;
          pagination.total = response.data["count"]
          this.pagination = pagination;
          this.suites = response.data["results"];
          this.suiteData.splice(0, this.suiteData.length);
          for (let i = 0; i < this.suites.length; i++) {
            var suite = this.suites[i];
            this.suiteData.push({
              id: suite["id"],
              name: suite["name"],
              suite_type: suite["suite_type"],
              script_amount: suite["script_amount"],
              case_amount: suite["case_amount"]
            });
          }
          this.loading = false;
        })
        .catch(err => {console.log(err)});
    },

    searchByKeyword() {
      this.retrieveSuites(this.filterParams);
    },

    handleTableChange(pagination, filters, sorter) {
      const pager = { ...this.pagination };
      pager.current = pagination.current;
      this.pagination = pager;
      search = this.filterParams.s;
      if ('order' in sorter) {
        this.filterParams = {
          s: search,
          page: pagination.current,
          order_by: sorter.field,
          order_type: sorter.order.split("end")[0],
          ...filters,
        };
      }
      else {
        this.filterParams = {
          s: search,
          page: pagination.current,
          ...filters,
        };
      }
      this.retrieveSuites(this.filterParams);
    },

  }

};
</script>
