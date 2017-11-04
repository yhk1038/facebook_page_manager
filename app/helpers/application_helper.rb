module ApplicationHelper

    # Facebook Scope request parameters and lists
    def scope_parameters
        '?scope='+scope_list.join(',')
    end

    def scope_list
        %w(pages_show_list)
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
end
