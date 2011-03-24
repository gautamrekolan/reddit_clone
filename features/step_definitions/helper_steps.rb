Given /^the current time is "([^"]*)"$/ do |time|
  Timecop.freeze Time.parse(time)
end

Then /^"([^"]*)" should be a link to "([^"]*)"$/ do |locator, link|
  assert has_link?(locator, {:href => link})
end

Then /^(?:|page )should have "([^"]*)"(?: within "([^"]*)")?$/ do |selector, parent_selector|
  with_scope(parent_selector) do
    if page.respond_to? :should
      page.should have_selector(selector)
    else
      assert page.have_selector?(selector)
    end
  end
end