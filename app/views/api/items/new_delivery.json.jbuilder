json.array! @delivery_methods do |delivery_method|
  json.id delivery_method.id
  json.value delivery_method.value
  json.charge delivery_method.charge
end