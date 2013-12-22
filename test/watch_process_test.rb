require 'test/unit'
require 'rerun_task'

class WatchProcessTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @process_file = RerunTask::ProcessFile.new("#{RerunTask::CONFIG['pid_dir']}/rerun_task/pids")
    begin
      FileUtils.rm(@process_file.path)
    rescue
    end
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_should_start
    #assert_equal("/tmp/rerun_task/pids/watch_process_test.rb.pid", @process_file.path)
    @w = RerunTask::WatchProcess.new("my_test")
    assert_equal(false, File.exists?(@process_file.path))
    @w.start
    assert_equal(true, File.exists?(@process_file.path))
    @w.finished
    assert_equal(false, File.exists?(@process_file.path))

    @w = RerunTask::WatchProcess.new("my_test")
    @w.start
    @w2 = RerunTask::WatchProcess.new("my_test")
    assert_raise_kind_of(RuntimeError) do
      @w2.start
    end
    @w.finished
  end

  def test_list_pids
    path = "#{RerunTask::CONFIG['pid_dir']}/rerun_task/pids"
    filename = "#{path}/test_example_task.rb.pid"
    FileUtils.rm(filename) if File.exists?(filename)
    File.open(filename, 'w') do |f|
      f.write("1234\ntest_example_task.rb")
    end

    unfinished = RerunTask::Pids.unfinished
    assert_equal(1, unfinished.size)
    assert_equal('test_example_task.rb', unfinished.first.process_name)
  end
end