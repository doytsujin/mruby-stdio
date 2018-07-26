$/ = "\n" unless $/

#
# STDOUT
#

class STDOUT
  @@rs = $/
  class << self
    def _putc(c)
      raise "STDOUT._putc not implemented."
    end

    def putc(c)
      c = c.ord if c.is_a?(String)
      _putc(c)
    end

    def print(*args)
      args.each {|o|
        o = o.to_s unless o.is_a?(String)
        o.each_char {|c| putc(c)}
      }
    end

    def puts(*args)
      unless args
        putc @@rs
      else
        args.each {|o|
          o = o.to_s unless o.is_a?(String)
          o << @@rs unless o[-1] == @@rs
          o.each_char {|c| putc(c)}
        }
      end
      nil
    end

    def p(*args)
      unless args
        putc @@rs
      else
        args.each {|o|
          o.inspect.each_char {|c| putc(c)}
          putc @@rs
        }
      end
      args[0]
    end
  end
end

#
# STDERR
#

class STDERR < STDOUT
  class << self
    def _err_putc(c)
      raise "STDERR._putc not implemented."
    end

    def putc(c)
      c = c.ord if c.is_a?(String)
      _err_putc(c)
    end
  end
end

#
# STDIN
#

class STDIN
  @@rs = $/
  class << self
    def _getc
      raise "STDIN._getc not implemented."
    end

    def getc
      c = _getc
      c && c >= 0 ? c.chr : nil
    end

    def gets(*args)
      rs = @@rs
      limit = -1
      case args.size
      when 0
      when 1
        if args[0].is_a?(String)
          rs = args[0]
        elsif args[0].is_a?(Fixnum)
          limit = args[0]
        else
          raise TypeError.new
        end
      when 2
        rs, limit = args
      else
        raise ArgumentError.new
      end

      str = ''
      loop {
        until c = getc; end
        str << c
        break if c == rs
        break if limit > 0 && str.length >= limit
      }
      $_ = str.length > 0 ? str : nil
    end

    def readline(*args)
      str = gets(args)
      raise EOFError.new unless str
      str
    end
  end
end

$stdin = STDIN
$stdout = STDOUT
$stderr = STDERR

module Kernel
  def getc
    $stdin.getc if $stdin
  end

  def gets(*args)
    $stdin.gets(*args) if $stdin
  end

  def putc(c)
    $stdout.putc(c) if $stdout
  end

  def print(*args)
    $stdout.print(*args) if $stdout
  end

  def puts(*args)
    $stdout.puts(*args) if $stdout
  end

  def p(*args)
    $stdout.puts(*args) if $stdout
  end
end
