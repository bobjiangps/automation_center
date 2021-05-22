<template>
  <div>
    <a-table
      :columns="scriptColumns"
      :data-source="scriptData"
      :loading="loading"
      :pagination="pagination"
      :rowKey="record => record.id"
      @expand="retrieveCases"
      @change="handleTableChange"
      class="components-table-nested"
      size="middle"
    >
      <template slot="title">
        <div id="search" style="text-align: left; padding: 0 5px 0;">
          <a-input-search
            v-model="filterParams.s"
            placeholder="search"
            style="width: 200px;"
            @search="searchByKeyword"
          />
        </div>
      </template>
      <span slot="customTitle"><a-icon type="check-circle" theme="twoTone" two-tone-color="#52c41a" />&ensp;&ensp;Name</span>
      <span slot="tagsCustom" slot-scope="tags">
        <a-tag
          v-for="tag in tags"
          :key="tag"
          :color="tag === 'loser' ? 'volcano' : tag.length > 5 ? 'geekblue' : 'green'"
        >
          {{ tag.toUpperCase() }}
        </a-tag>
      </span>
      <a-table
        slot="expandedRowRender"
        slot-scope="record"
        :columns="caseColumns"
        :data-source="caseData[record.id]"
        :pagination="false"
      >
      </a-table>
    </a-table>
  </div>
</template>

<script>
export default {
  name: 'ProjectTestScripts',
  data() {
    return {
      scriptData: [],
      scriptColumns: '',
      caseData: {},
      caseColumns: '',
      scripts: '',
      cases: {},
      pagination: {},
      filterParams: { s: '' },
      results_per_page: '',
      loading: false
    };
  },

  created: function() {

    this.scriptColumns = [
      { dataIndex: 'name', key: 'name', sorter: true, slots: { title: 'customTitle' } },
      { title: 'Version', dataIndex: 'version', key: 'version' },
      { title: 'Status', dataIndex: 'status', key: 'status', sorter: true },
      { title: 'Author', dataIndex: 'author', key: 'author' },
      { title: 'Maintainer', dataIndex: 'maintainer', key: 'maintainer' },
      { title: 'Tags', dataIndex: 'tags', key: 'tags', scopedSlots: { customRender: 'tagsCustom' }, },
    ];

    this.caseColumns = [
      { title: 'Case ID', dataIndex: 'caseid', key: 'caseid' },
      { title: 'Case Name', dataIndex: 'casename', key: 'casename' },
      { title: 'Create Time', dataIndex: 'createtime', key: 'createtime' },
      { title: 'Update Time', dataIndex: 'updatetime', key: 'updatetime' },
    ];

  },

  mounted: function() {
    this.retrieveScripts();
  },

  methods: {
    retrieveScripts(params = this.filterParams) {
      this.loading = true;
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-scripts/`, { params: params })
        .then(response => {
          const pagination = { ...this.pagination };
          //pagination.pageSize = response.data["results"].length;
          if (this.results_per_page == '') {
            this.results_per_page = response.data["results"].length;
          }
          pagination.pageSize = this.results_per_page;
          pagination.total = response.data["count"]
          this.pagination = pagination;
          this.scripts = response.data["results"];
          this.scriptData.splice(0, this.scriptData.length);
          for (let i = 0; i < this.scripts.length; i++) {
            var script = this.scripts[i];
            this.scriptData.push({
              //key: i,
              id: script["id"],
              name: script["name"],
              version: script["version"],
              status: script["status"],
              author: script["author"],
              maintainer: script["maintainer"],
              tags: script["tag"].split(","),
            });
          }
          this.loading = false;
        })
        .catch(err => {console.log(err)});
    },

    searchByKeyword() {
      this.retrieveScripts(this.filterParams);
    },

    retrieveCases(expanded, record) {
      if (expanded) {
        var retrieve = false;
        if (typeof(this.caseData[record.id]) == "undefined") {
          retrieve = true;
        }
        else if (this.caseData[record.id].length == 0) {
          retrieve = true;
        }
        if (retrieve) {
          this.$set(this.caseData, record.id, []);
          this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-scripts/${record.id}/automation-case`)
            .then(response => {
              var recordId = record.id;
              this.cases[recordId] = response.data["results"];
              this.caseData[recordId] = [];
              for (let i = 0; i < this.cases[recordId].length; i++) {
                var autoCase = this.cases[recordId][i];
                var autoCaseNameSplit = autoCase["name"].split(":");
                this.caseData[recordId].push({
                  key: i,
                  caseid: autoCaseNameSplit[0],
                  casename: autoCaseNameSplit[1].trim(),
                  createtime: autoCase["create_time"],
                  updatetime: autoCase["update_time"]
                });
              }
              this.loading = false;
            })
            .catch(err => {console.log(err)});
          }
        }
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
      this.retrieveScripts(this.filterParams);
    },

  }

};
</script>
