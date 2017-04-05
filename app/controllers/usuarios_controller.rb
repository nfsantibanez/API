class UsuariosController < ApplicationController
respond_to :json
skip_before_action :verify_authenticity_token

  #Para mostrar un usuario especifico
  def show
    #respond_with Usuario.find(params[:id])
    #usuario = Usuario.find(params[:id])
    if Usuario.exists?(params[:id])
      respond_with Usuario.find(params[:id])
    else
      render json: {"error": "Usuario no encontrado"}, status: 404 
    end

  end

  #Para crear un usuario
  def create
   usuario = Usuario.new(usuario_params)

   #Reviso si se pasó el parametro id
   if params["id"]
     render json: {"error": "No se puede crear usuario con id"}, status: 400

   #Si se guarda exitosamente
   elsif usuario.save
     render json: usuario, status: 201
   #En caso de que falle el save
   else
     render json: { "error": "La creación ha fallado"}, status: 500
   end
  end

  private

  #Definir los parametro que son requeridos obligatorios y permitidos
  def usuario_params
   params.require(:usuario)
   params.require(:nombre)
   params.permit(:usuario, :nombre, :apellido, :twitter)
  end


end
