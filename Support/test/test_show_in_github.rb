require "test/unit"
$:.unshift(File.dirname(__FILE__) + "/../lib")
require "show_in_github"

class TestShowInGithub < Test::Unit::TestCase
  def test_do_nothing_if_file_not_under_git_repo
    
  end
  
  def test_do_nothing_if_no_repo_is_with_github
    
  end
  
  def test_construct_github_url_for_file
    
  end
  
  def test_prioritize_github_over_other_remote_names
    
  end

  def test_prioritize_origin_over_other_remote_names_except_origin
    
  end

end