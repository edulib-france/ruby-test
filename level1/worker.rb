class Worker
    attr_reader :id, :price_per_shift
    attr_accessor :number_of_shifts, :pay

    def initialize(id, price_per_shift)
        @id = id
        @price_per_shift = price_per_shift
        @number_of_shifts = 0
        @pay = 0
    end

    def calculate_pay
        @pay = @number_of_shifts * @price_per_shift
    end
end