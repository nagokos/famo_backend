import Vue from 'vue'
import App from '../app.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: "#app",
    render: h => h(App)
  })
  app.$mount("#app")
})