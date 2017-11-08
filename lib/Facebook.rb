require 'rest-client'

class Facebook
    attr_accessor :api_domain, :api_version,
                  :user, :user_id, :users_access_token, :next_thread_token

    def initialize(user=nil)
        @api_domain  = 'https://graph.facebook.com'
        @api_version = 'v2.10'

        @user = user
        @user_id = user.uid

        @users_access_token = user.facebook_token
        @next_thread_token = nil
    end

    def get_user_pages
        page_list = []
        load_page_list.each do |raw_data|
            page = Page.find_or_create_by(uid: raw_data[:id])
            page.title              = raw_data[:name]
            page.page_name          = raw_data[:username]
            page.access_token       = raw_data[:access_token]
            page.img                = raw_data[:picture][:data][:url]

            raw_data_detail = load_page_detail(page)
            page.unread_msg_count   = raw_data_detail[:unread_message_count]
            page.unseen_msg_count   = raw_data_detail[:unseen_message_count]

            if page.save
                page_list << page
            end
        end
        user.adminlists.delete_all
        user.pages << page_list

        user.pages
    end

    def get_page_threads(page, more=false)
        list = []
        load_thread_list(page, more).each do |raw_data|
            thread = MsgThread.find_or_create_by(uid: raw_data[:id])
            thread.link         = raw_data[:link]
            thread.updated_time = raw_data[:updated_time]
            thread.msg_count    = raw_data[:message_count]
            thread.unread_count = raw_data[:unread_count]
            thread.sender_name  = raw_data[:senders][:data][0][:name]
            thread.sender_uid   = raw_data[:senders][:data][0][:id]
            next if thread.sender_name == 'Facebook User'

            raw_data_detail = load_thread_detail(thread, page)
            thread.sender_img = raw_data_detail[:picture][:data][:url]

            thread.page = page
            thread.save
            list << thread
        end

        list
    end

    def get_thread_messages(page, thread)
        load_msg_list(page, thread).each do |raw_data|
            msg = Message.find_or_create_by(uid: raw_data[:id])
            msg.created_time    = raw_data[:created_time]
            msg.sender_name     = raw_data[:from][:name]
            msg.sender_uid      = raw_data[:from][:id]
            msg.sender_img      = page.uid == msg.sender_uid ? page.img : thread.sender_img
            msg.received        = page.uid != msg.sender_uid ? true : false
            msg.content         = raw_data[:message]
            msg.attachment      = raw_data[:attachments][:data].to_json     if raw_data[:attachments]
            msg.share           = raw_data[:shares][:data].to_json          if raw_data[:shares]

            msg.msg_thread = thread
            msg.save
        end

        thread.messages
    end

    def load_page_list
        uri = request_uri(user_id, query('page-index'), users_access_token)
        response = rest_call('get', uri)
        response[:body][:accounts][:data]
    end

    def load_thread_list(page, uri=nil)
        load_more = uri
        unless uri
            uri = request_uri(page.uid, query('thread-index'), page.access_token)
        end
        response = rest_call('get', uri)

        logger response[:body]

        unless load_more
            page.update(
                next_token: response[:body][:threads][:paging][:next],
                prev_token: ''
            )
            logger response
            return response[:body][:threads][:data]
        else
            @next_thread_token = response[:body][:paging][:next]
            return response[:body][:data]
        end
    end

    def load_msg_list(page, thread)
        uri = request_uri(thread[:uid], query('message-index'), page.access_token)
        response = rest_call('get', uri)

        thread.update(
            next_token: response[:body][:messages][:paging][:next],
            prev_token: ''
        )
        response[:body][:messages][:data]
    end

    def load_page_detail(page)
        uri = request_uri(page.uid, query('page-show'), page.access_token)
        response = rest_call('get', uri)
        response[:body]
    end

    def load_thread_detail(thread, page)
        # 쓰레드의 보낸이 프로필을 받아온다.
        sender_detail = load_sender_detail(page, thread)

        sender_detail
    end

    def load_sender_detail(page, thread)
        uri = request_uri(thread.sender_uid, query('sender-show'), page.access_token)
        response = rest_call('get', uri)

        response[:body]
    end

    private

    def logger(it)
        puts "\n\n\n\n\n"
        ap it
        puts "\n\n\n\n\n"
    end

    def query(query_type)
        case query_type
        when 'page-index'
            %w(id name accounts{id,name,page_token,username,access_token,picture.width(960).height(960),perms})

        when 'page-show'
            %w(id name page_token username access_token picture.width(960).height(960) context is_owned unread_message_count unseen_message_count messenger_profile)

        when 'thread-index'
            %w(threads{id,link,updated_time,message_count,unread_count,senders})

        when 'message-index'
            %w(id link updated_time message_count unread_count messages{id,created_time,from,message,attachments,shares{id,link,name}})

        when 'sender-show'
            %w(id name picture.width(960).height(960))

        end
    end

    def request_uri(edge, query, token)
        api_edge = [api_domain, api_version, edge].join('/')
        uri = api_edge+'?fields='+query.join(',')+'&access_token='+token

        uri
    end

    def rest_call(method, uri)
        response = RestClient.get uri

        {
            header: response.headers,
            body: JSON.parse(response.body, {:symbolize_names => true})
        }
    end
end

class Facebook
    def self.page_list_loading_process(user)

        # 정적인 변수 값들을 초기화 한다.

        facebook = Facebook.new(user)


        # 권한 및 사용자 토큰의 상태를 체크해 토큰을 최신화 한다.

        # facebook.refresh_status('user') unless facebook.still_safe?('user')


        # 사용자가 관리 권한을 가지고 있는 페이지들을 로드/저장/가져온다.

        pages = facebook.get_user_pages


        # Return

        pages
    end

    def self.thread_list_loading_process(user, page)

        # Facebook 객체를 생성한다.

        facebook = Facebook.new(user)


        # 권한 및 페이지 토큰의 상태를 체크해 토큰을 최신화 한다.

        # facebook.refresh_status('page') unless facebook.still_safe?('page')


        # 페이지의 메세지 Thread 리스트를 로드/저장/가져온다.

        threads = facebook.get_page_threads(page)


        # 첫 번째 Thread 가 포함한 상세 메세지들을 로드/저장/가져온다.

        thread = threads.first
        messages = facebook.get_thread_messages(page, thread)

        [threads, messages]
    end

    def self.message_list_loading_process(user, page, thread)

        # Facebook 객체를 생성한다.

        facebook = Facebook.new(user)


        # 권한 및 페이지 토큰의 상태를 체크해 토큰을 최신화 한다.

        # facebook.refresh_status('page') unless facebook.still_safe?('page')


        # 페이지의 메세지 Thread 리스트를 로드/저장/가져온다.

        messages = facebook.get_thread_messages(page, thread)


        # Return

        messages
    end
end