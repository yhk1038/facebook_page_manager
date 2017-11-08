class Page < ApplicationRecord
    has_many :adminlists, dependent: :destroy
    has_many :users, through: :adminlists
    has_many :msg_threads, dependent: :destroy

    def load_threads(user)
        page = self
        Facebook.thread_list_loading_process(user, page)
    end

    def load_threads_more(user, token)
        page = self
        facebook = Facebook.new(user)
        threads = facebook.get_page_threads(page, token)
        next_token = facebook.next_thread_token
        [threads, next_token]
    end
end
