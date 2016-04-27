#--
# Copyright:: Copyright 2016 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef
  class Decorator < BasicObject

    # FIXME: dup

    def nil?
      __getobj__.nil?
    end

    def ==(obj)
      __getobj__ == obj
    end

    def eql?(obj)
      __getobj__.eql?(obj)
    end

    def is_a?(klass)
      __getobj__.is_a?(klass) || super
    end

    def kind_of?(klass)
      __getobj__.kind_of?(klass) || super
    end

    def __getobj__
      @__obj__
    end

    def __setobj__(obj)
      @__obj__ = obj
    end

    # method_missing handler, this is going to be slow and we deliberately
    # do not define_method here so that the object being wrapped is allowed
    # to change its class.
    def method_missing(method, *args, &block)
      if __getobj__.respond_to?(method, false)
        __getobj__.public_send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      __getobj__.respond_to?(method, false) || super
    end
  end
end
