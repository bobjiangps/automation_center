<template>
  <div style="margin: 20px;">
    <a-row type="flex" justify="space-around">
      <a-col :span="7" :style="{ padding: '10px', backgroundColor: '#FFF', textAlign: 'left', border: 'solid', borderColor: '#FFF #FFF #FFF #1874CD' }">
        <h2 :style="{ color: '#1874CD', padding: '5px 0px 0px 0px', fontWeight: 'bold' }">Projects Total:
          <!--<span id="projects-total-count">{{this.summary.projects_total}}</span>-->
          <number :from=animate_number.from :to=summary.projects_total :duration=animate_number.duration :delay=animate_number.delay />
          <font-awesome-icon :icon="[ 'fas', 'project-diagram' ]" :style="{ float: 'right', padding: '5px 0px 0px 0px' }" />
        </h2>
      </a-col>
      <a-col :span="7" :style="{ padding: '10px', backgroundColor: '#FFF', textAlign: 'left', border: 'solid', borderColor: '#FFF #FFF #FFF #6CA6CD' }">
        <h2 :style="{ color: '#6CA6CD', padding: '5px 0px 0px 0px', fontWeight: 'bold' }">Projects Running:
          <!--<span id="projects-running-count">{{this.summary.projects_running}}</span>-->
          <number :from=animate_number.from :to=summary.projects_running :duration=animate_number.duration :delay=animate_number.delay />
          <font-awesome-icon :icon="[ 'fas', 'running' ]" :style="{ float: 'right', padding: '5px 0px 0px 0px' }" />
        </h2>
      </a-col>
      <a-col :span="7" :style="{ padding: '10px', backgroundColor: '#FFF', textAlign: 'left', border: 'solid', borderColor: '#FFF #FFF #FFF #1CC88A' }">
        <h2 :style="{ color: '#1CC88A', padding: '5px 0px 0px 0px', fontWeight: 'bold' }">Automated Cases:
          <!--<span id="automated-cases-count">{{this.summary.automated_cases}}</span>-->
          <number :from=animate_number.from :to=summary.automated_cases :duration=animate_number.duration :delay=animate_number.delay />
          <font-awesome-icon :icon="[ 'fas', 'clipboard-check' ]" :style="{ float: 'right', padding: '5px 0px 0px 0px' }" />
        </h2>
      </a-col>
    </a-row>
    <a-row type="flex" justify="space-around" :style="{backgroundColor: '#FFF', margin: '20px'}">
      <a-col :span="11">
        <a-card title="Automation Coverage by Project" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="coverageByProjects" :style="{width: '90%', height: '400px'}"></div>
        </a-card>
      </a-col>
      <a-col :span="11">
        <a-card title="Automation Coverage Diff to Last Year" :style="{margin: '20px 0px'}" :headStyle="{color:'#1874CD', fontWeight: 'bold'}">
          <div id="coverageDiffByYear" :style="{width: '90%', height: '400px'}"></div>
        </a-card>
      </a-col>
    </a-row>
    <!--<h3>{{ msg }}</h3>
    <button type="button" @click='getProjects' :style="{ margin: '10px', padding: '5px' }">get projects</button>
    <a-button type="primary">Button</a-button>
    <a v-if="this.$store.state.token" @click="logout" :style="{ margin: '10px', padding: '5px' }">Logout</a>
    <router-link v-else to="/login" :style="{ margin: '10px', padding: '5px' }">Login</router-link>
    <p>{{ auth_text }}</p>
    <p>{{ this.$store.state.token }}</p>
    <p>{{ this.$store.state.status }}</p>
    <p>{{ this.$store.state.user }}</p>
    <p>{{ this.$store.getters.isLoggedIn }}</p>
    <p>{{ this.$store.getters.authStatus }}</p>
    <table v-if="auth.length > 0" :style="{ border: '2px solid gray', borderRadius: '5px', padding: '10px' }" align='center'>
      <tr v-for='a in auth'>
        <td>{{ a.id }}</td>
        <td>{{ a.username }}</td>
        <td>{{ a.email }}</td>
        <td>{{ a.token }}</td>
      </tr>
    </table>
    <table :style="{ border: '2px solid gray', borderRadius: '5px', padding: '10px' }" align='center'>
      <tr v-for='p in projects'>
        <td>{{ p.id }}</td>
        <td>{{ p.name }}</td>
        <td>{{ p.create_time }}</td>
        <td>{{ p.update_time }}</td>
      </tr>
    </table>-->
  </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      msg: 'Projects in Automation Center',
      projects: [],
      error_msg: '',
      auth: [],
      auth_text: '',
      coverage_by_projects_chart: '',
      coverage_diff_by_year_chart: '',
      summary: {
        projects_total: 0,
        projects_running: 0,
        automated_cases: 0,
      },
      animate_number: {
        from: 0,
        to: 0,
        duration: 1,
        delay: 0.2
      }
    }
  },

  created: function() {
    if (this.$store.state.token) {
      this.auth_text = "user already logged in ";
    }
    else {
      this.auth_text = "no user logged in";
    }

    this.$http.get(`${this.$http.defaults.baseURL}/projects/automated_case_amount/`)
      .then(response => {
        // this.summary.automated_cases = response.data["count"]; // real data
        this.summary.automated_cases = response.data["count"] * 100 + 69; // set the virtual data
      })
      .catch(err => {console.log(err)})
  },

  mounted: function() {
    this.$http.get(`${this.$http.defaults.baseURL}/projects/names/`)
      .then(response => {
        this.projects = response.data["names"];
        this.summary.projects_total = this.projects.length;
        this.draw_coverage_by_projects_chart();
        this.draw_coverage_diff_by_year_chart();
      })
      .catch(err => {console.log(err)})

    var myEvent = new Event('resize');
    window.dispatchEvent(myEvent);
  },

  methods: {
    getProjects() {
      this.$http.get(`${this.$http.defaults.baseURL}/projects/`)
      .then(response => {this.projects = response.data["results"], this.msg = 'get projects data from django api'})
      //.catch(err => {
        //if (err.response.status === 401) {
          //alert("not authenticated, please check if your token was expired")
        //}
        //this.$store.dispatch('logout')
        //this.$router.push('/login')
      //});
    },

    logout: function () {
      this.$store.dispatch('logout')
      .then(() => {
        this.$router.push('/login')
      })
    },

    draw_coverage_by_projects_chart: function() {
      this.coverage_by_projects_chart = this.$echarts.init(document.getElementById('coverageByProjects'));
      this.coverage_by_projects_chart.setOption({
        //title: {
        //  text: 'Automation Coverage by Project',
        //  left: 'center'
        //},
        tooltip: {
          trigger: 'item',
          formatter:'{b}: {c}%'
        },
        xAxis: {
          type: 'category',
          data: this.projects
        },
        yAxis: {
          type: 'value',
          axisLabel: {
            formatter: '{value} %'
          }
        },
        series: [{
          data: [60, 90, 100],
          type: 'bar',
          itemStyle: {
            normal: {
              color: function(params) {
                var colorList = ['#708090', '#4682B4', '#008B8B', '#4B0082', '#4169E1', '#BDB76B', '#8B4513', '#800000'];
                var index = params.dataIndex;
                if (params.dataIndex >= colorList.length) {
                  index = params.dataIndex - colorList.length;
                }
                return colorList[index];
              },
              label: {
                 show: true,
                 position: 'top',
                 formatter: '{c}%'
              }
            }
          }
        }]
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
