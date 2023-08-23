https://habr.com/ru/companies/timeweb/articles/589675/
https://serveradmin.ru/gitlab-container-registry-za-nginx-reverse-proxy/

# cat /etc/gitlab/gitlab.rb
registry_external_url 'https://registry.example.com'
gitlab_rails['registry_enabled'] = true
registry['enable'] = true
registry_nginx['enable'] = true
registry_nginx['proxy_set_headers'] = {
  "Host" => "$http_host",
  "X-Real-IP" => "$remote_addr",
  "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
  "X-Forwarded-Proto" => "https",
  "X-Forwarded-Ssl" => "on"
}
registry_nginx['listen_port'] = 8889
registry_nginx['listen_https'] = false

# юзар, вроде, этот
registry_external_url 'https://rg.serveradmin.ru'
gitlab_rails['registry_enabled'] = true
registry['enable'] = true
registry_nginx['enable'] = true
registry_nginx['proxy_set_headers'] = {
 "Host" => "$http_host",
 "X-Real-IP" => "$remote_addr",
 "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
 "X-Forwarded-Proto" => "https",
 "X-Forwarded-Ssl" => "on"
 }
registry_nginx['listen_port'] = 80
registry_nginx['listen_https'] = false

gitlab-ctl reconfigure
nginx -t
nginx -s reload
