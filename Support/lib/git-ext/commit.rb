class Git::Object::Commit
  # Ordered list of files within a commit
  def file_paths
    diff_parent.to_s.scan(%r{^-{3,4}\sa/(.*)$})[0..-1].flatten.uniq
  end
end