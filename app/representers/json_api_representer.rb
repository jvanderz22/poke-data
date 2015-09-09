require 'roar_ext'
require 'roar/coercion'

# Common behavior across all `Roar::Decorator` instances that are used
# to serialize resources into the expected JSON API format.
module JsonApiRepresenter
  def self.included(klass)
    klass.class_eval do
      include Roar::JSON::JSONAPI
      extend JsonApiRepresenter::ClassMethods
    end
  end

  module ClassMethods
    def decorate(*props)
      options = props.extract_options!
      props.each do |prop|
        property prop, options.merge(exec_context: :decorator)
      end
    end

    def properties(*props)
      options = props.extract_options!
      props.each do |prop|
        property prop, options
      end
    end
  end
end
