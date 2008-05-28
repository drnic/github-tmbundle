require File.dirname(__FILE__) + "/test_helper"
require "show_in_github"

class TestShowLineInCommitInGitHub < Test::Unit::TestCase
  attr_reader :git
  def setup
    @git = GitManager.new __FILE__
    @file = git.relative_file
    puts "These tests require the project to be checked out of git to work" unless @git
  end
  
  def test_find_first_commit_for_this_file
    line_in_first_commit = "class TestShowLineInCommitInGitHub < Test::Unit::TestCase"
    expected = "3becfbcb01574cb4efbcc553ad4be37f6e428e03"
    actual = git.find_commit_with_line(line_in_first_commit)
    assert_equal(expected, actual.to_s)
  end
  
  def test_find_line_in_diff
    # diff_parent is a reverse diff, so added lines prefix with -; removed lines +
    diff_parent = <<-DIFF
diff --git a/Support/test/test_show_line_in_commit_in_github.rb b/Support/test/test_show_line_in_commit_in_github.rb
deleted file mode 100644
index 63b416f..0000000
--- a/Support/test/test_show_line_in_commit_in_github.rb
+++ /dev/null
@@ -1,8 +0,0 @@
-require File.dirname(__FILE__) + "/test_helper"
-require "show_in_github"
-
-class TestShowLineInCommitInGitHub < Test::Unit::TestCase
-  def test_find_first_commit_for_this_file
-    
-  end
-end
\ No newline at end of file
    DIFF
    current_line = "class TestShowLineInCommitInGitHub < Test::Unit::TestCase"
    assert git.line_in_diff?(diff_parent, current_line), "should find line in diff"
    assert !git.line_in_diff?(diff_parent, "-" + current_line), "should not find modded line in diff"
  end
  
  def test_file_index_within_multi_file_commit
  end
end