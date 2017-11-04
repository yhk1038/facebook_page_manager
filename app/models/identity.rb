class Identity < ApplicationRecord
    belongs_to :user
    validates_presence_of :uid, :provider
    validates_uniqueness_of :uid, :scope => :provider

    def self.find_for_oauth(auth)
        identity = self.find_or_create_by(uid: auth.uid, provider: auth.provider)

        puts ''
        puts ''
        puts ''
        puts ''
        puts ''
        ap auth
        puts ''
        puts ''
        puts ''
        puts ''
        puts ''

        updated = false
        # email
        if identity.email != auth.info.email
            identity.email = auth.info.email
            updated = true
        end

        # name
        if identity.name != auth.info.name
            identity.name = auth.info.name
            updated = true
        end

        # img
        if identity.img != auth.info.image
            identity.img = auth.info.image
            updated = true
        end

        # # img big
        # if identity.name != auth.info.name
        #     identity.update(img_big: auth.info.name)
        #     updated = true
        # end

        # token
        if identity.token != auth.credentials.token
            identity.token = auth.credentials.token
            updated = true
        end

        # other info
        if identity.other_info != auth.to_json
            identity.other_info = auth.to_json
            updated = true
        end

        identity.sign_in_count += 1

        [identity, updated]
    end
end
