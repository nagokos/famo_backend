import Axios from "axios"

const instance = Axios.create()

instance.interceptors.request.use(request => {
  const csrfToken = document.getElementsByName("crtf-token")[0].content
  request.headers.common = {
    "X-CSRF-Token": csrfToken,
    "X-Requested-With": "XMLHttpRequest"
  }
  return request
})

export default instance