FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Martti"
    password "Foobar2"
    password_confirmation "Foobar2"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :style do
    name "lager"
    description "jotakin"
  end

  factory :brewery2, class: Brewery do
    name "toinen"
    year 1900
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :beer2, class: Beer do
    name "Anonynoums 2"
    :brewery2
    style
  end
end