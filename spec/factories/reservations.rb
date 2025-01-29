FactoryBot.define do
  factory :reservation do
    association :guest
    start_date { Date.current }
    end_date { Date.current + 1.day }
    number_of_nights { 1 }
    number_of_guests { 1 }
    number_of_adults { 1 }
    number_of_children { 0 }
    security_price { 100.00 }
    payout_price { 90.00 }
    total_price { 190.00 }
  end
end
