import Vue from "vue"
import Vuex from "vuex"
import user from "./user"
import flash from "./flash"
import relationship from "./relationship"

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    user,
    flash,
    relationship
  }
})