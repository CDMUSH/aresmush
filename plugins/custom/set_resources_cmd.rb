module AresMUSH
  module Custom
    class SetResourcesCmd
      include CommandHandler
      
      attr_accessor :resources

      def parse_args
       self.resources = trim_arg(cmd.args)
      end

      def handle
        enactor.update(resources: self.resources)
        client.emit_success "Resources set!"
      end
    end
  end
end