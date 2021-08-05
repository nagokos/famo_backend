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
import PlayerList from "../components/parts/PlayerList"

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
    component: WholePlayer,
    children: [
      {
        path: "",
        name: "wholePlayer",
        component: PlayerList
      },
      {
        path: "ratings",
        name: "wholeRating",
        component: PlayerList
      }
    ]
  },
  {
    path: "/:league",
    component: LeaguePlayer,
    children: [
      {
        path: "",
        name: "leaguePlayer",
        component: PlayerList
      },
      {
        path: "ratings",
        name: "leagueRating",
        component: PlayerList
      }
    ]
  },
  {
    path: "/:league/:categoryId",
    component: CategoryPlayer,
    children: [
      {
        path: "",
        name: "categoryPlayer",
        component: PlayerList
      },
      {
        path: "ratings",
        name: "categoryRating",
        component: PlayerList
      }
    ]
  },
  {
    path: "/:league/:categoryId/:groupId",
    component: GroupPlayer,
    children: [
      {
        path: "",
        name: "groupPlayer",
        component: PlayerList
      },
      {
        path: "ratings",
        name: "groupRating",
        component: PlayerList
      }
    ]
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