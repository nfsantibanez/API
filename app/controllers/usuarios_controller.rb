class UsuariosController < ApplicationController

respond_to :json
skip_before_action :verify_authenticity_token

  # Mostrar el index con todos los usuarios
  def index
    usuario = Usuario.all
    render json: {"usuarios": usuario, "total": usuario.size}
  end

  #Para mostrar un usuario especifico
  def show

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

  # Actualizar info de usuarios
   def update
     #response.headers['Content-Type'] = 'application/json'

     if Usuario.exists?(params[:id])
       usuario = Usuario.find(params[:id])
       n_param = JSON.parse(request.body.read)

       #request.request_parameters
       if n_param["id"]
         render json: {"error": "id no es modificable"}, status: 400
       elsif n_param.size > 1
         render json: {"error": "La modificación ha fallado, solo puedes ingresar un parametro para modificar"}, status: 500
       elsif usuario.update(usuario_params) && n_param.size == 1
         if ["usuario", "nombre", "apellido", "twitter"].include?(n_param.keys[0])
         render json: usuario, status: 200
         else
           render json: {"error": "La modificación ha fallado, el atributo entregado no es válido"}, status: 500
         end
       else
         render json: {"error": "La modificación ha fallado"}, status: 500
       end
     else
       render json: {"error": "Usuario no encontrado"}, status: 404
     end
   end

   # Borrar usuarios
     def destroy

       if Usuario.exists?(params[:id])
         Usuario.find(params[:id]).destroy
         head 204
       else
         render json: {"error": "Usuario no encontrado"}, status: 404
       end
     end


  private
  #Definir los parametro que son requeridos obligatorios y permitidos
  def usuario_params
   #params.require(:usuario)
   #params.require(:nombre)
   params.permit(:usuario, :nombre, :apellido, :twitter)
  end


end
