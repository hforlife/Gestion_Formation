<script setup lang="ts">
import type { HTMLAttributes } from 'vue';

defineOptions({
  inheritAttrs: false,
});

interface Props {
  className?: HTMLAttributes['class']; // pour tailwind
  width?: number | string;
  height?: number | string;
}

const props = defineProps<Props>();
</script>

<template>
  <img
    src="/asset/img/logo_formaplus.png"
    :class="props.className"
    :width="props.width"
    :height="props.height"
    v-bind="$attrs"
  />
</template>
