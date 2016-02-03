json.array!(@posts) do |post|
  json.extract! post, :id, :title, :approved, :vibe_type, :body, :url
  json.url post_url(post, format: :json)
end
