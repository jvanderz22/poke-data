require 'representer_factory'
require 'roar_ext/merge_linked'
require 'rack-link_headers'

# Controller mixin to DRY up the common handling of rendering
# JSON API formatted resources via various {JsonApiRepresenter}
# instances.
module RepresentsJsonApiResources
  def represent(resource, options = {})
    representer = RepresenterFactory.call(resource, options)
    representation = representer.to_hash(options.except(
      :status, :location
    ))

    render_options = {
      json: RoarExt::MergeLinked.flatten(representation),
      content_type: 'application/vnd.api+json'
    }.merge(options.slice(:status, :location))

    render(render_options)
  end
end
