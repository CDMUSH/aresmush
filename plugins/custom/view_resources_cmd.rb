module AresMUSH
  module Custom
    class ResourcesCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.resources, "#{model.name}'s Resources"
          client.emit template.render
        end
      end
    end
  end
end