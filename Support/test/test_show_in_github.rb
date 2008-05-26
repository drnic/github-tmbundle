require File.dirname(__FILE__) + "/test_helper"
require "show_in_github"

class TestShowInGithub < Test::Unit::TestCase
  def setup
    GitManager.any_instance.stubs(:git?).returns(true)
  end

  def test_do_nothing_if_file_not_under_git_repo
    GitManager.any_instance.stubs(:git?).returns(false)
    GitManager.any_instance.stubs(:config).returns(nil)
    url = ShowInGitHub.url_for("/some/path/to/file")
    assert_nil(url)
  end
  
  def test_do_nothing_if_no_repo_is_with_github
    GitManager.any_instance.stubs(:config).returns({
      "user.name"=>"Dr Nic Williams", "user.email"=>"drnicwilliams@gmail.com", 
      "remote.rubyforge.fetch"=>"refs/heads/*:refs/remotes/rubyforge/*", 
      "remote.rubyforge.url"=>"gitosis@rubyforge.org:newgem.git"
    })
    url = ShowInGitHub.url_for("/some/path/to/file")
    assert_nil(url)
  end
  
  def test_construct_github_url_for_file
    GitManager.any_instance.stubs(:config).returns({
      "user.name"=>"Dr Nic Williams", "user.email"=>"drnicwilliams@gmail.com", 
      "remote.origin.url"=>"git@github.com:drnic/newgem.git", 
      "remote.origin.fetch"=>"refs/heads/*:refs/remotes/origin/*", 
      "remote.rubyforge.fetch"=>"refs/heads/*:refs/remotes/rubyforge/*", 
      "remote.rubyforge.url"=>"gitosis@rubyforge.org:newgem.git"
    })
    GitManager.any_instance.stubs(:working_path).returns("/some/path")
    url = ShowInGitHub.url_for("/some/path/to/file")
    expected = "http://github.com/drnic/newgem/tree/master/to/file"
    assert_equal(expected, url)
  end
  
  def test_prioritize_github_over_other_remote_names
    GitManager.any_instance.stubs(:config).returns({
      "user.name"=>"Dr Nic Williams", "user.email"=>"drnicwilliams@gmail.com", 
      "remote.origin.url"=>"git@github.com:drnic/newgem-origin.git", 
      "remote.github.url"=>"git@github.com:drnic/newgem-github.git", 
      "remote.somethingelse.url"=>"git@github.com:drnic/newgem-somethingelse.git", 
    })
    GitManager.any_instance.stubs(:working_path).returns("/some/path")
    url = ShowInGitHub.url_for("/some/path/to/file")
    expected = "http://github.com/drnic/newgem-github/tree/master/to/file"
    assert_equal(expected, url)
  end

  def test_prioritize_origin_over_other_remote_names_except_origin
    GitManager.any_instance.stubs(:config).returns({
      "user.name"=>"Dr Nic Williams", "user.email"=>"drnicwilliams@gmail.com", 
      "remote.origin.url"=>"git@github.com:drnic/newgem-origin.git", 
      "remote.somethingelse.url"=>"git@github.com:drnic/newgem-somethingelse.git", 
    })
    GitManager.any_instance.stubs(:working_path).returns("/some/path")
    url = ShowInGitHub.url_for("/some/path/to/file")
    expected = "http://github.com/drnic/newgem-origin/tree/master/to/file"
    assert_equal(expected, url)
  end

end