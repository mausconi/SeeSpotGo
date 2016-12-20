require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe 'associations' do
    it { should belong_to(:occupant) }
    it { should belong_to(:space) }
  end

  describe 'validations' do
    it { should validate_presence_of(:occupant_id) }
    it { should validate_presence_of(:space_id) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should allow_values('2016-12-25 08:00:00', '2020-9-12 11:11:11').for(:start_time) }
    it { should_not allow_values('3412', '235123', 'lemon').for(:start_time) }
    it { should allow_values('2016-12-25 08:00:00', '2020-9-12 11:11:11').for(:end_time) }
    it { should_not allow_values('3412', '235123', 'lemon').for(:end_time) }

    describe 'reservation overlap validation' do
      let (:occupant) {User.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com", password: "123456", phone: "123-456-7890")}
      let (:location) {Location.create(user_id: occupant.id, street_address: "707 Broadway Avenue", city: "San Diego", state: "CA", zip: "92101")}
      let (:space) {Space.create(location_id: location.id)}

      it 'validates that reservation does not overlap with existing reservation' do
        reservation1 = Reservation.create(space_id: space.id, occupant_id: occupant.id, start_time: '2016-12-25 08:00:00', end_time: '2016-12-25 10:00:00')
        reservation2 = Reservation.create(space_id: space.id, occupant_id: occupant.id, start_time: '2016-12-25 08:01:00', end_time: '2016-12-25 09:59:00')
        expect(reservation2).not_to be_valid

        reservation3 = Reservation.create(space_id: space.id, occupant_id: occupant.id, start_time: '2016-12-25 10:00:01', end_time: '2016-12-25 11:00:00')
        expect(reservation3).to be_valid
      end
    end
  end
end
