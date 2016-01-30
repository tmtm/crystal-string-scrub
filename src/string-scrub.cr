class String
  # Returns a new string that invalid byte has been replaced.
  def scrub(repl='?')
    String.build do |str|
      pos = 0
      while pos < bytesize
        size = charsize_at(pos)
        unless size
          str << repl
          pos += 1
          next
        end
        str << byte_slice(pos, size)
        pos += size
      end
    end
  end

  # Returns false if the string contains invalid byte.
  def valid_encoding?
    pos = 0
    while pos < bytesize
      size = charsize_at(pos)
      return false unless size
      pos += size
    end
    true
  end

  # :nodoc:
  def charsize_at(pos)
    return nil unless pos < bytesize
    case c = byte_at(pos)
    when .< 0x80
      size = 1
    when .< 0xc2
      return nil
    when .< 0xe0
      size = 2
    when .< 0xf0
      size = 3
    when .< 0xf8
      size = 4
    else
      return nil
    end
    return nil unless pos + size - 1 < bytesize
    (size - 1).times do |i|
      return nil unless byte_at(pos + i + 1) & 0xc0 == 0x80
    end
    return size
  end
end
