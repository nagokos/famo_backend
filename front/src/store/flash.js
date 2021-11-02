const state = () => ({
  flash: {
    type: "",
    icon: "",
    message: "",
  },
});

const getters = {
  flash: (state) => state.flash,
  isFlash: (state) => !!state.flash.message,
};

const mutations = {
  setFlash(state, { type, icon, message }) {
    state.flash.type = type;
    state.flash.icon = icon;
    state.flash.message = message;
  },
  resetFlash(state, message) {
    state.flash.message = message;
  },
};

const actions = {
  setFlash({ commit }, { type, message }) {
    if (type === "success") {
      const icon = "mdi-check";
      commit("setFlash", { type, icon, message });
    } else if (type === "error") {
      const icon = "mdi-alert-circle-outline";
      commit("setFlash", { type, icon, message });
    }
  },
  resetFlash({ commit }) {
    commit("setFlash", "");
  },
};

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
