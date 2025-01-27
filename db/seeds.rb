BASE_RECORD_NUM = 10_000
BATCH_SIZE = 1000

(BASE_RECORD_NUM/BATCH_SIZE).times do |i|
  Company.transaction do
    BATCH_SIZE.times do
      Company.create(
        name: Faker::Company.name,
        address: Faker::Address.state + Faker::Address.city + Faker::Address.street_name + Faker::Address.state_abbr
      )
    end
  end
  puts("Company: #{i + 1}/#{BASE_RECORD_NUM/BATCH_SIZE} completed.")
end

Faker::Config.locale = :en

(BASE_RECORD_NUM/BATCH_SIZE).times do |i|
  Shop.transaction do
    BATCH_SIZE.times do
      Shop.create(
        company_id: Company.first.id + Random.rand(BASE_RECORD_NUM),
        name: Faker::Company.name,
        description: 'dummy' * Random.rand(10)
      )
    end
  end
  puts("Shop: #{i + 1}/#{BASE_RECORD_NUM/BATCH_SIZE} completed.")
end

(BASE_RECORD_NUM/BATCH_SIZE).times do |i|
  Work.transaction do
    BATCH_SIZE.times do
      Work.create(
        shop_id: Shop.first.id + Random.rand(BASE_RECORD_NUM),
        name: Faker::Company.name,
        description: 'dummy' * Random.rand(10),
        salary: 1000 + Random.rand(1000)
      )
    end
  end
  puts("Work: #{i + 1}/#{BASE_RECORD_NUM/BATCH_SIZE} completed.")
end

Faker::Config.locale = :ja

((BASE_RECORD_NUM * 4)/BATCH_SIZE).times do |i|
  Member.transaction do
    (BATCH_SIZE).times do
      Member.create(
        name: Faker::Name.name,
        email_address: Faker::Internet.email,
        birthday: Faker::Date.between(from: '1960-01-01', to: '2003-12-31')
      )
    end
    puts("Member: #{i + 1}/#{(BASE_RECORD_NUM * 4)/BATCH_SIZE} completed.")
  end
end

((BASE_RECORD_NUM * 5)/BATCH_SIZE).times do |i|
  Entry.transaction do
    (BATCH_SIZE).times do
      Entry.create(
        work_id: Work.first.id + Random.rand(BASE_RECORD_NUM),
        member_id: Member.first.id + Random.rand(BASE_RECORD_NUM *  4)
      )
    end
    puts("Entry: #{i + 1}/#{(BASE_RECORD_NUM * 5)/BATCH_SIZE} completed.")
  end
end


10.times do |i|
  LockTest.transaction do
    LockTest.create(
      name: Faker::Name.name
    )
  end
end