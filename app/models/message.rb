class Message < ApplicationRecord
    belongs_to :msg_thread

    def attach
        JSON.parse(self.attachment, {:symbolize_names => true})
    end

    def sharing
        hash = JSON.parse(self.share, {:symbolize_names => true})[0]
        hash[:meme_type] = hash[:name].nil? ? 'sticker' : 'other'
        hash
    end
end
