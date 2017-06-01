# frozen_string_literal: true

every :weekday, at: '4pm' do
  rake 'send_slack_notification'
end

every :year, :at => 'March 31st 11:59pm' do
  rake 'config:reset_leaves_every_year'
end
