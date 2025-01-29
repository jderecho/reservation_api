Rswag::Ui.configure do |c|

  # List the Swagger endpoints that you want to be documented through the
  # swagger-ui. The first parameter is the path (absolute or relative to the UI
  # host) to the corresponding endpoint and the second is a title that will be
  # displayed in the document selector.
  # NOTE: If you're using rspec-api to expose Swagger files
  # (under openapi_root) as JSON or YAML endpoints, then the list below should
  # correspond to the relative paths for those endpoints.

  swagger_path = 'public_api/v1/swagger.yaml'

  c.swagger_endpoint '/api-docs/v1/swagger.yaml', 'API V1 Docs'

  # Add Basic Auth in case your API is private
  # c.basic_auth_enabled = true
  # c.basic_auth_credentials 'username', 'password'
end


# Rswag::Ui.configure do |c|
#   require 'yaml'
#   # List the Swagger endpoints that you want to be documented through the
#   # swagger-ui. The first parameter is the path (absolute or relative to the UI
#   # host) to the corresponding endpoint and the second is a title that will be
#   # displayed in the document selector.
#   # NOTE: If you're using rspec-api to expose Swagger files
#   # (under swagger_root) as JSON or YAML endpoints, then the list below should
#   # correspond to the relative paths for those endpoints.

#   swagger_path = 'public_api/v1/swagger.yaml'

#   c.swagger_endpoint "/api-docs/#{swagger_path}", 'API V1 Docs'

#   # SwaggerDoc Dynamic Hosts
#   swagger_file = "#{Rswag::Api.config.swagger_root}/#{swagger_path}"

#   if File.exists?(swagger_file) && !Rails.env.test?
#     data = YAML.load_file swagger_file

#     if data
#       update_swagger_file = false
#       default_protocol = Rails.env.development? ? 'http' : 'https'

#       data['servers']&.each do |datum|
#         host = RSportz::HOST.to_s
#         host += ':3000' if RSportz::HOST == 'rsportz.local'
#         url = "#{default_protocol}://{subdomain}.{host}"

#         update_swagger_file = true if host != datum['variables']['host']['default']

#         datum['url'] = url
#         datum['variables']['host']['default'] = host
#       end

#       if update_swagger_file
#         File.open(swagger_file, 'w') { |f| YAML.dump(data, f) }

#         p 'Updated Swagger File Host.'
#       end
#     end
#   end

#   # Add Basic Auth in case your API is private
#   c.basic_auth_enabled = true
#   c.basic_auth_credentials 'admin', Figaro.env.swagger_login_pass_key

#   # Use local template
#   c.instance_variable_set(
#     '@template_locations', [
#       Rails.root.join('app/views/swagger/api-docs/index.html.erb')
#     ]
#   )
# end
