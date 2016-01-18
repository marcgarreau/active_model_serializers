require 'test_helper'

module ActiveModel
  class Serializer
    module Adapter
      class Json
        class PolymorphicTest < ActiveSupport::TestCase
          setup do
            @employee = Employee.new(id: 42, name: 'Zoop Zoopler', email: 'zoop@example.com')
            @picture = @employee.pictures.new(id: 1, title: 'headshot-1.jpg')
            @picture.imageable = @employee

            @serialization = serializable(@picture, adapter: :json)
            ActionController::Base.cache_store.clear
          end

          def test_polymorphic_serializer
            assert_equal({ id: 42, name: 'Zoop Zoopler' }, @serialization.as_json[:picture][:imageable])
          end
        end
      end
    end
  end
end
