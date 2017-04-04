class UsuarioSerializer < ActiveModel::Serializer
  attributes :id, :usuario, :nombre, :apellido, :twitter
end
