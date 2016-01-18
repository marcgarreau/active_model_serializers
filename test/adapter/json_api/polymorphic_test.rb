require 'test_helper'

module ActiveModel
  class Serializer
    module Adapter
      class JsonApi
        class PolymorphicTest < ActiveSupport::TestCase
          setup do
            @employee = Employee.new(id: 42, name: 'Zoop Zoopler', email: 'zoop@example.com')
            @picture = @employee.pictures.new(id: 1, title: 'headshot-1.jpg')
            @picture.imageable = @employee

            @serialization = serializable(@picture, adapter: :json_api)
          end

          def test_polymorphic_serializer
            expected = { data: { id: '42', type: 'employees' } }

            assert_equal(expected, @serialization.as_json[:data][:relationships][:imageable])
          end
        end
      end
    end
  end
end
