json.array! @collection do |person|
  json.id person.id
  json.phone_number person.phone_number
  json.fullname person.fullname
  json.nickname person.nickname
  json.active person.active
  json.created_at person.created_at
  json.updated_at person.updated_at
  json.url api_person_url(person)
  json.response_count 0
  json.call_count 0
  json.situations []
end
