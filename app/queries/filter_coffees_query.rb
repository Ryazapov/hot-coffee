class FilterCoffeesQuery
  ALLOWED_PARAMS = %i[kind volume_from volume_to price_from price_to].freeze

  attr_reader :relation, :filter_params
  private :relation, :filter_params

  def initialize(relation = nil, filter_params)
    @relation = Coffee.order(created_at: :desc)
    @filter_params = filter_params&.permit(self.class::ALLOWED_PARAMS).to_h || {}
  end

  def all
    filter_params.reduce(relation) do |relation, (key, value)|
      value.blank? ? relation : send("by_#{key}", relation, value)
    end
  end

  private

  def by_kind(relation, kind)
    relation.where(kind: kind)
  end

   def by_volume_from(relation, volume_from)
     relation.where("volume >= ?", volume_from)
   end

   def by_volume_to(relation, volume_to)
     relation.where("volume <= ?", volume_to)
   end

   def by_price_from(relation, price_from)
     relation.where("price >= ?", price_from)
   end

   def by_price_to(relation, price_to)
     relation.where("price <= ?", price_to)
   end
end
