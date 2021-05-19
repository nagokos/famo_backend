import axios from "axios"

const state = ({
  currentUser: ""
})

const getters = {
  currentUser(state) {
    state.currentUser
  }
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
    dispatch("fetchCurrenUser")
  },
  fetchCurrentUser({ commit }) {
    try {

    } catch(err) {

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
