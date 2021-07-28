<template>
  <v-breadcrumbs
    :items="breadCrumbs"
    class="pl-3 mx-auto"
    style="max-width: 1050px"
  >
    <template #item="props">
      <v-breadcrumbs-item
        exact
        :to="props.item.to"
        :disabled="props.item.disabled"
        class="text-caption"
      >
        <span
          v-if="props.item.to !== '/'"
          :class="$route.path === props.item.to ? 'black--text font-weight-bold' : ''"
        >
          {{ props.item.text }}
        </span>
        <span v-else>
          <v-icon
            size="18"
            class="mr-1"
            style="position: relative; bottom: 2px;"
          >
            mdi-home
          </v-icon>
          {{ props.item.text }}
        </span>
      </v-breadcrumbs-item>
    </template>
    <template #divider>
      <v-icon>mdi-chevron-right</v-icon>
    </template>
  </v-breadcrumbs>
</template>

<script>
export default {
  props: {
    breadCrumbs: {
      type: Array,
      default: () => {},
      required: true
    }
  }
}
</script>

<style scoped>
 .v-breadcrumbs
 >>>
 .v-breadcrumbs__divider {
   padding: 0;
 }
</style>