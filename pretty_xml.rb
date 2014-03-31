#!/Users/davidtakahashi/.rvm/rubies/ruby-1.9.3-p392/bin/ruby

require 'rexml/document'
doc = REXML::Document.new(File.read(ARGV[0]))
pretty = REXML::Formatters::Pretty.new(4, true)
pretty.send(:write_document, doc, result='')
lines = []

flag = false
result.each_line do |line|
  line = line.chomp
  if line =~ /^\s*<[^\/]/
    lines << line
  elsif line =~ /^\s*<\//
    if flag
      lines.last << line.sub(/^\s+/, '')
      flag = false
    else
      lines << line
    end
  else
    lines.last << line.sub(/^\s+/, '')
    flag = true
  end 
end
lines.each{|line| puts line}
      
