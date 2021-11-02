const state = () => ({
  notFound: false,
});

const getters = {
  isNotFound: (state) => state.notFound,
};

const mutations = {
  setNotFound(state, val) {
    state.notFound = val;
  },
};

const actions = {
  setNotFound({ commit }, val) {
    commit("setNotFound", val);
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
