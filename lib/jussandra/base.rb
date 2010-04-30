require 'cassandra'
require 'set'
require 'jussandra/attributes'
require 'jussandra/dirty'
require 'jussandra/persistence'

if Jussandra.old_active_support
  require 'jussandra/legacy_callbacks'
else
  require 'jussandra/callbacks'
end

require 'jussandra/validation'
require 'jussandra/identity'
require 'jussandra/indexes'
require 'jussandra/serialization'
require 'jussandra/associations'
require 'jussandra/migrations'
require 'jussandra/cursor'
require 'jussandra/collection'
require 'jussandra/types'
require 'jussandra/mocking'

module Jussandra
  class Base
    class_inheritable_accessor :connection
    class_inheritable_writer :connection_class

    def self.connection_class
      read_inheritable_attribute(:connection_class) || Cassandra
    end

    module ConnectionManagement
      def establish_connection(*args)
        self.connection = connection_class.new(*args)
      end
    end
    extend ConnectionManagement

    module Naming
      def column_family=(column_family)
        @column_family = column_family
      end

      def column_family
        @column_family || name.pluralize
      end
    end
    extend Naming
    
    if Jussandra.old_active_support
      def self.lookup_ancestors
        super.select { |x| x.model_name.present? }
      end
    end
    
    extend ActiveModel::Naming
    
    module ConfigurationDumper
      def storage_config_xml
        subclasses.map(&:constantize).map(&:column_family_configuration).flatten.map do |config|
          config_to_xml(config)
        end.join("\n")
      end
      
      def config_to_xml(config)
        xml = "<ColumnFamily "
        config.each do |(attr_name, attr_value)|
          xml << " #{attr_name}=\"#{attr_value}\""
        end
        xml << " />"
        xml
      end
    end
    extend ConfigurationDumper
    
    include Callbacks
    include Identity
    include Attributes
    include Persistence
    include Indexes
    include Dirty

    include Validation
    include Associations

    attr_reader :attributes
    attr_accessor :key

    include Serialization
    include Migrations
    include Mocking

    def initialize(attributes={})
      @key = attributes.delete(:key)
      @new_record = true
      @attributes = {}.with_indifferent_access
      self.attributes = attributes
      @schema_version = self.class.current_schema_version
    end
  end
end

require 'jussandra/type_registration'