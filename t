[1mdiff --git a/app/assets/stylesheets/twitterApp.css b/app/assets/stylesheets/twitterApp.css[m
[1mindex 31f8e83..56781d3 100755[m
[1m--- a/app/assets/stylesheets/twitterApp.css[m
[1m+++ b/app/assets/stylesheets/twitterApp.css[m
[36m@@ -101,7 +101,9 @@[m [ma:hover{[m
       text-align: left;[m
     }[m
     #icons{[m
[31m-      font-size: 14px;[m
[32m+[m[41m       [m
[32m+[m[32m        font-size: 14px !important;[m
[32m+[m[41m      [m
       display:inline-block;[m
       [m
     }[m
[1mdiff --git a/app/controllers/comments_controller.rb b/app/controllers/comments_controller.rb[m
[1mindex 6a6823e..d04081f 100644[m
[1m--- a/app/controllers/comments_controller.rb[m
[1m+++ b/app/controllers/comments_controller.rb[m
[36m@@ -18,7 +18,7 @@[m [mclass CommentsController < ApplicationController[m
 [m
     def destroy[m
       @comment.destroy[m
[31m-      redirect_to user_path(@tweet)[m
[32m+[m[32m      redirect_to tweet_path(@tweet)[m
     end[m
 [m
   def edit[m
[36m@@ -26,8 +26,8 @@[m [mclass CommentsController < ApplicationController[m
   end[m
 [m
   def update[m
[31m-    if @comment.update(params[:content].permit(content))[m
[31m-      redirect_to user_path(@tweet)[m
[32m+[m[32m    if @comment.update(params[:comment].permit(:content))[m
[32m+[m[32m      redirect_to tweet_path(@tweet)[m
     else[m
       render 'edit'[m
     end[m
[36m@@ -47,7 +47,7 @@[m [mclass CommentsController < ApplicationController[m
   #end[m
 [m
   def find_comment[m
[31m-    @comment = @tweet.comments.find(params[:id])[m
[32m+[m[32m    @comment = @tweet.comments.find(params[:id])[m[41m [m
   end[m
 [m
   def comment_owner[m
[1mdiff --git a/app/controllers/tweets_controller.rb b/app/controllers/tweets_controller.rb[m
[1mindex c3453c1..4ed75d3 100755[m
[1m--- a/app/controllers/tweets_controller.rb[m
[1m+++ b/app/controllers/tweets_controller.rb[m
[36m@@ -9,8 +9,9 @@[m [mclass TweetsController < ApplicationController[m
 [m
   def show[m
     @tweet = Tweet.find(params[:id])[m
[31m-    @comments = Comment.where(tweet_id: @tweet).order("created_at DESC")[m
[32m+[m[32m    @comments = @tweet.comments.order("created_at DESC")[m
     @comment = Comment.new[m
[32m+[m[41m    [m
   end[m
 [m
   def new[m
[1mdiff --git a/app/controllers/users_controller.rb b/app/controllers/users_controller.rb[m
[1mindex 4f61c25..18d191b 100755[m
[1m--- a/app/controllers/users_controller.rb[m
[1m+++ b/app/controllers/users_controller.rb[m
[36m@@ -1,5 +1,7 @@[m
 class UsersController < ApplicationController[m
 [m
[32m+[m[32m  before_action :getUser[m
[32m+[m
   def home[m
   end[m
 [m
[36m@@ -7,7 +9,17 @@[m [mclass UsersController < ApplicationController[m
   end[m
 [m
   def show[m
[32m+[m[32m    @tweets = @user.tweets.all[m
[32m+[m[32m  end[m
[32m+[m
[32m+[m[32m  private[m
 [m
[32m+[m[32m  def getUser[m
[32m+[m[32m    if params[:id] == nil[m
[32m+[m[32m      @user = User.find(current_user.id)[m
[32m+[m[32m    else[m
[32m+[m[32m      @user = User.find(params[:id])[m
[32m+[m[32m    end[m
   end[m
 [m
 end[m
[1mdiff --git a/app/views/comments/_comment.html.erb b/app/views/comments/_comment.html.erb[m
[1mindex 600dec1..7650cf8 100644[m
[1m--- a/app/views/comments/_comment.html.erb[m
[1m+++ b/app/views/comments/_comment.html.erb[m
[36m@@ -1,5 +1,5 @@[m
 [m
[31m-<h2> This post has <%= pluralize(@comments.count, "replies") %></h2>[m
[32m+[m
   <p><b>Commented by: <%= comment.user.email %></b></p>[m
   <p><%= comment.content %></p>[m
 [m
[1mdiff --git a/app/views/tweets/new.html.erb b/app/views/tweets/new.html.erb[m
[1mindex 6af941e..8639d87 100755[m
[1m--- a/app/views/tweets/new.html.erb[m
[1m+++ b/app/views/tweets/new.html.erb[m
[36m@@ -7,23 +7,16 @@[m
 [m
       <div class="form-group">[m
         <%= f.label   :tweet , class: "control-label col-sm-2"%>[m
[31m-<<<<<<< HEAD[m
[31m-        <div class="col-sm-8 col-sm-offset-2"><%= f.text_area :text , class: "form-control"  %></div>[m
[31m-=======[m
[32m+[m
         <div class="col-sm-8 col-sm-offset-2"><%= f.text_area :text, class: "form-control"  %><p>You have <span id="count"> </span> characters remaining </p></div>[m
         [m
[31m->>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8[m
       </div>[m
 [m
       <%= f.hidden_field :user_id, :value => current_user.id %>[m
 [m
       <div class="buttons">[m
 [m
[31m-<<<<<<< HEAD[m
       <%= link_to 'Back', user_path(id: current_user.id), class: "btn btn-primary pull-left" %><br>  [m
[31m-=======[m
[31m-      <%= link_to 'Back', user_path(id: current_user.id), class: "btn btn-primary pull-left" %> [m
[31m->>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8[m
 [m
       <%= f.submit "Create" , class: "btn btn-success pull-right" %>[m
         [m
[36m@@ -36,14 +29,7 @@[m
 [m
 <%= render 'layouts/textarea' %>[m
 [m
[31m-<<<<<<< HEAD[m
[31m-  <script>[m
[31m-[m
[31m-        var form = document.getElementById("new_tweet");[m
[31m-        form.className += " form-horizontal";[m
 [m
[31m-  </script>[m
[31m-=======[m
   <!-- form css -->[m
   <script>[m
     var form = document.getElementsByTagName("form");[m
[36m@@ -51,4 +37,4 @@[m
   </script>[m
 [m
 <%= render "tweets/checktweet" %>[m
[31m->>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8[m
[41m+[m
[1mdiff --git a/app/views/tweets/show.html.erb b/app/views/tweets/show.html.erb[m
[1mindex fb0c107..0d43903 100755[m
[1m--- a/app/views/tweets/show.html.erb[m
[1m+++ b/app/views/tweets/show.html.erb[m
[36m@@ -1,10 +1,14 @@[m
 <h1> tweet showpage</h1>[m
 [m
[32m+[m[32m<%= link_to 'Back', user_path(id: @tweet.user_id), class: "btn btn-primary" %><br>[m[41m  [m
[32m+[m
 <%= @tweet.text %>[m
[32m+[m[32m<h3> This tweet has <%= pluralize(@comments.count, "replies") %></h3>[m
 [m
[32m+[m[32m<div class="pageBody">[m
 [m
 <% if @comments!=nil %>[m
[31m-  <h2><%= @comments.size %> Comment(s) </h2>[m
[32m+[m[41m [m
       <% @comments.each do |comment| %>[m
         <%= render comment %>[m
         <% end %>[m
[36m@@ -13,5 +17,8 @@[m
 <% end %>[m
 [m
        <div id="commentForm">[m
[31m-[m
[32m+[m[32m          <%= render 'comments/form' %>[m
        </div>[m
[32m+[m
[32m+[m
[32m+[m[32m</div>[m
[1mdiff --git a/app/views/users/home.html.erb b/app/views/users/home.html.erb[m
[1mindex 024c129..d5ff3c5 100755[m
[1m--- a/app/views/users/home.html.erb[m
[1m+++ b/app/views/users/home.html.erb[m
[36m@@ -1,11 +1,9 @@[m
 <h1> User Homepage123 </h1>[m
 [m
 [m
[31m-<<<<<<< HEAD[m
[32m+[m
 <%= link_to 'Tweet' ,new_tweet_path(user_id: current_user.id) %>[m
[31m-=======[m
[31m-<%= link_to "Profile", user_path(id: @user.id) %>[m
 [m
[32m+[m[32m<%= link_to "Profile", user_path(id: @user.id) %>[m
 [m
 [m
[31m->>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8[m
[1mdiff --git a/app/views/users/show.html.erb b/app/views/users/show.html.erb[m
[1mindex 5b93367..21f7437 100755[m
[1m--- a/app/views/users/show.html.erb[m
[1m+++ b/app/views/users/show.html.erb[m
[36m@@ -1,11 +1,5 @@[m
[31m-<<<<<<< HEAD[m
[31m-<h1>User Show Page1234</h1>[m
 [m
 [m
[31m-<h1> tweet showpage</h1>[m
[31m-<%= render 'comments/form' %>[m
[31m-=======[m
[31m-[m
 <div class="pageHeader">[m
 [m
     <h1><%= @user.name %></h1>[m
[36m@@ -25,34 +19,40 @@[m
 [m
       <% if !(@tweets.empty?) %>[m
         <% @tweets.each do |tweet| %>[m
[31m-          <div class="tweet panel panel-info">[m
[31m-            [m
[31m-            <div class="panel-heading row">[m
[31m-[m
[31m-            [m
[31m-              <div class="panel-title">[m
[31m-                <h3 class="col-sm-12">[m
[31m-                  <span id="name"><%= @user.name %></span>[m
[31m-                  <span id="timeAgo"> [m
[31m-                    <!-- If user updated tweet, displays updated_at time instead. -->[m
[31m-                      <%= (tweet.updated_at > tweet.created_at) ? time_ago_in_words(tweet.updated_at) : time_ago_in_words(tweet.created_at)  %>[m
[31m-                       ago [m
[31m-                      [m
[31m-                  </span> [m
[31m-                  <span id="icons" class="pull-right">[m
[31m-                    <%= link_to edit_tweet_path(id: tweet.id) do %><i class="fa fa-pencil-square fa-2x" aria-hidden="true"></i> <% end %>[m
[31m-                      <%= link_to tweet_path(id: tweet.id), method: :delete do %><i class="fa fa-trash fa-2x" aria-hidden="true"></i> <% end %> [m
[31m-                  </span>[m
[31m-                </h3>[m
[32m+[m[41m           [m
[32m+[m[32m              <div class="tweet panel panel-info">[m
[32m+[m[41m               [m
                 [m
[31m-              </div>[m
[32m+[m[32m                <div class="panel-heading row">[m
[32m+[m
[32m+[m[41m                 [m
[32m+[m[32m                  <div class="panel-title">[m
[32m+[m[32m                    <h3 class="col-sm-12">[m
[32m+[m[32m                      <%= link_to tweet_path(id:tweet.id) do %> <span id="name"><%= @user.name %></span>   <% end %>[m
[32m+[m[32m                      <span id="timeAgo">[m[41m [m
[32m+[m[32m                        <!-- If user updated tweet, displays updated_at time instead. -->[m
[32m+[m[32m                          <%= (tweet.updated_at > tweet.created_at) ? time_ago_in_words(tweet.updated_at) : time_ago_in_words(tweet.created_at)  %>[m
[32m+[m[32m                           ago[m[41m [m
[32m+[m[41m                          [m
[32m+[m[32m                      </span>[m[41m [m
[32m+[m[32m                      <span id="icons" class="pull-right">[m
[32m+[m[32m                        <%= link_to edit_tweet_path(id: tweet.id) do %><i class="fa fa-pencil-square fa-2x" aria-hidden="true"></i> <% end %>[m
[32m+[m[32m                          <%= link_to tweet_path(id: tweet.id), method: :delete do %><i class="fa fa-trash fa-2x" aria-hidden="true"></i> <% end %>[m[41m [m
[32m+[m[32m                      </span>[m
[32m+[m[32m                    </h3>[m
[32m+[m[41m                    [m
[32m+[m[32m                  </div>[m
[32m+[m[41m                 [m
[32m+[m[32m                </div>[m
[32m+[m[41m             [m
               [m
[31m-          </div>[m
[31m-          <div class="panel-body">[m
[31m-            <p> <%= tweet.text %> </p>[m
[32m+[m[32m                <div class="panel-body">[m
[32m+[m[32m                  <p> <%= tweet.text %> </p>[m
 [m
[31m-          </div>[m
[31m-        </div>[m
[32m+[m[32m                </div>[m
[32m+[m
[32m+[m[32m              </div>[m
[32m+[m[41m            [m
         <% end %>[m
       <% else %>[m
           <div class="tweet">[m
[36m@@ -65,4 +65,4 @@[m
 [m
 </div>[m
 </div>[m
[31m->>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8[m
[41m+[m
[1mdiff --git a/config/routes.rb b/config/routes.rb[m
[1mindex 0b76b08..d810a9e 100755[m
[1m--- a/config/routes.rb[m
[1m+++ b/config/routes.rb[m
[36m@@ -1,24 +1,17 @@[m
 Rails.application.routes.draw do[m
   devise_for :users[m
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html[m
[31m-[m
   resources :users[m
 [m
[31m-<<<<<<< HEAD[m
   resources :tweets do[m
[32m+[m
     resources :comments [m
[32m+[m
   end[m
 [m
   get 'home',to: 'users#home'[m
 [m
   root 'users#index'[m
 [m
[31m-=======[m
[31m-  resources :tweets[m
[31m-  [m
[31m-  get 'home',to: 'users#home'[m
 [m
[31m-  root 'users#show'[m
[31m-  [m
[31m->>>>>>> fcdcc9000a873a916d0f0c52c310e1103c0036c8[m
 end[m
