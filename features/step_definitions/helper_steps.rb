Then /^"([^"]*)" should be a link to "([^"]*)"$/ do |locator, link|
  assert has_link?(locator, {:href => link})
end
