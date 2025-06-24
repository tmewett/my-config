require 'pathname'
require 'fileutils'

def must_system(*args)
    system(*args, exception: true)
end

HOME = Pathname.new(ENV['HOME'])

file HOME / ".local/bin/watchexec" do |t|
    dir = Pathname.mktmpdir
    must_system("curl -L https://github.com/watchexec/watchexec/releases/download/v2.3.2/watchexec-2.3.2-x86_64-unknown-linux-musl.tar.xz | tar -C #{dir} -J --strip-components=1 -x")
    (dir / "watchexec").rename(t.name)
    dir.rmtree
end

task :watchexec => [HOME / ".local/bin/watchexec"]
