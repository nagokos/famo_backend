<template>
  <div>
    <ValidationProvider
      v-slot="{ errors }"
      rules="required"
      name="都道府県"
      vid="team"
    >
      <v-select
        v-model="prefectureId"
        outlined
        dense
        label="都道府県"
        :items="prefectures"
        item-value="id"
        item-text="name"
        hint="※ 必須項目です"
        persistent-hint
        background-color="#F2F4F8"
        :error-messages="errors"
        @click="$emit('update:teamId', '')"
      />
    </ValidationProvider>
    <ValidationProvider
      v-if="prefectureId"
      v-slot="{ errors }"
      rules="required"
      name="チーム"
      vid="team"
    >
      <v-autocomplete
        :value="teamId"
        class="mt-1"
        no-data-text="チームが見つかりません"
        outlined
        dense
        required
        hint="※ 必須項目です"
        persistent-hint
        label="チーム"
        :items="filterTeams"
        item-value="id"
        item-text="name"
        background-color="#F2F4F8"
        :error-messages="errors"
        @change="$emit('update:teamId', $event)"
      />
    </ValidationProvider>
  </div>
</template>

<script>
export default {
  props: {
    prefectures: {
      type: Array,
      default: () => {},
      required: true,
    },
    prefecture: {
      type: [Number, String],
      default: "",
      required: true,
    },
    teamId: {
      type: [Number, String],
      default: "",
      required: true,
    },
  },
  data() {
    return {
      prefectureId: this.prefecture,
    };
  },
  computed: {
    filterTeams() {
      return this.prefectures.find((prefecture) => {
        return prefecture.id === this.prefectureId;
      }).teams;
    },
  },
};
</script>
