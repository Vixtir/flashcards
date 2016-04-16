# Копирующиеся файлы и директории (между деплоями)
set :repo_url,        'git@github.com:Vixtir/flashcards.git'
set :application,     'flashcards'
set :user,            'paul'

set :brnch, 'master'

set :deploy_to, '/home/paul/applications/flashcards'

set :log_level, :info
# Копирующиеся файлы и директории (между деплоями)
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}


# А это рекомендуют добавить для приложений, использующих ActiveRecord
set :puma_init_active_record, true