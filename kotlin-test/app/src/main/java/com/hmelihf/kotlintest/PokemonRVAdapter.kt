package com.hmelihf.kotlintest

import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.hmelihf.kotlintest.databinding.ItemRecyclerViewBinding

class PokemonRVAdapter (private val dataSet: ArrayList<Pokemon>) :
        RecyclerView.Adapter<PokemonRVAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val binding = ItemRecyclerViewBinding.inflate(
            LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding)
    }

    override fun getItemCount(): Int {
        return dataSet.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(dataSet[position])
    }

    inner class ViewHolder (private val viewBinding: ItemRecyclerViewBinding) :
        RecyclerView.ViewHolder(viewBinding.root) {

        fun bind(item: Pokemon) {
            with(viewBinding) {
                name.text = item.pokemon_species.name.capitalize()
//                root.setOnClickListener {v ->
//                    v.context.startActivity(
//                        Intent(v.context, DetailedItemActivity::class.java)
//                            .putExtra(DetailedItemActivity.INTENT_KEY, item))
//                }
            }
        }
    }
}