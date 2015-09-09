# Performs the heavy-lifting of identifying and instantiating
# the correct `Representer` for {RepresentsJsonApiResources}.
class RepresenterFactory
  # @param (see #initialize)
  # @return (see #representer)
  def self.call(resource, options = {})
    new(resource, options).representer
  end

  # @param resource [ActiveRecord::Relation, Object]
  def initialize(resource, options = {})
    @resource = resource
    @explicit_resource_class = options[:as]
  end

  # @return [Class]
  def representer_class
    @representer_class ||= Object.const_get("#{resource_class_name}Representer")
  end

  # @return [Roar::Decorator] a representer instance suitable for
  #   rendering a JSON API response to the client.
  def representer
    if has_errors?
      ValidationErrorRepresenter.for_collection.prepare(resource_errors)
    elsif collection_resource?
      representer_class.for_collection.prepare(@resource)
    else
      representer_class.prepare(@resource)
    end
  end

  private

  def has_errors?
    @resource.respond_to?(:errors) && !@resource.errors.empty?
  end

  def resource_class_name
    return @explicit_resource_class.to_s.capitalize unless @explicit_resource_class.nil?
    if collection_resource?
      @resource.klass.name
    else
      @resource.class.name
    end
  end

  def collection_resource?
    @resource.kind_of?(ActiveRecord::Relation)
  end

  def resource_errors
    resource_name = resource_class_name.underscore
    root = "/#{resource_name.pluralize}"

    @resource.errors.map do |attribute, message|
      if attribute.to_s == resource_name
        attribute = 'id'
      end

      { path: "#{root}/#{attribute}", code: message }
    end
  end
end
