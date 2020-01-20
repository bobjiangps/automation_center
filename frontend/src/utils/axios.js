import axios from 'axios'
import Vue from 'vue'


const axiosInstance = axios.create({
  baseURL: 'http://127.0.0.1:8000/automation/api'
});

export default axiosInstance
