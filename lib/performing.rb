class Performing
  def initialize(model, attrs)
    @attrs = attrs
    @model = model
    @object = model.new
  end

  def call
    set_default_values
    set_custom_values if attrs.any?

    object.save!
  end

  private

  attr_reader :attrs
  attr_reader :model
  attr_reader :object

  def set_default_values
    model.columns.each do |column|
      column_name = column.name
      column_type = column.type

      object[column_name] = generate_value(column_type)
    end
  end

  def set_custom_values
    attrs.each do |attr|
      key = attr.first
      value = attr.last
      object[key.to_s] = value
    end
  end

  def generate_value(column_type)
    Generating.generate_value(column_type)
  end
end