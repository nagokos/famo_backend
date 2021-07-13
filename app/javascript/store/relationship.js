import axios from "../plugins/axios"

const state = () => ({
  isFollow: false
})

const getters = {
  isFollow: state => state.isFollow
}

const mutations = {
  setFollowStatus(state, boolean) {
    state.isFollow = boolean
  }
}

const actions = {
  async follow({ commit }, userId) {
    await axios.post(`/api/v1/users/${userId}/relationships`)
    commit("setFollowStatus", true)
  },
  async unfollow({ commit }, userId) {
    await axios.delete(`/api/v1/users/${userId}/relationships`)
    commit("setFollowStatus", false)
  },
  async checkFollow({ commit }, userId) {
    const response = await axios.get(`/api/v1/users/${userId}/relationships/check`)
    commit("setFollowStatus", response.data.status)
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}