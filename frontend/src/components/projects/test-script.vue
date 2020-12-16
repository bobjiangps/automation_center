<template>
  <div :style="{backgroundColor: '#FFF', margin: '20px', minHeight: '640px'}">
    <a-table
      :columns="tableColumns"
      :data-source="tableData"
      :loading="loading"
      class="components-table-demo-nested"
    >
      <a slot="operation" slot-scope="text">Publish</a>
      <a-table
        slot="expandedRowRender"
        slot-scope="text"
        :columns="tableInnerColumns"
        :data-source="tableInnerData"
        :pagination="false"
      >
        <span slot="status" slot-scope="text"> <a-badge status="success" />Finished </span>
        <span slot="operation" slot-scope="text" class="table-operation">
          <a>Pause</a>
          <a>Stop</a>
          <a-dropdown>
            <a-menu slot="overlay">
              <a-menu-item>
                Action 1
              </a-menu-item>
              <a-menu-item>
                Action 2
              </a-menu-item>
            </a-menu>
            <a> More <a-icon type="down" /> </a>
          </a-dropdown>
        </span>
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
      tableInnerData: '',
      tableInnerColumns: '',
      scripts: '',
      loading: false
    };
  },

  created: function() {

    this.tableColumns = [
      { title: 'Name', dataIndex: 'name', key: 'name', sorter: true, scopedSlots: { customRender: 'name' } },
      { title: 'Version', dataIndex: 'version', key: 'version' },
      { title: 'Status', dataIndex: 'status', key: 'status' },
      { title: 'Author', dataIndex: 'author', key: 'author' },
      { title: 'Maintainer', dataIndex: 'maintainer', key: 'maintainer' },
      { title: 'Tag', dataIndex: 'tag', key: 'tag' },
    ];

    this.tableInnerColumns = [
      { title: 'Date', dataIndex: 'date', key: 'date' },
      { title: 'Name', dataIndex: 'name', key: 'name' },
      { title: 'Status', key: 'state', scopedSlots: { customRender: 'status' } },
      { title: 'Upgrade Status', dataIndex: 'upgradeNum', key: 'upgradeNum' },
      {
        title: 'Action',
        dataIndex: 'operation',
        key: 'operation',
        scopedSlots: { customRender: 'operation' },
      },
    ];

    this.tableInnerData = [];
    for (let i = 0; i < 3; ++i) {
      this.tableInnerData.push({
        key: i,
        date: '2014-12-24 23:12:00',
        name: 'This is production name',
        upgradeNum: 'Upgraded: 56',
      });
    }
  },

  mounted: function() {
    this.loading = true;
    this.$http.get(`${this.$http.defaults.baseURL}/projects/2/test-scripts/`)
      .then(response => {
        this.scripts = response.data["results"];
        for (let i = 0; i < this.scripts.length; i++) {
          var script = this.scripts[i];
          this.tableData.push({
            key: i,
            name: script["name"],
            version: script["version"],
            status: script["status"],
            author: script["author"],
            maintainer: script["maintainer"],
            tag: script["tag"],
          });
        }
        this.loading = false;
      })
      .catch(err => {console.log(err)})
  },

};
</script>
