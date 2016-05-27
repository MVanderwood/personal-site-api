json.blogs @blogs do |blog|
  json.id blog.id
  json.title blog.title
  json.content blog.content
  json.createdAt blog.created_at
  json.updatedAt blog.updated_at
end
