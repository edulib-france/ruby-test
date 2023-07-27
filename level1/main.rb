# Code
require 'json'
require 'bundler/inline'
require_relative 'worker.rb'
require_relative 'shift.rb'

gemfile do
  source 'https://rubygems.org'
  gem 'rspec'
end

data = JSON.parse(File.read('./level1/data.json'))

workers = data['workers'].map { |worker_data| Worker.new(worker_data['id'], worker_data['price_per_shift']) }
shifts = data['shifts'].map { |shift_data| Shift.new(shift_data['user_id']) }
shifts.each { |shift| workers.find { |w| w.id == shift.user_id }&.add_shift(shift) }
workers.each(&:calculate_pay)

# test RSpec
require 'rspec/autorun'

RSpec.describe Worker do
  describe '#calculate_pay' do
    it "calculates pay when number_of_shifts = 0" do
      worker = Worker.new(1, 10) # id: 1, price_per_shift: 10
      worker.calculate_pay
      expect(worker.pay).to eq(0)
    end

    it "calculates pay when number_of_shifts > 0" do
      worker = Worker.new(2, 15)
      worker.number_of_shifts = 4
      worker.calculate_pay
      expect(worker.pay).to eq(60) # 4 shifts * 15 price_per_shift
    end
  end

  describe '#add_shift' do
    it "add shift to worker" do
      worker = Worker.new(1, 10) 
      shift_mock = instance_double(Shift, user_id: 1)    
      worker.add_shift(shift_mock)
      expect(worker.shifts).to include(shift_mock)
    end
  end
end 

RSpec.describe Shift do
  describe '#initialize' do
    it "create a new shift with correct user_id" do
      shift = Shift.new(1) # user_id: 1
      expect(shift.user_id).to eq(1)
    end
  end
end 
