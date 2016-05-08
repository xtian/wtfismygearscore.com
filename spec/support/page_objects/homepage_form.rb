class HomepageForm
  include Capybara::DSL

  def fill_region(value)
    select value, from: 'Region'
  end

  def fill_realm(value)
    fill_in 'Realm', with: value
  end

  def fill_name(value)
    fill_in 'Character', with: value
  end

  def submit
    click_on 'Score Me!'
  end
end
