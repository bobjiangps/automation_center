<template>
  <div style="margin: 20px;">
    <a-row type="flex" justify="space-around" :style="{backgroundColor: '#FFF', margin: '20px'}">
      <a-col :span="11">
        <a-card title="Automation Coverage by Year" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="coverageByYear" :style="{width: '100%', height: '400px'}"></div>
        </a-card>
      </a-col>
      <a-col :span="11">
        <a-card title="Automation Coverage Diff to Last Year" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="coverageDiffByYear" :style="{width: '100%', height: '400px'}"></div>
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
      coverage_diff_by_year_chart: '',
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
    this.$http.get(`${this.$http.defaults.baseURL}/projects/names/`)
      .then(response => {
        this.projects = response.data["names"];
        this.draw_coverage_by_year_chart();
        this.draw_coverage_diff_by_year_chart();
      })
      .catch(err => {console.log(err)})

    var myEvent = new Event('resize');
    window.dispatchEvent(myEvent);
  },

  methods: {
    logout: function () {
      this.$store.dispatch('logout')
      .then(() => {
        this.$router.push('/login')
      })
    },

    draw_coverage_by_year_chart: function() {
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
                  data: [670, 1020, 1080]
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
                  data: [220, 120, 80]
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
                  data: [110, 60, 40]
              },
              {
                  name: 'Automation Coverage',
                  type: 'line',
                  yAxisIndex: 1,
                  color: '#3A99D8',
                  data: [67, 85, 90],
                  valueType: 'percent'
              }
          ]
      });
    },

    draw_coverage_diff_by_year_chart: function() {
      this.coverage_diff_by_year_chart = this.$echarts.init(document.getElementById('coverageDiffByYear'));
      this.coverage_diff_by_year_chart.setOption({
       tooltip: {
          trigger: 'item',
          formatter:'{b}: {c}%'
        },
        xAxis: {
            type: 'value',
            axisLabel: {
              formatter: '{value} %'
            },
            position: 'top',
            //max: 50,
            //min: -50,
            splitLine: {
                lineStyle: {
                    type: 'dashed'
                }
            }
        },
        yAxis: {
            type: 'category',
            axisLine: {
              show: true,
              onZero:true,
              lineStyle:{
                  color:"#000000",
              }
            },
            axisLabel: {show: false},
            axisTick: {show: false},
            splitLine: {show: false},
            data: this.projects
        },
        series: [
            {
                name: 'Coverage Diff',
                type: 'bar',
                stack: '总量',
                label: {
                    show: true,
                    formatter: '{b}'
                },
                itemStyle: {
                    normal: {
                        // barBorderRadius: [0,4,4,0],
                        color: function (data) {
                            return data.value < 0 ? "#E82724" : "#00A212";
                        },
                        label: {
                           show: true,
                           position: 'inside',
                           formatter: '{b}\n{c}%'
                        }
                    },

                },
                data: [
                    -7,
                    47,
                    18
                ]
            }
        ]
      });
    },

    commaFormat(number) {
      //return number.toFixed(2);
      return (number || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, "$1,");
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
