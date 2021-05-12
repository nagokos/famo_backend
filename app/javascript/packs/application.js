import Vue from 'vue'
import App from '../app.vue'

// Vue-router
import VueRouter from "vue-router"
import router from "./router"
Vue.use(VueRouter)

// Vuetify
import Vuetify from "vuetify"
import "vuetify/dist/vuetify.min.css"
import '@mdi/font/css/materialdesignicons.css'
Vue.use(Vuetify)
const vuetify = new Vuetify({
  icons: {
    iconfont: "mdi"
  }
})

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: "#app",
    vuetify,
    router,
    render: h => h(App)
  })
  app.$mount("#app")
})