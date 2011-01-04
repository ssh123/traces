<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <%= auto_discovery_link_tag(:atom, {:action => "feed"}) %>
  <%= auto_discovery_link_tag(:rss, {:action => "feed"}) %>
  <%= stylesheet_link_tag "bw" %>
  <%= javascript_include_tag "jquery", "jquery.rails", "application" %>
  <%= csrf_meta_tag %>

  <% if controller.action_name == "new" or controller.action_name == "create"%>
  <title>Creating New Post</title>
  <% else %>

  <% unless @posts.nil? %>
  <title>Traces</title>
  <% else%>

  <% unless @post.nil? %>
  <title><%= @post.first.title %> | Traces</title>
  <% else%>
  <title>Traces</title>
  <% end %>
  <% end %>

  <% end %>
  
  <script type="text/javascript">

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-498639-5']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

  </script>
  
</head>
<body>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>
  <header>
    <h1><%= link_to "Traces", root_url %></h1>
    <section id="colors">
      <ul>
        <li><%= link_to image_tag("feed.png", :size => "36x36", :alt => "Feed"), feed_path %></li>
        <li><%= link_to image_tag("twitter.png", :size => "36x36", :alt => "Twitter"), "http://twitter.com/lainuo" %></li>
      </ul>
    </section>
    <nav>
      <ul>
        <li><%= link_to "Home", root_url %></li>
        <li><%= link_to "About", "http://about.me/lainuo" %></li>
        <% if admin_signed_in? %>
        <li><%= link_to "New", new_post_path %></li>
        <li><%= link_to "Sign Out", destroy_admin_session_path %></li>
        <% else %>
        <li><%= link_to "Sign In", new_admin_session_path %>
        <% end %>
      </ul>
    </nav>
  </header>

  <%= yield %>

  <footer>
    <section id="whatever">
    </section>
    <section id="tools">
      Powered by Heroku and Ruby on Rails
    <section>
  </footer>
</body>
</html>