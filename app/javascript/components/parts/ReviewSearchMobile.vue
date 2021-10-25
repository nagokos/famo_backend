<template>
  <v-card-actions
    class="pb-0 mt-2"
  >
    <span class="font-weight-bold">
      {{ searchDataInformation }}
    </span>
    <v-spacer />
    <v-btn
      :ripple="false"
      small
      @click="$refs.reviewSearchdialog.open()"
    >
      <v-icon size="20">
        mdi-tune
      </v-icon>
      <span class="text-caption font-weight-bold ml-1">フィルター</span>
    </v-btn>
    <the-review-search-dialog
      ref="reviewSearchdialog"
      v-bind.sync="q"
      :game-dates="gameDates"
      @review-search="$emit('review-search')"
    />
  </v-card-actions>
</template>

<script>
import TheReviewSearchDialog from './TheReviewSearchDialog'

export default {
  components: {
    TheReviewSearchDialog
   },
  props: {
    q: {
      type: Object,
      default: () => {},
      required: true
    },
    gameDates: {
      type: Array,
      default: () => {},
      required: true
    }
  },
  computed: {
    searchDataInformation() {
      if (this.q.sort && !this.q.gameDate) {
        return this.transformSortName(this.q.sort)
      } else {
        return `${this.transformSortName(this.q.sort)} / ${this.q.gameDate}`
      }
    }
  },
  methods: {
    transformSortName(value) {
      let name = ""
      switch (value) {
      case "created":
        name = "投稿日順"
        break
      case "new_game":
        name = "試合日順(新)"
        break
      case "old_game":
        name = "試合日順(古)"
        break
      case "rating":
        name = "評価点順"
        break
      }
      return name
    }
  }
}
</script>