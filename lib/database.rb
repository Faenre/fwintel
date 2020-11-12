require './lib/sql_connector.rb'

# handler for fw db queries
class DatabaseIO
  SQL_INSERT_SYSTEMS = File.read('./sql/insert_system_status.sql')
  SQL_QUERY_LATEST_EXPIRY = File.read('./sql/query_latest_expiry.sql')
  SQL_QUERY_SYSTEMS = File.read('./sql/query_system_history.sql')
  SQL_REGISTER_ESI_RESPONSE = File.read('./sql/register_new_esi_response')

  def initialize
    config = {
      host:     ENV['DB_HOST'],
      port:     ENV['DB_PORT'],
      dbname:   ENV['DB_NAME'],
      user:     ENV['DB_USER'],
      password: ENV['DB_PASS']
    }
    renew
  end

  def renew
    @connection = SQLConnector.new
  end

  def close
    @connection.close
  end

  def query_latest_expiry
    @connection.exec(format(SQL_QUERY_LATEST_EXPIRY, FWStatus.code),
                     (response)->{ response.first['expiry'] })
  end

  def query_systems(history=1)
    @connection.exec(format(SQL_QUERY_SYSTEMS, history)) do |results|
      results.map.with_object({}) do |systems, sys|
        id = sys['system_id'].to_i
        systems[id] ||= { owner: sys['owning_faction'].to_i,
                          current_max: sys['vp_max'].to_i,
                          scores: [] }
        systems[id][:scores] << sys[:vp_current.to_i]
      end
    end
  end

  def register_esi_response(code, timestamp)
    raise ArgumentError unless (100...600).cover? status_code

    @connection.exec(format(SQL_REGISTER_ESI_RESPONSE, FWStatus.code),
                     (response)->{ response.first['id'] })
  end

  def insert_system_statuses(response_id, systems)
    values = systems.map do |sys|
      keys = [response_id, sys.eve_id, sys.vp_current, sys.vp_max]
      "(#{keys.join ', '})"
    end

    @connection.exec(format(SQL_INSERT_SYSTEMS), values) {}
  end
end
