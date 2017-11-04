json.extract! page, :id, :user_id, :title, :page_name, :access_token, :created_at, :updated_at
json.url page_url(page, format: :json)
