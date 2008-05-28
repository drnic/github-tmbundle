require 'git_manager'

module ShowInGitHub
  extend self
  attr_reader :git
  
  def url_for(file_path)
    @git = GitManager.new(file_path)
    return nil unless git.git?
    remotes = git.github_remotes
    selected_remote = 'github' if remotes.include?('github')
    selected_remote ||= 'origin' if remotes.include?('origin')
    selected_remote ||= remotes.first
    return nil unless selected_remote
    git.file_to_github_url(selected_remote)
  end
  
  def line_to_github_url(file_path, line_str)
    return nil unless file_url = url_for(file_path)
    project_url = file_url.sub(%r{/tree/.*/#{File.basename(file_path)}$}, '')
    commit = git.find_commit_with_line(line_str)
    return nil unless commit
    file_index = commit.file_paths.index(git.relative_file(file_path))
    "#{project_url}/commit/#{commit.to_s}#diff-#{file_index}"
  end
  
  
end