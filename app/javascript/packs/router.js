import VueRouter from "vue-router"

import Top from "../pages/Top"
import SignupLogin from "../pages/SignupLogin"

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
  }
]

const router = new VueRouter({ mode: "history", routes })

export default router