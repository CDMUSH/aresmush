module AresMUSH
  module Profile
    class CustomCharFields
      
      # Gets custom fields for display in a character profile.
      #
      # @param [Character] char - The character being requested.
      # @param [Character] viewer - The character viewing the profile. May be nil if someone is viewing
      #    the profile without being logged in.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Ansi or markdown text strings must be formatted for display.
      # @example
      #    return { goals: Website.format_markdown_for_html(char.goals) }
      def self.get_fields_for_viewing(char, viewer)
        return { powers: Website.format_markdown_for_html(char.powers), skills: Website.format_markdown_for_html(char.skills), resources: Website.format_markdown_for_html(char.resources), drawbacks: Website.format_markdown_for_html(char.drawbacks) }
      end
    
      # Gets custom fields for the character profile editor.
      #
      # @param [Character] char - The character being requested.
      # @param [Character] viewer - The character editing the profile.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Multi-line text strings must be formatted for editing.
      # @example
      #    return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_editing(char, viewer)
        if (viewer.is_admin?)
          return { powers: Website.format_input_for_html(char.powers), skills: Website.format_input_for_html(char.skills), resources: Website.format_input_for_html(char.resources), drawbacks: Website.format_input_for_html(char.drawbacks) }
        else 
          return { }
        end
      end

      # Gets custom fields for character creation (chargen).
      #
      # @param [Character] char - The character being requested.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Multi-line text strings must be formatted for editing.
      # @example
      #    return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_chargen(char)
        return { powers: Website.format_input_for_html(char.powers), skills: Website.format_input_for_html(char.skills), resources: Website.format_input_for_html(char.resources), drawbacks: Website.format_input_for_html(char.drawbacks)}
      end
      
      # Saves fields from profile editing.
      #
      # @param [Character] char - The character being updated.
      # @param [Hash] char_data - A hash of character fields and values. Your custom fields
      #    will be in char_data[:custom]. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(char_data[:custom][:goals]))
      #        return []
      def self.save_fields_from_profile_edit(char, char_data, enactor)
        if (enactor.is_admin?)
          char.update(powers: Website.format_input_for_mush(char_data[:custom][:powers]))
          char.update(skills: Website.format_input_for_mush(char_data[:custom][:skills]))
          char.update(resources: Website.format_input_for_mush(char_data[:custom][:resources]))
          char.update(drawbacks: Website.format_input_for_mush(char_data[:custom][:drawbacks]))
          return []
        end
      end
      
      # Saves fields from character creation (chargen).
      #
      # @param [Character] char - The character being updated.
      # @param [Hash] chargen_data - A hash of character fields and values. Your custom fields
      #    will be in chargen_data[:custom]. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(chargen_data[:custom][:goals]))
      #        return []
      def self.save_fields_from_chargen(char, chargen_data)
        char.update(powers: chargen_data[:custom][:powers])
        char.update(skills: chargen_data[:custom][:skills])
        char.update(resources: chargen_data[:custom][:resources])
        char.update(drawbacks: chargen_data[:custom][:drawbacks])
        return []
      end
      
    end
  end
end