<template>
  <div>
    <a-table
      :columns="roundColumns"
      :data-source="roundData"
      :loading="loading"
      :pagination="pagination"
      :rowKey="record => record.id"
      @change="handleTableChange"
      size="middle"
      style="padding: 5px"
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
                <router-link :to="{ name: 'create_test_round' }">Create</router-link>
              </a-button>
            </a-col>
          </a-row>
        </div>
      </template>
      <template slot="number" slot-scope="index, row"> <!-- index and row and two parameters passed, can be any name you assigned; the first is the key, the second is row data; -->
        <a-icon :type="resultIcon[row.result]" :style="{ fontSize: '120%' }" theme="twoTone" :two-tone-color="resultColor[row.result]" />
        <span>#{{row.number}}</span>
      </template>
      <template slot="action" slot-scope="text, row" v-if="$store.state.token">
        <a-popconfirm
          title="Are you sure stop this round?"
          ok-text="Yes"
          cancel-text="No"
          @confirm="stopRound(row.id)"
        >
          <a-icon type="stop" theme="twoTone" two-tone-color="#CD6839" style="padding-right: 10px;"/>
        </a-popconfirm>
        <a-popconfirm
          title="Are you sure rerun this round?"
          ok-text="Yes"
          cancel-text="No"
          @confirm="rerunRound(row.id)"
        >
          <a-icon type="rollback" />
        </a-popconfirm>
      </template>
    </a-table>
  </div>
</template>

<script>
export default {
  name: 'ProjectTestRounds',
  data() {
    return {
      roundData: [],
      roundColumns: '',
      rounds: '',
      pagination: {},
      filterParams: { s: '' },
      results_per_page: '',
      resultIcon: { NotRun: 'clock-circle', Pass: 'check-circle', Fail: 'close-circle', Warning: 'exclamation-circle'},
      resultColor: { NotRun: '#B0C4DE', Pass: '#52C41A', Fail: '#FF6A6A', Warning: '#FFD700'},
      loading: false
    };
  },

  created: function() {

    this.roundColumns = [
      { title: 'No.', dataIndex: 'number', key: 'number', scopedSlots: { customRender: 'number' } },
      { title: 'Name', dataIndex: 'name', key: 'name' },
      { title: 'Env', dataIndex: 'env', key: 'env' },
      { title: 'Status', dataIndex: 'status', key: 'status' },
      { title: 'P', dataIndex: 'pass', key: 'pass' },
      { title: 'F', dataIndex: 'fail', key: 'fail' },
      { title: 'W', dataIndex: 'warning', key: 'warning' },
      { title: 'N', dataIndex: 'notRun', key: 'notRun' },
      { title: 'Creator', dataIndex: 'creator', key: 'creator' },
      { title: 'Start Time', dataIndex: 'startTime', key: 'startTime' },
      { title: 'End Time', dataIndex: 'endTime', key: 'endTime' },
    ];
    if (this.$store.state.token) {
      this.roundColumns.push({ title: 'Action', dataIndex: 'action', key: 'action', scopedSlots: { customRender: 'action' } });
    }

  },

  mounted: function() {
    this.retrieveRounds();
  },

  methods: {
    retrieveRounds(params = this.filterParams) {
      this.loading = true;
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-rounds/`, { params: params })
        .then(response => {
          const pagination = { ...this.pagination };
          if (this.results_per_page == '') {
            this.results_per_page = response.data["results"].length;
          }
          pagination.pageSize = this.results_per_page;
          pagination.total = response.data["count"]
          this.pagination = pagination;
          this.rounds = response.data["results"];
          this.roundData.splice(0, this.roundData.length);
          for (let i = 0; i < this.rounds.length; i++) {
            var round = this.rounds[i];
            this.roundData.push({
              id: round["id"],
              number: round["id"],
              name: round["name"],
              env: round["test_environment"],
              status: round["status_type"],
              result: round["result_type"],
              pass: round["pass_count"],
              fail: round["fail_count"],
              warning: round["warning_count"],
              notRun: round["not_run_count"],
              creator: round["creator"],
              startTime: round["start_time"],
              endTime: round["end_time"]
            });
          }
        })
        .catch(err => {console.log(err)})
        .finally(() => {
          this.loading = false;
        });
    },

    searchByKeyword() {
      this.retrieveRounds(this.filterParams);
    },

    handleTableChange(pagination, filters, sorter) {
      const pager = { ...this.pagination };
      pager.current = pagination.current;
      this.pagination = pager;
      search = this.filterParams.s;
      this.filterParams = {
        s: search,
        page: pagination.current,
        ...filters,
      };
      this.retrieveRounds(this.filterParams);
    },

    stopRound(id) {
      console.log(`Stop round: ${id} (TBD)`);
    },

    rerunRound(id) {
      console.log(`Rerun round: ${id} (TBD)`);
    },

  }

};
</script>
