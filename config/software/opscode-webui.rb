name "opscode-webui"
default_version "pc-rel-3.6.7"

dependency 'ruby'
dependency 'bundler'
dependency 'libxml2'
dependency 'libxslt'
dependency 'curl'
dependency 'rsync'

source :git => "git@github.com:opscode/opscode-webui"

bundle_path = "#{install_dir}/embedded/service/gem"

relative_path "opscode-webui"

build do
  bundle "install --without integration_test test dev hosted_chef --path=/opt/opscode/embedded/service/gem"
  command "mkdir -p #{install_dir}/embedded/service/opscode-webui"
  command "#{install_dir}/embedded/bin/rsync -a --delete --delete-excluded --exclude=.git/*** --exclude=.gitignore --exclude=mockups/*** ./ #{install_dir}/embedded/service/opscode-webui/"
  command "find #{bundle_path} -type d -name .git | xargs rm -rf"
end
