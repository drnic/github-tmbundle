require 'git_manager'

class NotGitRepositoryError < Exception; end
class NotGitHubRepositoryError < Exception; end
class CommitNotFoundError < Exception; end
# SocketError can be thrown when testing public access to repo

module ShowInGitHub
  extend self
  attr_reader :git
  
  def url_for(file_path)
    @git = GitManager.new(file_path)
    git.file_to_github_url(git.best_github_remote)
  end
  
  # TODO - investigate using "git blame -l -s -L 3,3 app/models/user.rb" instead
  # -l complete hash
  # -s strips user fu
  def line_to_github_url(file_path, line_str)
    return nil unless file_url = url_for(file_path)
    project_url = file_url.sub(%r{/blob/.*/#{File.basename(file_path)}$}, '')
    commit = git.find_commit_with_line(line_str)
    return nil unless commit
    file_index = commit.file_paths.index(git.relative_file(file_path))
    "#{project_url}/commit/#{commit.to_s}#diff-#{file_index}"
  end
  
  
end