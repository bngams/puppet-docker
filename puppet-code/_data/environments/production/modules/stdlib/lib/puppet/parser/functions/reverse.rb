# frozen_string_literal: true

#
# reverse.rb
#
module Puppet::Parser::Functions
  newfunction(:reverse, type: :rvalue, doc: <<-DOC
    @summary
      Reverses the order of a string or array.

    @return
      reversed string or array

    > *Note:* that the same can be done with the reverse_each() function in Puppet.
  DOC
  ) do |arguments|
    raise(Puppet::ParseError, "reverse(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.empty?

    value = arguments[0]

    raise(Puppet::ParseError, 'reverse(): Requires either array or string to work with') unless value.is_a?(Array) || value.is_a?(String)

    result = value.reverse

    return result
  end
end

# vim: set ts=2 sw=2 et :
