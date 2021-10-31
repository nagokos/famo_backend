import Vue from "vue"
import Vuex from "vuex"
import user from "./user"
import flash from "./flash"
import notFound from "./not-found"

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    user,
    flash,
    notFound
  }
})