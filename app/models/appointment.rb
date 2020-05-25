class Appointment < AgendaEvent
    @@fixed_attributes = [:start_time, :duration]
end
