json.extract! message, :id, :msg_thread_id, :uid, :created_time, :sender_name, :sender_uid, :content, :attachment, :created_at, :updated_at
json.url message_url(message, format: :json)
