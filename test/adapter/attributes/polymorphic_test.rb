require 'test_helper'

module ActiveModel
  class Serializer
    module Adapter
      class Attributes
        class PolymorphicTest < ActiveSupport::TestCase
          setup do
            @employee = Employee.new(id: 42, name: 'Zoop Zoopler', email: 'zoop@example.com')
            @picture = @employee.pictures.new(id: 1, title: 'headshot-1.jpg')
            @picture.imageable = @employee

            @serialization = serializable(@picture) # uses default adapter: Attributes
          end

          def test_polymorphic_serializer
            assert_equal({ id: 42, name: 'Zoop Zoopler' }, @serialization.as_json[:imageable])
          end
        end
      end
    end
  end
end
