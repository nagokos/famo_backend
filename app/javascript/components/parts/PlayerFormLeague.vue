<template>
  <div>
    <ValidationProvider
      v-slot="{ errors }"
      rules="required"
      name="リーグ"
      vid="group"
    >
      <v-select
        v-model="leagueId"
        outlined
        dense
        label="リーグ"
        :items="leagues"
        item-value="id"
        item-text="name"
        background-color="#F2F4F8"
        :error-messages="errors"
        @click="resetId"
      />
    </ValidationProvider>
    <ValidationProvider
      v-if="loading && leagueId"
      v-slot="{ errors }"
      rules="required"
      name="カテゴリ"
      vid="group"
    >
      <v-select
        v-model="categoryId"
        class="mt-1"
        outlined
        dense
        required
        label="カテゴリ"
        :items="filterCategories"
        item-value="id"
        item-text="name"
        background-color="#F2F4F8"
        :error-messages="errors"
        @click="$emit('update:groupId', '')"
        @change="setGroupId"
      />
    </ValidationProvider>
    <ValidationProvider
      v-if="loading && categoryId && filterGroups.length !== 1"
      v-slot="{ errors }"
      rules="required"
      name="グループ"
      vid="group"
    >
      <v-select
        :value="groupId"
        class="mt-1"
        outlined
        dense
        required
        label="グループ"
        :items="filterGroups"
        item-value="id"
        item-text="name"
        background-color="#F2F4F8"
        :error-messages="errors"
        @change="$emit('update:groupId', $event)"
      />
    </ValidationProvider>
  </div>
</template>

<script>
export default {
  props: {
    league: {
      type: Number,
      default: 0,
      required: true
    },
    category: {
      type: [Number, String],
      default: 0,
      required: true
    },
    groupId: {
      type: [Number, String],
      default: 0,
      required: true
    }
  },
  data() {
    return {
      leagueId: this.league,
      categoryId: this.category,
    }
  },
  computed: {
    filterCategories() {
      return this.leagues.find(league => {
        return league.id === this.leagueId
      }).categories
    },
    filterGroups() {
      return this.filterCategories.find(category => {
        return category.id === this.categoryId
      }).groups
    }
  },
  created() {
    this.getLeagueData()
  },
  methods: {
    setGroupId() {
      if (this.filterGroups.length === 1) {
        this.$emit("update:groupId", this.filterGroups[0].id)
      }
    },
    resetId() {
      this.$emit("update:groupId", "")
      this.categoryId = ""
      this.leagueId = ""
    }
  }
}
</script>