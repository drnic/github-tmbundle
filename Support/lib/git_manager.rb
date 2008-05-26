gem 'git', '>=1.0.0'
require 'git'

class GitManager
  attr_reader :git, :target_file
  
  def initialize(target_file)
    @target_file = target_file
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
  
  def file_to_github_url(github_remote, branch='master', file=nil)
    file ||= target_file
    repo = repo_for_remote(github_remote)
    path = file.gsub(working_path, '').gsub(%r{\A/},'')
    if repo =~ %r{github\.com:([^/]+)/([^.]+)\.git}
      user, project = $1, $2
      "http://github.com/#{user}/#{project}/tree/#{branch}/#{path}"
    end
  end
  
  def git?
    git
  end
  
  protected
  def config
    git.config
  end
  
  def working_path
    git.instance_variable_get("@working_directory").path
  end
  
  def find_working_dir
    path = File.dirname(File.expand_path(target_file))
    path_bits = path.split('/') # => ["", "Users", "drnic", "Documents", "ruby", "gems", "newgem", "bin"]
    @git = nil
    while !@git && path_bits.length > 1
      path_bits.pop unless (@git = Git.open(path_bits.join('/')) rescue nil)
    end
  end

  def repo_for_remote(remote)
    config["remote.#{remote}.url"]
  end
  
end