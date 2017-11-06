json.extract! msg_thread, :id, :page_id, :uid, :sender_name, :sender_uid, :link, :msg_count, :unread_count, :updated_time, :other_info, :created_at, :updated_at
json.url msg_thread_url(msg_thread, format: :json)
