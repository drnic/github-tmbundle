gem 'git', '>=1.0.0'
require 'git'
require 'git-ext/commit'
require 'net/http'

class GitManager
  attr_reader :git, :target_file
  
  def initialize(target_file)
    @target_file = target_file || ""
    find_working_dir
  end
  
  def remotes
    config_remotes = config.keys.inject([]) do |mem, key|
      if key =~ %r{\Aremote\.(.*)\.url}
        mem << $1
      end
      mem
    end
  end
  
  def github_remotes
    remotes.inject([]) do |mem, remote|
      if repo_for_remote(remote) =~ %r{github\.com}
        mem << remote
      end
      mem
    end
  end
  
  def best_github_remote
    remotes = github_remotes
    selected_remote = 'github' if remotes.include?('github')
    selected_remote ||= 'origin' if remotes.include?('origin')
    selected_remote ||= remotes.first
    raise NotGitHubRepositoryError unless selected_remote
    
    return selected_remote
  end

  def user_project_from_repo(repo)
    if repo =~ %r{github\.com[:/]([^/]+)/(.+)\.git}
      return {:user => $1, :project => $2}
    end
    return 
  end
  
  def github_url_for_project(github_remote=nil)
    github_remote ||= best_github_remote
    repo = repo_for_remote(github_remote)
    if user_project = user_project_from_repo(repo)
      url_head(user_project)
    end
  end  
  
  def file_to_github_url(github_remote, branch='master', file=nil)
    file ||= target_file
    branch ||= @git.current_branch
    repo = repo_for_remote(github_remote)
    path = file.gsub(working_path, '').gsub(%r{\A/},'')
    if user_project = user_project_from_repo(repo)
      user, project = $1, $2
      response = nil
      url_head(user_project, branch) + "/#{path}"
    end
  end
  
  def relative_file(file=nil)
    file ||= target_file
    file = File.expand_path(file).sub(%r{\A#{working_path}/}, '')
  end
  
  # Returns the Git::Object::Commit that adds a +line+
  def find_commit_with_line(line)
    git.log.path(relative_file).each do |commit|
      return commit if line_in_diff?(commit.diff_parent.to_s, line)
    end
    nil
  end
  
  # Check if the exact line was added in a specific commit (via its parent_diff)
  # TODO - Ensure line is within specific +file+, else might get match within wrong file
  # parent_diff - the results of Git::Object::Commit#parent_diff
  # line - the exact string to match on one line of the diff
  def line_in_diff?(parent_diff, line)
    parent_diff.to_s.split("\n").find { |diff_line| diff_line == "-#{line}" }
  end

  def git?
    git
  end
  
  def working_path
    git.instance_variable_get("@working_directory").path
  end
  
  protected
  def config
    git.config
  end
  
  def find_working_dir
    path = File.dirname(File.expand_path(target_file))
    path_bits = path.split('/') # => ["", "Users", "drnic", "Documents", "ruby", "gems", "newgem", "bin"]
    @git = nil
    while !@git && path_bits.length > 1
      path = path_bits.join('/')
      path_bits.pop unless (@git = Git.open(path) rescue nil)
    end
    raise NotGitRepositoryError unless @git
  end

  def repo_for_remote(remote)
    config["remote.#{remote}.url"]
  end
  
  def url_head(user_project, branch='')
    branch = "blob/#{branch}" if branch != ''
    project_path = "/#{user_project[:user]}/#{user_project[:project]}/#{branch}"
    "https://github.com#{project_path}"
  end
  
end