require 'aws-sdk'
require 'poller/core_ext'
require 'poller/message'
require 'poller/queue'
require 'poller/worker'
require 'poller/environment_loader'
require 'poller/logging'
require 'poller/cli'

module Poller
  @worker_registry = {}
  @worker_class_registry = {}
  @options = {
    aws: {}
  }

  module_function

  def options
    @options
  end

  def logger
    Poller::Logging.logger
  end

  def worker_class_registry
    @worker_class_registry
  end

  def worker_registry
    @worker_registry
  end

  def queues
    @worker_registry.keys
  end

  def fetcher(queue)
    Celluloid::Actor["fetcher_#{queue}".to_sym]
  end

  def set_fetcher(queue, val)
    Celluloid::Actor["fetcher_#{queue}".to_sym] = val
  end

  def processor_pool(queue)
    Celluloid::Actor["processor_pool_#{queue}".to_sym]
  end

  def set_processor_pool(queue, val)
    Celluloid::Actor["processor_pool_#{queue}".to_sym] = val
  end

  def manager
    Celluloid::Actor[:manager]
  end

  def set_manager(val)
    Celluloid::Actor[:manager] = val
  end

  def timer
    Celluloid::Actor[:timer]
  end

  def set_timer(val)
    Celluloid::Actor[:timer] = val
  end

  def default_options
    {
      auto_visibility_timeout: false,
      concurrency: 1,
      auto_delete: false,
      batch: false
    }
  end
end
