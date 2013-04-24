require_relative 'generate'

def usage
  print <<HERE
Missing language name, use like:
  gg (lang)
  gg -l #see suported languages
HERE

end


def run
  if !ARGV[0]
    usage
  elsif ARGV[0] == '-l'
    print_language_names
  else
    print_global
    print_language(ARGV[0])
  end
end
