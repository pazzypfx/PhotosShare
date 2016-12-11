json.extract! photo, :id, :path, :user_id, :variety_id, :place_id, :date, :published, :created_at, :updated_at
json.url photo_url(photo, format: :json)
