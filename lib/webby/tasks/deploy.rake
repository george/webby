
require 'rake/contrib/sshpublisher'

namespace :deploy do

  desc 'Deploy to the server using rsync'
  task :rsync do
    cmd = "rsync #{SITE.rsync_args.join(' ')} "
    cmd << "#{SITE.output_dir}/ #{SITE.user}@#{SITE.host}:#{SITE.remote_dir}"
    sh cmd
  end

  desc 'Deploy to the server using ssh'
  task :ssh do
    Rake::SshDirPublisher.new(
        "#{SITE.user}@#{SITE.host}", SITE.remote_dir, SITE.output_dir
    ).upload
  end
  
  desc 'Deploy to the server using ssh over a custom port (SITE.ssh_port)'
  task :ssh_custom do
    sh %{scp -rq -P #{SITE.ssh_port} #{SITE.output_dir}/* #{SITE.user}@#{SITE.host}:#{SITE.remote_dir}}
  end

end  # deploy

# EOF
