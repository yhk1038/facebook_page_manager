require 'rails_autolink'

module ApplicationHelper

    # Facebook Scope request parameters and lists
    def scope_parameters
        '?scope='+scope_list.join(',')
    end

    def scope_list
        %w(pages_show_list manage_pages publish_pages read_page_mailboxes pages_messaging read_insights)
    end

    # Flash message
    def bootstrap_class_for(flash_type)
        case flash_type
        when "success"
            "alert-success"   # Green
        when "error"
            "alert-danger"    # Red
        when "alert"
            "alert-warning"   # Yellow
        when "notice"
            "alert-info"      # Blue
        else
            flash_type.to_s
        end
    end

    def time_parse_stringify(raw_time)
        date, time = raw_time.split('T')

        time = time.split('+')[0]

        year    = date.split('-')[0]
        month   = date.split('-')[1]
        day     = date.split('-')[2]
        hour    = time.split(':')[0]
        minute  = time.split(':')[1]
        sec     = time.split(':')[2]

        ut = DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i, sec.to_i) + 9.hour

        noon = '오후'
        noon = '오전' if ut.hour < 12

        _hour = ut.hour
        _hour = ut.hour - 12 if ut.hour > 12

        hour_ = _hour.to_s
        hour_ = '0'+_hour.to_s if _hour < 10

        min_ = ut.min.to_s
        min_ = '0'+ut.min.to_s if ut.min < 10

        str = "#{ut.year}년 #{ut.month}월 #{ut.day}일 #{noon} #{hour_}:#{min_}"
        # 2017년 3월 10일 오전 11:41

        str
    end
end
