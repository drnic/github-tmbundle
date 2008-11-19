# Copyright 2008 Chris Wanstrath
# Taken from defunkt's gist repository: http://github.com/defunkt/gist/tree/master

require 'open-uri'
require 'net/http'

module Gist
  extend self

  @@gist_url = 'http://gist.github.com/%s.txt'

  def read(gist_id)
    return help if gist_id == '-h' || gist_id.nil? || gist_id[/help/]
    open(@@gist_url % gist_id).read
  end

  def write(gistname, content, private_gist)
    url = URI.parse('http://gist.github.com/gists')
    req = Net::HTTP.post_form(url, data(gistname, nil, content, private_gist))
    copy req['Location']
  end

private
  def copy(content)
    case RUBY_PLATFORM
    when /darwin/
      return content if `which pbcopy`.strip == ''
      IO.popen('pbcopy', 'r+') { |clip| clip.puts content }
    when /linux/
      return content if `which xclip`.strip == ''
      IO.popen('xclip', 'r+') { |clip| clip.puts content }
    end

    content
  end

  def data(name, ext, content, private_gist)
    return {
      'file_ext[gistfile1]'      => ext,
      'file_name[gistfile1]'     => name,
      'file_contents[gistfile1]' => content
    }.merge(private_gist ? { 'private' => 'on' } : {}).merge(auth)
  end

  def auth
    user  = `git config --global github.user`.strip
    token = `git config --global github.token`.strip

    user.empty? ? {} : { :login => user, :token => token }
  end
end

