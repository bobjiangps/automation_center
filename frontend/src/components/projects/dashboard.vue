<template>
  <div :style="{backgroundColor: '#FFF', margin: '20px'}">
    <a-row type="flex" justify="space-around" :style="{margin: '10px 10px 0px 10px'}">
      <a-col :span="11">
        <a-card title="Automation Coverage by Year" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="coverageByYear" :style="{width: '100%', height: '400px'}"></div>
        </a-card>
      </a-col>
      <a-col :span="11">
        <a-card title="Automation Coverage by Priority" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="coverageByPriority" :style="{width: '90%', height: '400px', padding: '0px 10px 0px 0px'}"></div>
        </a-card>
      </a-col>
    </a-row>
    <a-row type="flex" justify="space-around" :style="{margin: '0px 10px 10px 10px'}">
      <a-col :span="11">
        <a-card title="Overall Automation Status" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="overallAutomationStatus" :style="{width: '100%', height: '400px'}"></div>
        </a-card>
      </a-col>
      <a-col :span="11">
        <a-card title="To Be Changed" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="toBeChanged" :style="{width: '90%', height: '400px'}"></div>
        </a-card>
      </a-col>
    </a-row>
  </div>
</template>

<script>
export default {
  name: 'ProjectDashboard',
  data () {
    return {
      projects: [],
      coverage_by_year_chart: '',
      coverage_by_priority_chart: '',
      overall_automation_status_chart: '',
      temp: ''
    }
  },

  created: function() {
    this.$http.get(`${this.$http.defaults.baseURL}/projects/automated_case_amount/`)
      .then(response => {
        this.temp = response.data["count"];
      })
      .catch(err => {console.log(err)})
  },

  mounted: function() {
    this.draw_coverage_by_year_chart();
    this.draw_coverage_by_priority_chart();
    this.draw_overall_automation_status_chart();

    var myEvent = new Event('resize');
    window.dispatchEvent(myEvent);
  },

  methods: {
    draw_coverage_by_year_chart: function() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/mock_automation_coverage/`)
        .then(response => {
          this.coverage_by_year_chart = this.$echarts.init(document.getElementById('coverageByYear'));
          this.coverage_by_year_chart.setOption({
              tooltip : {
                  trigger: 'axis',
                  formatter: function (params) {
                    var html=params[0].name+"<br>";
                      for(var i=0;i<params.length;i++){
                         html+='<span style="display:inline-block;margin-right:5px;border-radius:10px;width:10px;height:10px;background-color:'+params[i].color+';"></span>'
                          if(params[i].valueType=="percent"){
                              html+=params[i].seriesName+": "+params[i].value+"%<br>";
                          }else{
                            html+=params[i].seriesName+": "+params[i].value+"<br>";
                          }
                      }
                      return html;
                  },
                  axisPointer: {
                      type: 'cross',
                      crossStyle: {
                          color: '#999'
                      }
                  }
              },
              //toolbox: {
              //    feature: {
              //        saveAsImage: {show: true}
              //    }
              //},
              legend: {
                  data: ['Automated', 'Manual', 'Not Candidate', 'Automation Coverage'],
                  y: 'bottom'
              },
              xAxis: [
                  {
                      type: 'category',
                      data: ['2018', '2019', '2020'],
                      axisPointer: {
                          type: 'shadow'
                      }
                  }
              ],
              yAxis: [
                  {
                      type: 'value',
                      name: 'Case Amount',
                      min: 0,
                      max: 1500,
                      axisLabel: {
                          formatter: '{value}'
                      }
                  },
                  {
                      type: 'value',
                      name: 'Coverage',
                      min: 0,
                      max: 100,
                      axisLabel: {
                          formatter: '{value} %'
                      }
                  }
              ],
              series: [
                  {
                      name: 'Automated',
                      type: 'bar',
                      stack: '总量',
                      color: '#8BBA72',
                      label: {
                          show: true,
                          position: 'inside'
                      },
                      data: response.data["automated"]
                  },
                  {
                      name: 'Manual',
                      type: 'bar',
                      stack: '总量',
                      color: '#E54D42',
                      label: {
                          show: true,
                          position: 'inside'
                      },
                      data: response.data["manual"]
                  },
                  {
                      name: 'Not Candidate',
                      type: 'bar',
                      stack: '总量',
                      color: '#DCDCDC',
                      label: {
                          show: true,
                          position: 'inside'
                      },
                      data: response.data["not_candidate"]
                  },
                  {
                      name: 'Automation Coverage',
                      type: 'line',
                      yAxisIndex: 1,
                      color: '#3A99D8',
                      data: response.data["coverage"],
                      valueType: 'percent'
                  }
              ]
          });
        })
        .catch(err => {console.log(err)})
    },

    draw_coverage_by_priority_chart: function() {
      this.coverage_by_priority_chart = this.$echarts.init(document.getElementById('coverageByPriority'));
      this.coverage_by_priority_chart.setOption({
          tooltip : {
              trigger: 'axis',
              formatter: function (params) {
                var html=params[0].name+"<br>";
                  for(var i=0;i<params.length;i++){
                     html+='<span style="display:inline-block;margin-right:5px;border-radius:10px;width:10px;height:10px;background-color:'+params[i].color+';"></span>'
                      if(params[i].valueType=="percent"){
                          html+=params[i].seriesName+": "+params[i].value+"%<br>";
                      }else{
                        html+=params[i].seriesName+": "+params[i].value+"<br>";
                      }
                  }
                  return html;
              },
              axisPointer: {
                  type: 'cross',
                  crossStyle: {
                      color: '#999'
                  }
              }
          },
          legend: {
              data: ['Automated', 'Manual', 'Not Candidate', 'Automation Coverage'],
              y: 'bottom'
          },
          xAxis: [
              {
                  type: 'category',
                  data: ['P1', 'P2', 'P3'],
                  axisPointer: {
                      type: 'shadow'
                  }
              }
          ],
          yAxis: [
              {
                  type: 'value',
                  name: 'Case Amount',
                  min: 0,
                  max: 800,
                  axisLabel: {
                      formatter: '{value}'
                  }
              },
              {
                  type: 'value',
                  name: 'Coverage',
                  min: 0,
                  max: 100,
                  axisLabel: {
                      formatter: '{value} %'
                  }
              }
          ],
          series: [
              {
                  name: 'Automated',
                  type: 'bar',
                  stack: '总量',
                  color: '#8BBA72',
                  label: {
                      show: true,
                      position: 'inside'
                  },
                  data: [270, 705, 105]
              },
              {
                  name: 'Manual',
                  type: 'bar',
                  stack: '总量',
                  color: '#E54D42',
                  label: {
                      show: true,
                      position: 'inside'
                  },
                  data: [13, 35, 32]
              },
              {
                  name: 'Not Candidate',
                  type: 'bar',
                  stack: '总量',
                  color: '#DCDCDC',
                  label: {
                      show: true,
                      position: 'inside'
                  },
                  data: [7, 22, 11]
              },
              {
                  name: 'Automation Coverage',
                  type: 'line',
                  yAxisIndex: 1,
                  color: '#3A99D8',
                  data: [95.4, 95.27, 76.64],
                  valueType: 'percent'
              }
          ]
      });
    },

    draw_overall_automation_status_chart: function() {
      this.overall_automation_status_chart = this.$echarts.init(document.getElementById('overallAutomationStatus'));
      this.overall_automation_status_chart.setOption({
          tooltip: {
              trigger: 'item',
              formatter: '{a} <br/>{b} : {c} ({d}%)'
          },
          legend: {
              left: 'center',
              top: 'bottom',
              data: ['Automated', 'Manual', 'Pending', 'Impossible', 'Unknown']
          },
          series: [
              {
                  name: 'Overall Status',
                  type: 'pie',
                  radius: [30, 110],
                  center: ['50%', '50%'],
                  roseType: 'area',
                  data: [
                      {value: 480, name: 'Automated', color: '#8BBA72'},
                      {value: 180, name: 'Manual', color: '#E54D42'},
                      {value: 200, name: 'Pending'},
                      {value: 50, name: 'Impossible'},
                      {value: 15, name: 'Unknown'}
                  ],
                  color: ['#8BBA72', '#E54D42', '#3A99D8', '#DCDCDC', '#000000']
              }
          ]
      });
    },

  }

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
