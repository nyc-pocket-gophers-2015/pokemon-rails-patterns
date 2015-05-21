module PokemonsHelper
  def pokemon_action pokemon
    pokemon.caught ? "release" : "catch"
  end

  def action_caption pokemon
    pokemon_action(pokemon).titleize + "!"
  end
end
