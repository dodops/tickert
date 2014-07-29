module CapybaraHelpers
  def assert_no_link_for(text)
    expect(page).to_not(have_css("a", :text => text), "Expect not to see #{text.inspect} link, but did.")
  end

  def assert_link_for(text)
    expect(page).to(have_css("a", :text => text), "Expect to see the #{text.inspect} link, but did not.")
  end
end

RSpec.configure { |c| c.include CapybaraHelpers, :type => :feature}
