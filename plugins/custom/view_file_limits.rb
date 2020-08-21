module AresMUSH
  module Custom
    class ViewFileLimitsCmd
      include CommandHandler
      
      def check_can_use
        return t('dispatcher.not_allowed') if !enactor.is_admin?
        return nil
      end
      
      def handle
        files = Dir[File.join(AresMUSH.game_path, "uploads", "*/*")].select { |f| (File.size(f) / 1024) > Global.read_config("website", "max_upload_size_kb") }.map { |f| "#{f}:#{File.size(f) / 1024}" }
        folders = Dir[File.join(AresMUSH.game_path, "uploads", "*")].select { |f| Website.folder_size_kb(f) > Global.read_config('website', 'max_folder_size_kb') }
        
        template = BorderedDisplayTemplate.new files, "Files Over Limit"
        client.emit template.render
        
        template = BorderedDisplayTemplate.new folders, "Folders Over Limit"
        client.emit template.render
      end

    end
  end
end
