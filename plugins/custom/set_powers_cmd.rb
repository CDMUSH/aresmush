module AresMUSH
  module Custom
    class SetPowersCmd
      include CommandHandler
      
      attr_accessor :powers

      def parse_args
       self.powers = trim_arg(cmd.args)
      end

      def handle
        if Chargen.check_chargen_locked(enactor)
          client.emit "%xr%% You can't change this after app submission or approval.%xn"
        else
          enactor.update(powers: self.powers)
          client.emit_success "Powers set!"
        end
      end
    end
  end
end