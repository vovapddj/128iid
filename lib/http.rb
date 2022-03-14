# frozen_string_literal: true

module Kenna
  module 128iid
    module Helpers
      module Http
        def http_get(url, headers, max_retries = 5, verify_ssl = true)
          RestClient::Request.execute(
            method: :get,
            url: url,
            headers: headers,
            verify_ssl: verify_ssl
          )
        rescue RestClient::TooManyRequests => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            sleep(15)
            print "Retrying!"
            retry
          end
        rescue RestClient::UnprocessableEntity => e
          log_exception(e)
        rescue RestClient::BadRequest => e
          log_exception(e)
        rescue RestClient::InternalServerError => e
          retries ||= 0
          if retries < max_retries
            retries += 1
            sleep(15)
            print "Retrying!"
            retry
          end
          log_exception(e)
        rescue RestClient::ServerBrokeConnection => e
          log_exception(e)
        rescue RestClient::ExceptionWithResponse => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        rescue RestClient::NotFound => e
          log_exception(e)
        rescue RestClient::Exception => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            sleep(15)
            print "Retrying!"
            retry
          end
        rescue Errno::ECONNREFUSED => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        end

        def http_post(url, headers, payload, max_retries = 5, verify_ssl = true)
          RestClient::Request.execute(
            method: :post,
            url: url,
            payload: payload,
            headers: headers,
            verify_ssl: verify_ssl
          )
        rescue RestClient::TooManyRequests => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        rescue RestClient::UnprocessableEntity => e
          log_exception(e)
        rescue RestClient::BadRequest => e
          log_exception(e)
        rescue RestClient::InternalServerError => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        rescue RestClient::ServerBrokeConnection => e
          log_exception(e)
        rescue RestClient::ExceptionWithResponse => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        rescue RestClient::NotFound => e
          log_exception(e)
        rescue RestClient::Exception => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        rescue Errno::ECONNREFUSED => e
          log_exception(e)
          retries ||= 0
          if retries < max_retries
            retries += 1
            print "Retrying!"
            sleep(15)
            retry
          end
        end

        def log_exception(error)
          print_error "Exception! #{error}"
          return unless log_request?

          print_debug "#{error.response.request.method.upcase}: #{error.response.request.url}"
          print_debug "Request Payload: #{error.response.request.payload}"
          print_debug "Server Response: #{error.response.body}"
        end

        def log_request?
          debug? && running_local?
        end
      end
    end
  end
end
