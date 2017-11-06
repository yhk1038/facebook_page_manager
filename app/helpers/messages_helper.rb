module MessagesHelper

    def is_receive?(page, msg)
        result = true
        result = false if page.uid == msg.sender_uid
        result
    end
end
