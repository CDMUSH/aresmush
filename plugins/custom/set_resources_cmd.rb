module AresMUSH
  module Custom
    class SetResourcesCmd
      include CommandHandler
      
      attr_accessor :resources

      def parse_args
       self.resources = trim_arg(cmd.args)
      end

      def handle
        if Chargen.check_chargen_locked(enactor)
          client.emit "%xr%% You can't change this after app submission or approval.%xn"
        else
          enactor.update(resources: self.resources)
          client.emit_success "Resources set!"
        end
      end
    end
  end
end