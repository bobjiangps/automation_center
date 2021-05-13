<template>
  <div :style="{backgroundColor: '#FFF', margin: '20px', minHeight: '640px'}">
    <a-table
      :columns="tableColumns"
      :data-source="tableData"
      :loading="loading"
      @expand="retrieveCases"
      class="components-table-nested"
    >
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
        slot-scope="text"
        :columns="tableInnerColumns"
        :data-source="tableInnerData"
        :pagination="false"
      >
        <span slot="status" slot-scope="text"> <a-badge status="success" />Finished </span>
      </a-table>
    </a-table>
  </div>
</template>

<script>
export default {
  name: 'ProjectTestScripts',
  data() {
    return {
      tableData: [],
      tableColumns: '',
      tableInnerData: [],
      tableInnerColumns: '',
      scripts: '',
      cases: '',
      loading: false
    };
  },

  created: function() {

    this.tableColumns = [
      { dataIndex: 'name', key: 'name', sorter: true, slots: { title: 'customTitle' } },
      { title: 'Version', dataIndex: 'version', key: 'version' },
      { title: 'Status', dataIndex: 'status', key: 'status', sorter: true },
      { title: 'Author', dataIndex: 'author', key: 'author' },
      { title: 'Maintainer', dataIndex: 'maintainer', key: 'maintainer' },
      { title: 'Tags', dataIndex: 'tags', key: 'tags', scopedSlots: { customRender: 'tagsCustom' }, },
    ];

    this.tableInnerColumns = [
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
    retrieveScripts() {
      this.loading = true;
      this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-scripts/`)
        .then(response => {
          this.scripts = response.data["results"];
          for (let i = 0; i < this.scripts.length; i++) {
            var script = this.scripts[i];
            this.tableData.push({
              key: i,
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

    retrieveCases(expanded, record) {
      if (expanded) {
        this.$http.get(`${this.$http.defaults.baseURL}/projects/${this.$route.params.project_id}/test-scripts/${record.id}/automation-case`)
          .then(response => {
            if (this.cases.length > 0) {
              this.cases.splice(0, this.cases.length);
              this.tableInnerData.splice(0, this.tableInnerData.length);
            }
            this.cases = response.data["results"];
            for (let i = 0; i < this.cases.length; i++) {
              var autoCase = this.cases[i];
              var autoCaseNameSplit = autoCase["name"].split(":");
              this.tableInnerData.push({
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

  }

};
</script>
