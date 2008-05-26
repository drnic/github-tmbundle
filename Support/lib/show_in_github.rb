require 'git_manager'

class ShowInGitHub
  def self.url_for(file_path)
    git = GitManager.new(file_path)
    return nil unless git.git?
    remotes = git.github_remotes
    selected_remote = 'github' if remotes.include?('github')
    selected_remote ||= 'origin' if remotes.include?('origin')
    selected_remote ||= remotes.first
    return nil unless selected_remote
    git.file_to_github_url(selected_remote)
  end
end