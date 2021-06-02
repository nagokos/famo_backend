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
    dispatch("getCurrentUserFromAPI")
  },
  async getCurrentUserFromAPI({ commit }) {
    try {
      const response = await axios.get("/api/v1/users/current")
      commit("setCurrentUser", response.data)
    } catch(err) {
      return null
    }
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
