
namespace :set do
  task :init => ["tmp:clear", "log:clear","db:drop","db:create","db:migrate","db:seed"]
end