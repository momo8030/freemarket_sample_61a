FactoryBot.define do
  factory :user do
    nickname                   {"aaa"}
    email                      {"kkk@gmail.com"}
    password                   {"00000000"}
    password_confirmation      {"00000000"}
    first_name                 {"笹三田"}
    last_name                  {"重一"}
    first_name_kana            {"ササミタ"}
    last_name_kana             {"シゲカズ"}
    birth_year                 {2000}
    birth_month                {1}
    birth_day                  {1}
    phone_number               {"09012345678"}
  end
end
