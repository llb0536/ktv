# Be sure to restart your server when you modify this file.

key = (Rails.env.production? ? "_ktv_session" : "_ktv_local_session")
domain = (Rails.env.production? ? ".kejian.tv" : ".kejian.lvh.me")

Quora::Application.config.session_store :cookie_store, 
                                        :key => key,
                                        :domain => domain,
                                        :expire_after => 30.minutes
    
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Quora::Application.config.session_store :active_record_store
