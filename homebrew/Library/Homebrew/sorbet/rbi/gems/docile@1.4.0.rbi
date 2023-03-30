# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `docile` gem.
# Please instead update this file by running `bin/tapioca gem docile`.

# typed: true

module Docile
  extend ::Docile::Execution

  private

  def dsl_eval(dsl, *args, &block); end
  def dsl_eval_immutable(dsl, *args, &block); end
  def dsl_eval_with_block_return(dsl, *args, &block); end

  class << self
    def dsl_eval(dsl, *args, &block); end
    def dsl_eval_immutable(dsl, *args, &block); end
    def dsl_eval_with_block_return(dsl, *args, &block); end
  end
end

module Docile::BacktraceFilter
  def backtrace; end
  def backtrace_locations; end
end

Docile::BacktraceFilter::FILTER_PATTERN = T.let(T.unsafe(nil), Regexp)

class Docile::ChainingFallbackContextProxy < ::Docile::FallbackContextProxy
  def method_missing(method, *args, &block); end
end

module Docile::Execution
  private

  def exec_in_proxy_context(dsl, proxy_type, *args, &block); end

  class << self
    def exec_in_proxy_context(dsl, proxy_type, *args, &block); end
  end
end

class Docile::FallbackContextProxy
  def initialize(receiver, fallback); end

  def instance_variables; end
  def method_missing(method, *args, &block); end
end

Docile::FallbackContextProxy::NON_FALLBACK_METHODS = T.let(T.unsafe(nil), Set)
Docile::FallbackContextProxy::NON_PROXIED_INSTANCE_VARIABLES = T.let(T.unsafe(nil), Set)
Docile::FallbackContextProxy::NON_PROXIED_METHODS = T.let(T.unsafe(nil), Set)
Docile::VERSION = T.let(T.unsafe(nil), String)
