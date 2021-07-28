<template>
  <div
    v-if="loading"
    class="league"
  >
    <the-bread-crumb
      :bread-crumbs="breadCrumbs"
    />
  </div>
</template>

<script>
import Transform from "../../packs/league-transform"
import TheBreadCrumb from "../globals/TheBreadCrumb"

export default {
  components: {
    TheBreadCrumb
  },
  data() {
    return {
      category: {},
      loading: false
    }
  },
  computed: {
    breadCrumbs() {
      return [
        {
          text: "TOP",
          to: "/",
          disabled: false,
        },
        {
          text: this.category.league.name,
          to: `/${this.$route.params.league}`,
          disabled: false,
        },
        {
          text: this.category.name,
          to: this.$route.path,
          disabled: true
        }
      ]
    }
  },
  created() {
    this.getCategory()
  },
  methods: {
    async getCategory() {
      const leagueId = Transform.getLeagueId(this.$route.params.league)
      const response = await this.$axios.get(`/api/v1/${leagueId}/categories/${this.$route.params.categoryId}`)
      this.category = response.data.category
      this.loading = true
      console.log(this.category.league.name);
    }
  }
}
</script>