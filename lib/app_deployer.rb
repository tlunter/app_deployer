require 'active_support/inflector'
require 'singleton'
require 'net/ssh'
require 'erb'
require 'docker'
require 'open3'

require 'app_deployer/core'
require 'app_deployer/cluster'
require 'app_deployer/cluster_instance'
require 'app_deployer/application'
require 'app_deployer/container'
require 'app_deployer/load_balancer'
require 'app_deployer/deploy'

module AppDeployer

  module_function
  def git_sha
    log_line = nil

    Open3.popen3('git log -n1 --pretty=oneline') do |stdin, stdout, stderr, wait_thr|
      log_line = stdout.read.chomp

      wait_thr.join
    end

    if log_line
      log_line.split[0]
    else
      raise 'Could not get the current git sha'
    end
  end
end
