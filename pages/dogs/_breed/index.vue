<template>
  <section class="container">
    <div class="columns is-multiline">
      <div v-for="(item, i) in dog_list" :key="i" class="column is-1">
        <img :src="item.url">

        <span v-if="i<3" class="tag is-danger">NEW</span>
        <a @click="item.like+=1" class="button is-warning is-small">
          <span>いいね！　{{item.like}}</span>
        </a>
      </div>
    </div>

    <nav class="pagination">
      <ul class="pagination-list">
        <li v-for="count in page_count" :key="count">
          <nuxt-link :to="{path:'?page='+count}" append
                    class="pagination-link"
                    :class="{'is-current': current == count}"
                    >
            {{count}}
          </nuxt-link>
        </li>
      </ul>
    </nav>
  </section>
</template>

<script>
import dogApi from '~/api/dog'
import {mapState} from 'vuex'

export default {
  watchQuery: [
    'page'
  ],

  validate({params}) {
    return /^[a-z]+$/.test(params.breed)
  },

  data() {
    return {
      current: 1
    }
  },

  asyncData: function(context) {
    return {
      current: parseInt(context.query['page']) || 1
    }
  },

  fetch: async function({store, params, query}) {
    const page = parseInt(query['page']) || 1
    const start = 10 * (page-1)
    const end = start + 10
    const json = await dogApi.dogs(params.breed)
    
    store.commit('page_count_update', Math.ceil(json.length / 10))
    store.commit('dog_list_update', json.slice(start, end))
  },

  computed: mapState([
    'page_count',
    'dog_list'
  ])
}
</script>

<style scoped>
.column {
  width: 20%;
}
</style>
