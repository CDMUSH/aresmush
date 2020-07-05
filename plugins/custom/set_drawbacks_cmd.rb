module AresMUSH
  module Custom
    class SetDrawbacksCmd
      include CommandHandler
      
      attr_accessor :drawbacks

      def parse_args
       self.drawbacks = trim_arg(cmd.args)
      end

      def handle
        enactor.update(drawbacks: self.drawbacks)
        client.emit_success "Drawbacks set!"
      end
    end
  end
end