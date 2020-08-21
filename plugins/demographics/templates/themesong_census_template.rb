module AresMUSH
  module Demographics
    class ThemesongCensusTemplate < ErbTemplateRenderer      
      attr_accessor :paginator
      
      def initialize(paginator)
        @paginator = paginator
        super File.dirname(__FILE__) + "/themesong_census_template.erb"
      end      
    end
  end
end