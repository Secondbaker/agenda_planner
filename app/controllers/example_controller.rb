class ExampleController < ApplicationController
    def redirect
      client = Signet::OAuth2::Client.new(client_options)
  
      redirect_to client.authorization_uri.to_s
    end

    def callback
        client = Signet::OAuth2::Client.new(client_options)
        client.code = params[:code]
    
        response = client.fetch_access_token!
    
        session[:authorization] = response
    
        redirect_to calendars_url
      end

      def calendars
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])
    
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
    
        @calendar_list = service.list_calendar_lists
      end

      def calendar
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])
    
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
    
        @calendar = service.get_calendar_list(params[:calendar_id])
        @events = []
        page_token = nil
        
        @page_count = 1

        loop do
          event_list = service.list_events(params[:calendar_id], page_token: page_token, order_by: 'startTime', single_events: true)        
          
          event_list.items.each do |event|
            @events.push event
          end
          puts 'page_token: ' + page_token.to_s
          puts 'next_page_token: ' + event_list.next_page_token.to_s
          puts 'page_count: ' + @page_count.to_s
          
          break if page_token == event_list.next_page_token || @page_count > 10
          page_token = event_list.next_page_token
          @page_count += 1
        end
      end

      def events
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])

        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        @event_lists = []
        @calendars = service.list_calendar_lists
        @calendars.items.each do |calendar|
          @event_lists.push service.list_events(calendar.id)
        end
      end
    private
  
    def client_options
      {
        client_id: Rails.application.credentials.dig(:development, :google_client_id),
        client_secret: Rails.application.credentials.dig(:development, :google_client_secret),
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        redirect_uri: callback_url
      }
    end
    
end