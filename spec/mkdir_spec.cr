require "./spec_helper"

describe Sundial::Applets::Mkdir do
  describe ".main" do
    it "creates a directory given a path and no flags" do
      root = File.tempname("sundial-space")
      Dir.mkdir(root)

      path = File.join(root, "testdir")

      ctx = Sundial::Context.new(
        argv: [path],
      )

      exit_code = Sundial::Applets::Mkdir.main(ctx)

      Dir.exists?(path).should be_true
      exit_code.should eq(0)

      Dir.delete(path)
      Dir.delete(root)
    end

    it "creates a directory given and it's parents given a path and the '-p' flag" do
      root = File.tempname("sundial-space")
      Dir.mkdir(root)

      path = File.join(root, "testparent/testdir")

      ctx = Sundial::Context.new(
        argv: ["-p", path],
      )

      exit_code = Sundial::Applets::Mkdir.main(ctx)

      Dir.exists?(path).should be_true
      exit_code.should eq(0)

      Dir.delete(path)
      Dir.delete(root + "testparent")
      Dir.delete(root)
    end

    it "creates a directory given and sets it's mode given a path and the '-m' flag" do
      root = File.tempname("sundial-space")
      Dir.mkdir(root)

      path = File.join(root, "testdir")

      ctx = Sundial::Context.new(
        argv: ["-m 755", path],
      )

      exit_code = Sundial::Applets::Mkdir.main(ctx)

      Dir.exists?(path).should be_true
      File.info(path).permissions.should eq(0o755)
      exit_code.should eq(0)

      Dir.delete(path)
      Dir.delete(root)
    end
  end
end
