import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import PublicDecks from '../views/PublicDecks.vue'
import PublicDeck from '../views/PublicDeck'
import PublicCards from '../views/PublicCards'
import MyDecks from '../views/MyDecks.vue'
import Index from '../views/Index.vue'
import Deck from '../views/Deck.vue'
import EditDeck from '../components/EditDeck.vue'
import EditCard from '../components/EditCard.vue'
import MyCards from '../views/MyCards.vue'
import StudySession from '../views/StudySession.vue'
import StartStudySession from '../components/StartStudySession.vue'
import Admin from '../views/Admin'
import AdminDeck from '../views/AdminDeck'



Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'index',
      component: Index,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/home',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/communitydecks",
      name: "communitydecks",
      component: PublicDecks,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/communitydecks/:deckId",
      name: "communitydeck",
      component: PublicDeck,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/communitycards",
      name: "communitycards",
      component: PublicCards,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/mydecks",
      name: "mydecks",
      component: MyDecks,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/mydecks/deck/:deckId',
      name: "deck",
      component: Deck,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/mydecks/editdeck/:deckId',
      name: "editdeck",
      component: EditDeck,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/mydecks/:deckId/:cardId',
      name: "editcard",
      component: EditCard,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/mycards',
      name: "mycards",
      component: MyCards,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/studysession',
      name: "studysession",
      component: StudySession,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/studysession/:deckId',
      name: "startstudysession",
      component: StartStudySession,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/admin',
      name: "admin",
      component: Admin,
      meta: {
        isAdmin: true,
        requiresAuth: true
      }
    },
    {
      path: '/admin/:deckId',
      name: "admindeck",
      component: AdminDeck,
      meta: {
        isAdmin: true,
        requiresAuth: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === '') {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
