package com.hmelihf.kotlintest

import android.graphics.drawable.shapes.ArcShape
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.appsamurai.storyly.*
import com.appsamurai.storyly.analytics.StorylyEvent
import com.hmelihf.kotlintest.databinding.ActivityMainBinding
import com.hmelihf.kotlintest.databinding.CustomExternalViewBinding
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json


class MainActivity : AppCompatActivity() {
    companion object {
        const val TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjc2MCwiYXBwX2lkIjo0MDUsImluc19pZCI6NDA0fQ.1AkqOy_lsiownTBNhVOUKc91uc9fDcAxfQZtpm3nj40"
    }

    private lateinit var binding: ActivityMainBinding

    private lateinit var requestQueue: RequestQueue

    private val data = ArrayList<Pokemon>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        requestQueue = Volley.newRequestQueue(this@MainActivity)

        with(binding.itemRecycler) {
            layoutManager = LinearLayoutManager(baseContext)
            adapter = PokemonRVAdapter(data)
        }

        binding.storylyView.storylyInit = StorylyInit(TOKEN)


       binding.storylyView.storylyListener = object: StorylyListener{
           override fun storylyLoaded(storylyView: StorylyView, storyGroupList: List<StoryGroup>) {
               Log.d("[Storyly]", "storylyLoaded")
           }

           override fun storylyLoadFailed(storylyView: StorylyView, errorMessage: String) {
               Log.d("[Storyly]", "storylyLoaded")
           }

           // return true if app wants to handle redirection, otherwise return false
           override fun storylyActionClicked( storylyView: StorylyView, story: Story){
               Log.d("[Storyly]", "storylyActionClicked")
               // TODO: not triggering the action clicked after button click or swipe up (no logs)
               openExternalView(storylyView, story)
           }

           override fun storylyStoryShown(storylyView: StorylyView) {
               Log.d("[Storyly]", "storylyStoryShown")
           }

           override fun storylyStoryDismissed(storylyView: StorylyView) {
               Log.d("[Storyly]", "storylyStoryDismissed")
           }

           //StoryComponent can be one of the following subclasses: StoryEmojiComponent, StoryQuizComponent, StoryPollComponent.
           //Based on "type" property of storyComponent, cast this argument to the proper subclass
           override fun storylyUserInteracted(
               storylyView: StorylyView,
               storyGroup: StoryGroup,
               story: Story,
               storyComponent: StoryComponent
           ) {
               when (storyComponent.type) {
                   StoryComponentType.Quiz -> {
                       val quizComponent = storyComponent as StoryQuizComponent
                       Log.d("[Storyly]", quizComponent.toString())
                   }
                   StoryComponentType.Rating -> {
                       val ratingComponent = storyComponent as StoryRatingComponent
                       Log.d("[Storyly]", ratingComponent.toString())
                   }
                   StoryComponentType.Poll -> {
                       val pollComponent = storyComponent as StoryPollComponent
                       Log.d("[Storyly]", pollComponent.toString())
                   }
                   StoryComponentType.Emoji -> {
                       val emojiComponent = storyComponent as StoryEmojiComponent
                       Log.d("[Storyly]", emojiComponent.toString())
                   }
               }
               openExternalView(storylyView, story)
           }

           override fun storylyEvent(
               storylyView: StorylyView,
               event: StorylyEvent,
               storyGroup: StoryGroup?,
               story: Story?,
               storyComponent: StoryComponent?
           ) {
               Log.d("[Storyly]", "storylyEvent")
           }

           // Design your view as you want but the parent view will be resized to full screen
           // Suggested usage is to use 'showExternalActionView()' in storylyActionClicked or storylyUserInteracted
           private fun openExternalView(storylyView: StorylyView, story: Story) {
               val extBinding = CustomExternalViewBinding.inflate(
                   LayoutInflater.from(this@MainActivity), null, false)
               with(extBinding) {
                   externalViewDismissButton.text = "DISMISS Story External With ID: ${story.id}"
                   externalViewDismissButton.setOnClickListener {
                       storylyView.dismissExternalActionView()
                   }

                   storylyView.showExternalActionView(root)
               }
           }
       }


       voleyFetch("https://pokeapi.co/api/v2/pokedex/kanto")
    }

    private fun voleyFetch(url: String) {
        val stringRequest = JsonObjectRequest(Request.Method.GET, url, null,
            { response ->
                val pokemons = response?.getJSONArray("pokemon_entries")
                val parsed = Json.decodeFromString<List<Pokemon>>(pokemons.toString())
                Log.d("POKEMON", data.toString())
                data.addAll(parsed)
                binding.itemRecycler.adapter!!.notifyDataSetChanged()
            },
            { error ->
                Toast.makeText(this, "Fetch Error", Toast.LENGTH_LONG).show()
                error.printStackTrace()
            })

        requestQueue.add(stringRequest)
    }

}


