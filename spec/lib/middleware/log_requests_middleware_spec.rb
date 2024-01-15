require 'rails_helper'
require 'json'
require 'rack'
require 'middleware/log_requests_middleware.rb'

RSpec.describe LogRequestsMiddleware do
  let(:success) { { data: 'success' }.to_json }
  let(:app) { ->(env) { [200, { 'Content-Type' => 'application/json' }, [ success ]] } }
  let(:env) { ::Rack::MockRequest.env_for('/middleware') }
  subject { described_class.new(app) }

  it 'logs the request' do
    expect { subject.call(env) }.to change { Log.count }.by(1)
  end
end
