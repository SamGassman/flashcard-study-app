<template>
    <div class="study-session">
        <h1>Choose A Deck To Use</h1>

        <choose-study-session />
    </div>
</template>

<script>
import ChooseStudySession from '../components/ChooseStudySession.vue';
export default {
    name: 'study-session',
    components: {
        ChooseStudySession,
    }
}
</script>

<style>

</style>