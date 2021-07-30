class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :league, if: -> { instance_options[:nested] }
end
