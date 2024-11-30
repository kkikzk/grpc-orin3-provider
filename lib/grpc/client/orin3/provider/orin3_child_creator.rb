module Grpc
  module Client
    module ORiN3
      module Provider
        module ORiN3ChildCreator
          def create_variable(name, type_name, option, value_type)
            begin
              controller = O3::ChildCreatorService::Stub.new(nil, :this_channel_is_insecure, channel_override: @channel)
              request = O3::CreateVariableRequest.new(common: O3P::CommonRequest.new, parent_id: @internal_id, name: name, type_name: type_name, option: option, value_type: value_type)
              response = controller.create_variable(request)
              if (response.common.result_code != :SUCCEEDED)
                raise MessageClientError.new(response.common.result_code, response.common.detail)
              end
              return ORiN3Variable.new(@channel, response.variable_id, response.created_datetime, value_type)
            rescue MessageClientError
              raise
            rescue StandardError => e
              raise MessageClientError.new(e)
            end  
          end
        end
      end
    end
  end
end