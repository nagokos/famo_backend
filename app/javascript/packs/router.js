import VueRouter from "vue-router"

import Top from "../pages/Top"
import Login from "../pages/Login"

const routes = [
  {
    path: "/",
    name: "top",
    component: Top
  },
  {
    path: "/login",
    name: "login",
    component: Login
  }
]

const router = new VueRouter({ mode: "history", routes })

export default router