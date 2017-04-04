class UsuariosController < ApplicationController
respond_to :json

  def show
    respond_with Usuario.find(params[:id])
  end

end
