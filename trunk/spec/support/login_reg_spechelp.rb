# coding: utf-8
def login_user_via_zhilian(email,password)
  within('#inner_login') do
    fill_in 'loginname',with:email
    fill_in 'password',with:password
    click_button 'submit'
  end
end

def login(user,password='123456')
  visit "/test_login?name=#{user.name}&email=#{user.email}&password=#{password}"
end
def logout
  visit "/test_logout"
end

def login_with(loginname,password)
  if page.driver.respond_to?(:basic_auth)
    page.driver.basic_auth(loginname, password)
  elsif page.driver.respond_to?(:basic_authorize)
    page.driver.basic_authorize(loginname, password)
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    page.driver.browser.basic_authorize(loginname, password)
  else
    raise "I don't know how to log in!"
  end
end