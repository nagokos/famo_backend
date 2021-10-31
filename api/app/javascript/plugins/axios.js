import Axios from "axios"
import store from "../store"
import snakeCase from 'lodash.snakecase'
import qs from 'qs'
import deepMapKeys from "../packs/deep-map-keys"


const instance = Axios.create({
  paramsSerializer: (params) => {
    return qs.stringify(
      deepMapKeys(params, (val, key) => {
        return snakeCase(key)
      }),
      params, {arrayFormat: 'brackets'})
  },
})

instance.interceptors.request.use(request => {
  const csrfToken = document.getElementsByName("csrf-token")[0].content
  request.headers.common = {
    "X-CSRF-Token": csrfToken,
    "X-Requested-With": "XMLHttpRequest"
  }
  return request
})

instance.interceptors.response.use(
  response => response,
  error => {
    const response = error.response
    const status = response === undefined ? undefined : response.status
    if (status === 404) {
      store.dispatch("notFound/setNotFound", true)
    }
    return Promise.reject(error)
  }
)
export default instance