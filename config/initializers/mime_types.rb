# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.register 'application/vnd.api+json', :json_api
Mime::Type.register 'application/json-path+json', :json_path
ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::JSON_API] = ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::JSON]
