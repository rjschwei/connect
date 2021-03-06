# From: https://stackoverflow.com/a/44275447
# Usage:
# it 'exits with code 42' do
#   expect { exit 42 }.to exit_with_code(42)
# end

RSpec::Matchers.define :exit_with_code do |exp_code|
  actual = nil
  match do |block|
    begin
      block.call
    rescue SystemExit => e
      actual = e.status
    end
    actual and actual == exp_code
  end
  failure_message do |_block|
    "expected block to call exit(#{exp_code}) but exit" +
        (actual.nil? ? ' not called' : "(#{actual}) was called")
  end
  failure_message_when_negated do |_block|
    "expected block not to call exit(#{exp_code})"
  end
  description do
    "expect block to call exit(#{exp_code})"
  end
  supports_block_expectations
end
