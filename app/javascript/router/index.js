import VueRouter from "vue-router"
import store from "../store"

import Top from "../components/pages/Top"
import SignupLogin from "../components/pages/SignupLogin"
import Mypage from "../components/pages/Mypage"
import MySetting from "../components/pages/MySetting"
import Reviewer from "../components/pages/Reviewer"
import Player from "../components/pages/Player"
import PasswordReset from "../components/pages/PasswordReset"
import LeaguePlayers from "../components/pages/LeaguePlayers"
import CategoryPlayers from "../components/pages/CategoryPlayers"
import GroupPlayers from "../components/pages/GroupPlayers"
import NotFound from "../components/pages/NotFound"

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
    path: "/profile/:type?",
    name: "profile",
    component: Mypage,
    meta: { requiredLogin: true },
  },
  {
    path: "/settings/:type",
    name: "mySetting",
    component: MySetting,
    meta: { requiredLogin: true }
  },
  {
    path: "/users/:userId/:type?",
    name: "reviewerProfile",
    component: Reviewer,
  },
  {
    path: "/:league/:categoryId/:groupId/:userId/:type?",
    name: "playerProfile",
    component: Player
  },
  {
    path: "/account/:type",
    name: "passwordReset",
    component: PasswordReset
  },
  {
    path: "/:league",
    name: "leaguePlayer",
    component: LeaguePlayers
  },
  {
    path: "/:league/:categoryId",
    name: "categoryPlayer",
    component: CategoryPlayers
  },
  {
    path: "/:league/:categoryId/:groupId",
    name: "groupPlayer",
    component: GroupPlayers
  },
  {
    name: "notFound",
    path: "*",
    component: NotFound,
    meta: { title: "お探しのページは見つかりませんでした" }
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