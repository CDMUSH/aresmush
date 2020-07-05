module AresMUSH
  module Custom
    class SetPowersCmd
      include CommandHandler
      
      attr_accessor :powers

      def parse_args
       self.powers = trim_arg(cmd.args)
      end

      def handle
        enactor.update(powers: self.powers)
        client.emit_success "Powers set!"
      end
    end
  end
end