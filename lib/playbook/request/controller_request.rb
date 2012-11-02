require 'active_support/core_ext/module/delegation'

module Playbook
  module Request
    class ControllerRequest < BaseRequest

      delegate :current_user, :current_geo, :to => :@controller
      attr_reader :controller
      
      def initialize(controller)
        super(controller.params)
        @controller = controller
      end

      def response_class
        ::Playbook::Response::ControllerResponse
      end

      def response_error_class
        ::Playbook::Response::ControllerErrorResponse
      end

    end
  end
end