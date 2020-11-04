<template>
  <div :style="{backgroundColor: '#FFF', margin: '20px'}">
    <a-table :columns="tableColumns" :data-source="tableData" class="components-table-demo-nested">
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
      tableData: '',
      tableColumns: '',
      tableInnerData: '',
      tableInnerColumns: ''
    };
  },

  created: function() {
    this.tableColumns = [
      { title: 'Name', dataIndex: 'name', key: 'name' },
      { title: 'Platform', dataIndex: 'platform', key: 'platform' },
      { title: 'Version', dataIndex: 'version', key: 'version' },
      { title: 'Upgraded', dataIndex: 'upgradeNum', key: 'upgradeNum' },
      { title: 'Creator', dataIndex: 'creator', key: 'creator' },
      { title: 'Date', dataIndex: 'createdAt', key: 'createdAt' },
      { title: 'Action', key: 'operation', scopedSlots: { customRender: 'operation' } },
    ];

    this.tableData = [];
    for (let i = 0; i < 3; ++i) {
      this.tableData.push({
        key: i,
        name: 'Screem',
        platform: 'iOS',
        version: '10.3.4.5654',
        upgradeNum: 5001,
        creator: 'Jack',
        createdAt: '2014-12-24 23:12:00',
      });
    }

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

};
</script>
