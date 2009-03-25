require File.dirname(__FILE__) + "/test_helper"

class TestGitManager < Test::Unit::TestCase
  def setup
    @git = GitManager.new(__FILE__) # pass this file just cause we need some file
    @git.stubs(:config).returns({
      "user.name"=>"Dr Nic Williams", "user.email"=>"drnicwilliams@gmail.com", 
      "remote.origin.url"=>"git@github.com:drnic/newgem.git", 
      "remote.origin.fetch"=>"refs/heads/*:refs/remotes/origin/*", 
      "remote.rubyforge.fetch"=>"refs/heads/*:refs/remotes/rubyforge/*", 
      "remote.rubyforge.url"=>"gitosis@rubyforge.org:newgem.git"
    })
  end
  
  def test_get_remotes
    expected = %w[origin rubyforge]
    assert_equal(expected, @git.remotes)
  end
  
  def test_get_remotes_on_github
    expected = %w[origin]
    assert_equal(expected, @git.github_remotes)
  end
  
  def test_github_pages_account_remote_urls_can_be_parsed
    @git.stubs(:config).returns({
      "user.name"=>"Dr Nic Williams", "user.email"=>"drnicwilliams@gmail.com", 
      "remote.origin.url"=>"git@github.com:railscampau/railscampau.github.com.git", 
      "remote.origin.fetch"=>"refs/heads/*:refs/remotes/origin/*"
    })
    expected = "http://github.com/railscampau/railscampau.github.com/"
    assert_equal(expected, @git.github_url_for_project)
  end
end