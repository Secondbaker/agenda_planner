class AgendaEvent < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :start_time
    validates_presence_of :end_time
    validate :end_time_on_or_after_start_time

    @fixed_attributes = []

    def duration
        end_time - start_time
    end

    def self.fixed_attributes
        @fixed_attributes
    end

    def fixed?(attribute)
        self.class.fixed_attributes.include? attribute
    end

    private
    def end_time_on_or_after_start_time
        if end_time.present? && start_time.present?
            if end_time < start_time
                errors.add(:end_time, 'An event must end on or after the time it starts') 
            end
        end
    end
end
