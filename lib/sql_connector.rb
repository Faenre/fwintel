require 'pg'

# abstraction object against pg
class SQLConnector
  def initialize(config)
    @connection = PG::Connection.new(config)
  end

  def exec(statement, &:block)
    @connection.exec statement, :block
  end
end
