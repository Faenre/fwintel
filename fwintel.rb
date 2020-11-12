require './lib/database'
require './lib/fw'

require 'date'
require 'rufus-scheduler'

# Connect to DB
DBIO = DatabaseIO.new
latest_expiry = DBIO.query_latest_expiry
latest_expiry ? DateTime.parse(latest_expiry) : DateTime.now()
DBIO.close

scheduler = Rufus::Scheduler.new

scheduler.every '1m' do
  next unless now() > next_run_at

  # Check new FW status
  current_fw = FWStatus.new
  response_id = DBIO.register_esi_response(current_fw.code)

  # Write system statuses
  DBIO.insert_system_statuses(response_id, current_fw.systems)

  # Get discord configs

  # Post to discord

end
