require 'test_helper'

module ActiveModel
  class Serializer
    module Adapter
      class Json
        class PolymorphicTest < ActiveSupport::TestCase
          def setup
            @employee = Employee.new(id: 42, name: 'Zoop Zoopler', email: 'zoop@example.com')
            @picture = @employee.pictures.new(id: 1, title: 'headshot-1.jpg')
            @picture.imageable = @employee

            @serializer = PictureSerializer.new(@picture)
            @adapter = ActiveModel::Serializer::Adapter::Json.new(@serializer)
            ActionController::Base.cache_store.clear
          end

          def test_polymorphic_serializer
            assert_equal({ id: 42, name: 'Zoop Zoopler' }, @adapter.serializable_hash[:picture][:imageable])
          end
        end
      end
    end
  end
end
