import VueRouter from "vue-router"
import store from "../store"

import Top from "../components/pages/Top"
import SignupLogin from "../components/pages/SignupLogin"

const routes = [
  {
    path: "/",
    name: "top",
    component: Top
  },
  {
    path: "/login",
    name: "login",
    component: SignupLogin
  },
]

const router = new VueRouter({ mode: "history", routes })

router.beforeEach((to, from, next) => {
  store.dispatch("user/getCurrentUser").then(currentUser => {
    if (to.matched.some(record => record.meta.requiredLogin) && !currentUser) {
      next({ name: "login" })
    }
    return next()
  })
})

export default router