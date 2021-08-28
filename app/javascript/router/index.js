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
import Search from "../components/pages/Search"
import NotFound from "../components/pages/NotFound"
import Terms from "../components/pages/Terms"
import PrivacyPolicy from "../components/pages/PrivacyPolicy"
import PlayerList from "../components/parts/PlayerList"
import ReviewCard from "../components/parts/ReviewCard"
import RelationCard from "../components/parts/RelationCard"

const routes = [
  {
    path: "/",
    name: "top",
    component: Top
  },
  {
    path: "/terms",
    name: "terms",
    component: Terms
  },
  {
    path: "/privacy",
    name: "privacy",
    component: PrivacyPolicy
  },
  {
    path: "/login",
    name: "login",
    component: SignupLogin
  },
  {
    path: "/search",
    name: "search",
    component: Search
  },
  {
    path: "/profile",
    component: Mypage,
    meta: { requiredLogin: true },
    children: [
      {
        path: "",
        name: "myReview",
        component: ReviewCard
      },
      {
        path: "following",
        name: "myFollowing",
        component: RelationCard
      },
      {
        path: "followers",
        name: "myFollowers",
        component: RelationCard
      }
    ]
  },
  {
    path: "/settings/:type",
    name: "mySetting",
    component: MySetting,
    meta: { requiredLogin: true }
  },
  {
    path: "/users/:userId",
    component: Reviewer,
    children: [
      {
        path: "",
        name: "reviewerReview",
        component: ReviewCard
      },
      {
        path: "following",
        name: "reviewerFollowing",
        component: RelationCard
      },
      {
        path: "followers",
        name: "reviewerFollowers",
        component: RelationCard
      }
    ]
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
    path: "/:league/:categoryId/:groupId/:userId",
    component: Player,
    children: [
      {
        path: "",
        name: "playerReview",
        component: ReviewCard
      },
      {
        path: "following",
        name: "playerFollowing",
        component: RelationCard
      },
      {
        path: "followers",
        name: "playerFollowers",
        component: RelationCard
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