class Page < ApplicationRecord
    has_many :adminlists, dependent: :destroy
    has_many :users, through: :adminlists
    has_many :msg_threads, dependent: :destroy

    def load_threads(user)
        page = self
        Facebook.thread_list_loading_process(user, page)
    end
end
