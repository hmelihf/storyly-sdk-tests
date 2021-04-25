package com.hmelihf.kotlintest

import kotlinx.serialization.Serializable

@Serializable
data class PokemonSpecies(
    val name: String,
    val url: String
)

@Serializable
data class Pokemon(
    val entry_number: Int,
    val pokemon_species: PokemonSpecies
)