module AresMUSH
  module Custom
    class SetSkillsCmd
      include CommandHandler
      
      attr_accessor :skills

      def parse_args
       self.skills = trim_arg(cmd.args)
      end

      def handle
        enactor.update(skills: self.skills)
        client.emit_success "Skills set!"
      end
    end
  end
end