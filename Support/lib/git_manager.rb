gem 'git', '>=1.0.0'
require 'git'

class GitManager
  attr_reader :git
  
  def initialize(some_file)
    find_working_dir(some_file)
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
  
  def config
    git.config
  end
  
  def repo_for_remote(remote)
    config["remote.#{remote}.url"]
  end
  
  protected
  def find_working_dir(some_file)
    path = File.dirname(File.expand_path(some_file))
    path_bits = path.split('/') # => ["", "Users", "drnic", "Documents", "ruby", "gems", "rubydoctest", "bin"]
    @git = nil
    while !@git && path_bits.length > 1
      path_bits.pop unless (@git = Git.open(path_bits.join('/')) rescue nil)
    end
  end
end