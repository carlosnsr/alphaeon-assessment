require 'rails_helper'
require 'json'
require 'rack'
require 'middleware/log_requests_middleware.rb'

RSpec.describe LogRequestsMiddleware do
  let(:bad_json) { '{"data":"whoops"' } # missing ending parenthesis
  let(:json) { { data: 'success' }.to_json }
  let(:app) { ->(env) { [200, { 'Content-Type' => 'application/json' }, [ json ]] } }
  let(:env) { ::Rack::MockRequest.env_for('/middleware') }
  subject { described_class.new(app).call(env) }

  it 'logs the request' do
    expect { subject }.to change { Log.count }.by(1)
  end

  context 'when creating a Log record fails' do
    it 'does not allow the create error to bubble up' do
      # "handle" could be logging it using Rails.logger or some other method
      allow(Log).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
      expect { subject }.to_not raise_error
    end
  end

  context 'when response is not well-formed json' do
    let(:json) { bad_json }

    it 'does not allow the parsing error to bubble up' do
      expect { subject }.to_not raise_error
    end
  end

  context 'when response is HTML' do
    let(:app) { ->(env) { [200, { 'Content-Type' => 'text/html' }, "<head><body></body></head>"] } }

    it 'does not allow the parsing error to bubble up' do
      expect { subject }.to_not raise_error
    end
  end

  context 'when request is not well-formed json' do
    let(:env) { ::Rack::MockRequest.env_for('/middleware', input: bad_json) }

    it 'does not allow the parsing error to bubble up' do
      expect { subject }.to_not raise_error
    end
  end
end
