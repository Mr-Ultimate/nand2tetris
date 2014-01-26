Then(/^the program aborts with "(.*?)"$/) do |error_message|
  step "the stderr should contain \"#{error_message}\""
  step 'the exit status should be 1'
end
