$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Custom
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("custom", "shortcuts")
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "powers"
        case cmd.switch
        when "set"
          return SetPowersCmd
        else
          return PowersCmd
        end
      when "skills"
        case cmd.switch
        when "set"
          return SetSkillsCmd
        else
          return SkillsCmd
        end
      when "resources"
        case cmd.switch
        when "set"
          return SetResourcesCmd
        else
          return ResourcesCmd
        end
      when "drawbacks"
        case cmd.switch
        when "set"
          return SetDrawbacksCmd
        else
          return DrawbacksCmd
        end
      when "listfactions"
        return FactionsViewCmd
      end
      return nil
    end

  end
end
