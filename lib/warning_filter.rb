require 'delegate'

# Filters Ruby warnings from gems out of $stderr when $VERBOSE is enabled

class WarningFilter < DelegateClass(IO)
  def write(line)
    super unless line.strip.empty? || line =~ %r{^.+\/gems\/.+: warning:}
  end
end
