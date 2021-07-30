class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :league
  belongs_to :category, if: -> { instance_options[:nested] }

  def league
    {
      id: object.category.league.id,
      name: object.category.league.name
    }
  end
end
