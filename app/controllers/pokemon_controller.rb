class PokemonController < ApplicationController

  before_action :set_types, only:[:index, :catch]

  def index
    @captured_pokemon = Pokemon.caught.typed(params[:type]).order(:type, :id)
    @free_pokemon = Pokemon.free.typed(params[:type]).order(:type, :id)
  end

  def catch
    found_pokemon = Pokemon.where(id: params[:id]).first
    if found_pokemon.capture
      NotificationService.tell_friends "I caught #{found_pokemon.name.upcase}!"
    else
      flash[:notice] = "damn Damn DAMN! #{found_pokemon.name.upcase} got away!"
    end
    redirect_with_type
  end

  def release
    found_pokemon = Pokemon.find_by(id: params[:id])
    if found_pokemon.release
      release_message = "#{found_pokemon.name} was released back into the wild"
    else
      release_message = "Failed to release #{found_pokemon}."
    end
    flash[:notice] = release_message
    NotificationService.tell_friends release_message
    redirect_with_type
  end

  private

  def set_types
    @types = Pokemon::TYPES
  end

  def redirect_with_type
    if params[:type].present?
      redirect_to "/?type=#{params[:type]}"
    else
      redirect_to '/'
    end
  end
end
