import axios from "../plugins/axios"

const state = () => ({
  currentUser: ""
})

const getters = {
  currentUser: state => state.currentUser
}

const mutations = {
  setCurrentUser(state, user) {
    state.currentUser = user
  }
}

const actions = {
  getCurrentUser({ state, dispatch }) {
    const { currentUser } = state
    if (currentUser) {
      return currentUser
    }
    return dispatch("getCurrentUserFromAPI")
  },
  async getCurrentUserFromAPI({ commit }) {
    try {
      const response = await axios.get("/api/v1/users/current")
      commit("setCurrentUser", response.data)
      return response.data
    } catch(err) {
      return null
    }
  },
  async updateCurrentUser({ commit }, user) {
    try {
      const response = await axios.patch("/api/v1/users/current", {
        user: user
      })
      commit("setCurrentUser", response.data)
      return response.data
    } catch(err) {
      return null
    }
  },
  async logout({ commit }) {
    await axios.delete("/api/v1/logout")
    commit("setCurrentUser", null)
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
