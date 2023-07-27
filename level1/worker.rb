class Worker
    attr_reader :id, :price_per_shift, :shifts, :pay

    def initialize(id, price_per_shift)
        @id = id
        @price_per_shift = price_per_shift
        @shifts = []
        @pay = 0
    end

    def add_shift(shift)
        @shifts << shift
    end

    def calculate_pay
        @pay = @shifts.length * @price_per_shift
    end
end
