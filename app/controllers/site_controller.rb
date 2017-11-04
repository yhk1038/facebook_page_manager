class SiteController < ApplicationController
    def index
        path = new_user_session_path
        path = pages_path if user_signed_in?
        redirect_to path
    end
end
