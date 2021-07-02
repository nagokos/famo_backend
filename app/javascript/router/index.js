import VueRouter from "vue-router"
import store from "../store"

import Top from "../components/pages/Top"
import SignupLogin from "../components/pages/SignupLogin"
import Mypage from "../components/pages/Mypage"
import MySetting from "../components/pages/MySetting"

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
  {
    path: "/profile",
    name: "profile",
    component: Mypage,
    meta: { requiredLogin: true }
  },
  {
    path: "/settings/:type",
    name: "mySetting",
    component: MySetting,
    meta: { requiredLogin: true }
  }
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