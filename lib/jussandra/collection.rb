module Jussandra
  class Collection < Array
    attr_accessor :last_column_name
    def inspect
      "<Jussandra::Collection##{object_id} contents: #{super} last_column_name: #{last_column_name.inspect}>"
    end
  end
end