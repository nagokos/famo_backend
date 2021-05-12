import VueRouter from "vue-router"

import Top from "../pages/Top"

const routes = [
  {
    path: "/",
    name: "top",
    component: Top
  }
]

const router = new VueRouter({ mode: "history", routes })

export default router