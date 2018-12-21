<template>
  <section class="container">
    <div class="columns is-multiline">

      <div v-for="(item, i) in breed_list" :key="i" 
      class="column is-2">

        <nuxt-link :to="{name: 'dogs-breed', params: {breed: i}}" class="button">
        <!-- <nuxt-link :to="{path: 'dogs/' + i}" class="button"> -->
          {{i}}
        </nuxt-link>
      </div>

    </div>
  </section>
</template>

<script>
import dogApi from '~/api/dog.js'
import {mapState} from 'vuex'
export default {

  async fetch({store}) {

    let json = await dogApi.breeds()

    store.commit('breed_list_update', json)

  },

  computed: mapState(['breed_list']),
  // computed: mapState({
  //   breed_list: state => state.breed_list
  // })

  created() {
    console.log(dogApi.breeds())
  }

}
</script>

