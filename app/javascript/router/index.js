import VueRouter from "vue-router"
import store from "../store"

import Top from "../components/pages/Top"
import SignupLogin from "../components/pages/SignupLogin"
import Mypage from "../components/pages/Mypage"
import MySetting from "../components/pages/MySetting"
import Reviewer from "../components/pages/Reviewer"
import Player from "../components/pages/Player"
import PasswordReset from "../components/pages/PasswordReset"
import WholePlayer from "../components/pages/WholePlayer"
import LeaguePlayer from "../components/pages/LeaguePlayer"
import CategoryPlayer from "../components/pages/CategoryPlayer"
import GroupPlayer from "../components/pages/GroupPlayer"
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
    path: "/whole",
    name: "wholePlayer",
    component: WholePlayer
  },
  {
    path: "/:league",
    name: "leaguePlayer",
    component: LeaguePlayer
  },
  {
    path: "/:league/:categoryId",
    name: "categoryPlayer",
    component: CategoryPlayer
  },
  {
    path: "/:league/:categoryId/:groupId",
    name: "groupPlayer",
    component: GroupPlayer
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