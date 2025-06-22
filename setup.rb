def must_system(*args)
    system(*args, exception: true)
end

def setup(config)
    file HOME / ".local/bin/lazygit" do
        dir = Pathname.mktmpdir
        must_system("curl ")
    end
end
