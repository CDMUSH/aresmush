module AresMUSH
  module Custom
    class FactionsViewCmd
      include CommandHandler
      
      # Syntax - listfactions or listfactions <fac name>

      attr_accessor :fac_name

      def parse_args
        self.fac_name = cmd.args ? cmd.args : enactor_name
      end

      def handle
        
        av = Character.all.select { |c| c.demographics['factions'] =~ /Avengers/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        de = Character.all.select { |c| c.demographics['factions'] =~ /Defenders/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        gk = Character.all.select { |c| c.demographics['factions'] =~ /Gotham Knights/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        gu = Character.all.select { |c| c.demographics['factions'] =~ /Guardians/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        hc = Character.all.select { |c| c.demographics['factions'] =~ /Hellfire Club/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        jl = Character.all.select { |c| c.demographics['factions'] =~ /Justice League/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        sh = Character.all.select { |c| c.demographics['factions'] =~ /SHIELD|S.H.I.E.L.D./i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        ti = Character.all.select { |c| c.demographics['factions'] =~ /Titans/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s
        xm = Character.all.select { |c| c.demographics['factions'] =~ /X-Men/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.count.to_s

        if (self.fac_name == enactor_name)
          content = {"Avengers" => {"oocleads" => "Tony Stark, Thor", "icleads" => "Tony Stark, Steve Rogers", "count" => "#{av}" }, "Defenders" => {"oocleads" => "Matt Murdock, Jessica Jones", "icleads" => "None", "count" => "#{de}" }, "Gotham Knights" => {"oocleads" => "Barbara Gordon", "icleads" => "Batman", "count" => "#{gk}" }, "Guardians" => {"oocleads" => "Atli", "icleads" => "Peter Quill", "count" => "#{gu}" }, "Hellfire Club" => {"oocleads" => "Emma Frost", "icleads" => "Sebastian Shaw (New York Chapter)", "count" => "#{hc}" }, "Justice League" => {"oocleads" => "Superman", "icleads" => "Justice League Council", "count" => "#{jl}" }, "SHIELD" => {"oocleads" => "Peggy Carter", "icleads" => "Nick Fury", "count" => "#{sh}" }, "Titans" => {"oocleads" => "Tim Drake", "icleads" => "Tim Drake", "count" => "#{ti}" }, "X-Men" => {"oocleads" => "Warren Worthington, Dani Moonstar", "icleads" => "Warren Worthington, Dani Moonstar", "count" => "#{xm}" } }

          template = FactionListTemplate.new content, "CDMUSH Faction List", "%rUse %xhlistfactions <name>%xn to see faction rosters.", "For a full faction list, see https://commondescentmush.com/wiki/fac%r"
          client.emit template.render

        else
          if (self.fac_name == "SHIELD")
            self.fac_name = "SHIELD|S.H.I.E.L.D."
          end

          c = Character.all.select { |c| c.demographics['factions'] =~ /#{self.fac_name}/i && !c.is_npc? && !c.is_admin? && c.is_approved? }.map { |c| "#{c.name} #{c.demographics['nickname']}" }
          template = BorderedTableTemplate.new c, 39, "Faction Roster"
          client.emit template.render

#          c.each do |k,v|
#            client.emit_success "#{k.name}"
#          end
        end
      end

    end
  end
end