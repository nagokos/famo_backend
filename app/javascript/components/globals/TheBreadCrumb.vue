<template>
  <v-breadcrumbs
    :items="breadCrumbs"
    class="pl-3 mx-auto"
    style="max-width: 1050px"
  >
    <template #item="props">
      <v-breadcrumbs-item
        :to="props.item.to"
        :disabled="props.item.disabled"
      >
        <span
          v-if="props.item.to !== '/'"
          :class="$route.path === props.item.to ? 'text-caption black--text font-weight-bold' : 'text-caption'"
        >{{ props.item.text }}</span>
        <span
          v-else
          class="text-caption"
        ><v-icon
          size="18"
          class="mr-1"
          style="position: relative; bottom: 2px;"
        >mdi-home</v-icon>{{ props.item.text }}</span>
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