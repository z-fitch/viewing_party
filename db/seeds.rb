
    UserViewingParty.destroy_all
    User.destroy_all
    ViewingParty.destroy_all

    @user = User.create!(name: "Bob", email: "bob@example.com", password: "test123", password_confirmation: "test123")
    @user2 = User.create!(name: "Sarah", email: "Sarah@example.com", password: "test123", password_confirmation: "test123")


    @viewing_party = ViewingParty.create!({duration: 142, date: Date.today, start_time: Time.now, movie_id: 13})

    @viewing_party_2 = ViewingParty.create!({duration: 84, date: Date.today, start_time: Time.now, movie_id: 200})

    @uvp_1 = UserViewingParty.create!(user_id: @user.id, viewing_party_id: @viewing_party.id)
    @uvp_2 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @viewing_party.id, host: true)

    @uvp_3 = UserViewingParty.create!(user_id: @user.id, viewing_party_id: @viewing_party_2.id, host: true)
    @uvp_4 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @viewing_party_2.id)