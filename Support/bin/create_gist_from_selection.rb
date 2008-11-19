#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "gist"

# Add extension for supported modes based on TM_SCOPE
# Cribbed from http://github.com/defunkt/gist.el/tree/master/gist.el
def get_extension
  scope = ENV["TM_SCOPE"].split[0]
  case scope
  when "source.actionscript" : "as"
  when "source.c", "source.objc" : "c"
  when "source.c++", "source.objc++" : "cpp"
  # common-lisp-mode : "el"
  when "source.css" : "css"
  when "source.diff", "meta.diff.range" : "diff"
  # emacs-lisp-mode : "el"
  when "source.erlang" : "erl"
  when "source.haskell", "text.tex.latex.haskel" : "hs"
  when "text.html" : "html"
  when "source.io" : "io"
  when "source.java" : "java"
  when "source.js" : "js"
  # jde-mode : "java"
  # js2-mode : "js"
  when "source.lua" : "lua"
  when "source.ocaml" : "ml"
  when "source.objc", "source.objc++" : "m"
  when "source.perl" : "pl"
  when "source.php" : "php"
  when "source.python" : "sc"
  when "source.ruby" : "rb" # Emacs bundle uses rbx
  when "text.plain" : "txt"
  when "source.sql" : "sql"
  when "source.scheme" : "scm"
  when "source.smalltalk" : "st"
  when "source.shell" : "sh"
  when "source.tcl", "text.html.tcl" : "tcl"
  when "source.lex" : "tex"
  when "text.xml", "text.xml.xsl", "source.plist", "text.xml.plist" : "xml"
  else "txt"
  end
end

selection = nil
gistname = nil
if ENV['TM_SELECTED_TEXT']
  selection = ENV['TM_SELECTED_TEXT']
  gistname = "snippet" << "." << get_extension
else
  selection = STDIN.read
  gistname = ENV['TM_FILEPATH'] ? ENV['TM_FILEPATH'].split('/')[-1] : "file" << "." << get_extension
end

if url = Gist.write(gistname, selection, ARGV[0] == "private" ? true : false)
  puts "Created gist at #{url}. URL copied to clipboard."
end