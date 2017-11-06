class MsgThread < ApplicationRecord
    belongs_to :page
    has_many :messages, dependent: :destroy

    def load_messages(user)
        Facebook.message_list_loading_process(user, self.page, self)
    end

    def update_time
        updated_time = self.updated_time
        date, time = updated_time.split('T')

        time = time.split('+')[0]

        year    = date.split('-')[0].to_i
        month   = date.split('-')[1].to_i
        day     = date.split('-')[2].to_i
        hour    = time.split(':')[0].to_i
        minute  = time.split(':')[1].to_i
        sec     = time.split(':')[2].to_i

        ut = DateTime.new(year, month, day, hour, minute, sec) + 9.hour

        str = ''
        if ut.year == DateTime.now.year
            if ut.month == DateTime.now.month && ut.day == DateTime.now.day
                if ut.hour == DateTime.now.hour
                    str += "#{DateTime.now.min - ut.min}분 전"
                else
                    str += "#{ut.hour}시 #{ut.day}분"
                end
            else
                str += "#{ut.month}월 #{ut.day}일"
            end
        else
            str += "#{ut.year}년 #{ut.month}월 #{ut.day}일"
        end

        str
    end
end
