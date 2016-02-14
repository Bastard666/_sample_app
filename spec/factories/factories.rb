# En utilisant le symbole ':user', nous faisons que
# Factory Girl simule un modèle User.
FactoryGirl.define do
  factory :user do |f|
    f.name                  "Michael Hartl"
    f.email                 "mhartl@example.com"
    f.password              "foobar"
    f.password_confirmation "foobar"
  end
end