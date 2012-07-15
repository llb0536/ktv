# -*- coding: utf-8-*-
Quora::Application.routes.draw do

  constraints(ApiSubdomain) do
    get 'apidoc' => 'apidoc#index'
    get 'apidoc/:page' => 'apidoc#show_page'
    get 'current_user' => 'api#get_current_user'
    scope :module => 'api' do
      root :to =>  "home#index"
      get 'doing' => 'home#doing'
      get 'search' => 'home#search'
      resources :asks do
        member do
          post 'answer'
          post 'comment'
          get 'sugg'
          get 'logs'
        end
      end
      resources :answers
      resources :topics do
        member do
          get 'suggest_topics'
          get 'suggest_experts'
        end
      end
      resources :users do
        member do
          get "suggestions"
          get 'asked'
          get 'answered'
          get 'asked_to'
          get 'comments'
          get 'following'
          get 'followed'
          post 'update_avatar'
          post 'user_update_info' => 'users#update_avatar'
          post 'follow_user'
          post 'follow_ask'
          post 'follow_topic'
        end
      end

    end
    scope 'cpanel' do
      root :to => 'api_cpanel#index',:as=>:api_cpanel_root
      resources :clients
      resources :accesses
    end
    namespace :oauth do
      get    "authorization" => "oauth_authorize#show", defaults: { format: "html" }
      post   "authorization" => "oauth_authorize#create", defaults: { format: "html" }
      delete "authorization" => "oauth_authorize#destroy", defaults: { format: "html" }
      delete "token/:id" => "oauth_token#destroy", defaults: { format: "json" }
      post   "token" => "oauth_token#create", defaults: { format: "json" }
    end
  end
  constraints(ApiSubdomainNOT) do
    match '/mobile'=>'home#mobile'
    get '/under_verification' => 'home#under_verification'
    get '/frozen_page' => 'home#frozen_page'
    if 'development'==Rails.env
      get '/home/tmp'
    end
  
    if 'test'==Rails.env
      get '/test_login'=>'application#test_login'
      get '/test_logout'=>'application#test_logout'
    end

    get '/refresh_sugg' => 'home#refresh_sugg'
    get '/refresh_sugg_ex' => 'home#refresh_sugg_ex'  
    post '/ajax/seg'=>'ajax#seg'
    get '/bugtrack'=>'application#bugtrack'
    get '/agreement'=>'home#agreement'
    get "traverse/index",as:'traverse'
    post "traverse/index",as:'traverse'
    get "traverse/asks_from",as:'asks_from'
    get 'home/agreement'
  
    get 'nb/*file' =>'application#nb'
    root :to => "home#index"
    get '/root'=>'home#index'
    match '/topics_follow' => 'topics#fol'
    post '/topics_unfollow'=>'topics#unfol'  
    get '/zero_asks' => 'asks#index'
  
    scope 'mobile',:as=>'mobile' do
      controller "mobile" do
        get 'noticepage'
        get 'login'
        get 'register'
        get 'search'
        get 'notifications'
      end
    end
  
    scope 'embed',:as=>'embed' do
      controller "embed" do
        get '/search' => 'embed#search',:as=>:search
        get '/mail_icon'
      end
    end
  
    match "/uploads/*path" => "gridfs#serve"
    match "/update_in_place" => "home#update_in_place"
    #match "/muted" => "home#muted"
    match "/newbie" => "home#newbie"
    match "/followed" => "home#followed"
    match "/recommended" => "home#recommended"
    match "/mark_all_notifies_as_read" => "home#mark_all_notifies_as_read"
    match "/mark_notifies_as_read" => "home#mark_notifies_as_read"

    match "/mute_suggest_item" => "home#mute_suggest_item"
    match "/report" => "home#report"
    #match "/about" => "home#about"
    match "/doing" => "logs#index"


    get '/users/sign_in', :to => "application#require_user" ,:as=>'new_user_session'
  
    # pan>
    # 以下routes屏蔽掉原有认证逻辑----
    get    '/logout', :to => "application#require_user", as:'logout'
    get    '/users/sign_in', :to => "application#require_user",as:'new_user_session'
    post   '/users/sign_in', :to => "application#require_user",as:'user_session'
    get    '/users/sign_out', :to => "application#require_user",as:'destroy_user_session'
    post   '/users/password', :to => "application#require_user",as:'user_password'
    get    '/users/password/new', :to => "application#require_user",as:'new_user_password'
    get    '/users/password/edit', :to => "application#require_user",as:'edit_user_password'
    put    '/users/password', :to => "application#require_user"
    get    '/users/cancel', :to => "application#require_user",as:'cancel_user_registration'
    post   '/users', :to => "application#require_user",as:'user_registration'
    get    '/users/sign_up', :to => "application#require_user",as:'new_user_registration'
    delete '/users', :to => "application#require_user"
    #-----------------------
    devise_for :users,  :controllers => { :registrations => "registrations" } do
      get "/register", :to => "registrations#new",as:'register'
      get "/login", :to => "devise/sessions#new",as:'login'
      get '/logout', :to => "application#require_user", as:'logout'
    end
    #TODO-END
  
    resources :users do
      member do
        get "answered"
        get "asked"
        get "asked_to"
        get "follow"
        get "unfollow"
        get "followers"
        get "following"
        get "following_topics"
        # get "following_asks"
      end
    end
    match "auth/:provider/callback", :to => "users#auth_callback"  

    resources :search do
      collection do
        get "all"
        get "topics"
        get "asks"
        get "users"
      end
    end
  
    resources :asks do
      member do
        get "spam"
        get "follow"
        get "unfollow"
        get "mute"
        get "unmute"
        post "answer"
        post "update_topic"
        get "update_topic"
        get "redirect"
        get "invite_to_answer"
        get "share"
        post "share"
      end
    end

    resources :answers do
      member do
        get "vote"
        get "spam"
        get "thank"
      end
    end
    resources :comments 

    resources :topics do #, :constraints => { :id => /[a-zA-Z\w\s\.%\-_]+/ }
      member do
        get "follow"
        get "unfollow"
      end
    end
    resources :logs
    resources :inbox
  
    namespace :cpanel do
      post '/toggle' => 'asks#toggle'
      root :to =>  "home#index"
      resources :scopes
      resources :clients do
        put :block, on: :member
        put :unblock, on: :member
      end
      resources :accesses do
        put :block, on: :member
        put :unblock, on: :member
      end
      get '/asks_un' => 'asks#index_un'

      get '/asks_un2' => 'asks#index_un2'
      get '/answers_un2' => 'answers#index_un2'
      get '/comments_un2' => 'comments#index_un2'
            
      post '/asks_un2all' => 'asks#index_un2all'
      post '/answers_un2all' => 'answers#index_un2all'
      post '/comments_un2all' => 'comments#index_un2all'      
      
      resources :users
      resources :asks do
        post :verify, on: :member
      end
      resources :answers do
        post :verify, on: :member
      end
      resources :topics
      resources :comments do
        post :verify, on: :member
      end
      resources :report_spams
      resources :notices
      get '/oauth' => 'oauth#index',:as=>'oauth'
      get '/stats' => 'stats#index',:as=>'stats'
      match '/kpi' => 'stats#kpi',:as=>'kpi'
      post '/stats/uv' => 'stats#uv'
      match "/stats/hot_asks" => "stats#hot_asks"
      match "/stats/hot_topics" => "stats#hot_topics"
      match "/stats/refresh_asks" => "stats#refresh_asks"
      match "/stats/refresh_topics" => "stats#refresh_topics"
      post '/stats/edit_hot_asks' => 'stats#edit_hot_asks'
      post '/stats/edit_hot_topics' => 'stats#edit_hot_topics'
      get '/autofollow' => 'autofollow#index',:as=>'autofollow'
      post '/autofollow' => 'autofollow#index_pos',:as=>'autofollow_pos'
      delete '/autofollow' => 'autofollow#index_del',:as=>'autofollow_del'
      match '/autofollow/verify' => 'autofollow#verify'
      match '/autofollow/advertise' => 'autofollow#advertise'
      match '/autofollow/ban_word' => 'autofollow#ban_word'
      match '/autofollow/deleted' => 'autofollow#deleted'
      post '/deal_asks' => 'asks#deal_asks'
      post '/deal_answers' => 'answers#deal_answers'
      post '/deal_comments' => 'comments#deal_comments'
      post '/deal_topics' => 'topics#deal_topics'
      post '/deal_report' => 'report_spams#deal_report'
      post '/deal_verify' => 'autofollow#deal_verify'
      post '/deal_advertise' => 'autofollow#deal_advertise'
      post '/deal_word' => 'autofollow#deal_word'
      post '/deal_deleted' => 'autofollow#deal_deleted'
      post '/autofollow/edit_verify' => 'autofollow#edit_verify'
      post '/autofollow/edit_ask_advertise' => 'autofollow#edit_ask_advertise'
      post '/autofollow/edit_ac_advertise' => 'autofollow#edit_ac_advertise'
      post '/autofollow/create_ban_word' => 'autofollow#create_ban_word'
      post '/autofollow/import_ban_word' => 'autofollow#import_ban_word'
      match "/welcome" => "users#welcome"
      match "/user/avatar_admin"=>"users#avatar_admin"
      match "/user/avatar_del"=>"users#avatar_del"
      match "/users/:id/edit_admin" => "users#edit_admin"
      match "/users/:id/update_admin" => "users#update_admin"
      match "/notices/create" => "notices#create"
    end

    mount Resque::Server, :at => "/cpanel/resque"
    get "/*identifier" => "home#general_show"
  end
end
