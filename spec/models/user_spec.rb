require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user table columns' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :first_name }
    it { is_expected.to have_db_column :last_name }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :created_at }
    it { is_expected.to have_db_column :updated_at }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :reset_password_token }
    it { is_expected.to have_db_column :reset_password_sent_at}
    it { is_expected.to have_db_column :remember_created_at }
  end
    describe 'user attributes validation' do
       it { is_expected.to validate_presence_of(:first_name) }
       it { is_expected.to validate_length_of(:first_name).is_at_most(30) }
       it { is_expected.to validate_presence_of(:last_name) }
       it { is_expected.to validate_length_of(:last_name).is_at_most(30) }
       it { is_expected.to validate_presence_of(:password) }
       it { is_expected.to validate_presence_of(:password_confirmation) }
       it { is_expected.to validate_presence_of(:email) }
       it { is_expected.to validate_confirmation_of(:password) }
       context 'should not be invalid email address' do
         emails = ['ppp@ qr.com', '@example.com', 'trial test @gmail.com',
                   'linda@podii', 'yyy@.x. .x', 'zzz@.z']
         emails.each do |email|
           it { is_expected.not_to allow_value(email).for(:email) }
         end
       end
       context 'should allow valid email address' do
         emails = ['flower@fl.com', 'helloworld@example.ke', 'trialbait@goosepump.de',
                   'okothkkk@gmail.com', 'janedoe@originals.ze']
         emails.each do |email|
           it { is_expected.to allow_value(email).for(:email) }
         end
       end
       context 'should not be invalid passwords' do
         passwords = ['Pass@12', 'CAPITAL LONGER', 'smallstrongerandbetter',
                      '***@###22', 'smallandsymbols#$%', 'mixtureNOSymbols1234']
         passwords.each do |password|
           it { is_expected.not_to allow_value(password).for(:password) }
         end
       end
       context 'should  be invalid passwords' do
         passwords = ['Password@12', 'CAPITAL LONGERsmall123.', 'smallstronger(andbe0tterCAP',
                      '***@###22jackBuer', 'mixtureNO#Symbols1234']
         passwords.each do |password|
           it { is_expected.to allow_value(password).for(:password) }
         end
       end
      end
      describe '#create user' do
        it 'should create user with valid attributes' do
          user = FactoryBot.create(:user)
          expect(user).to be_valid
          expect(user.first_name).to eq 'Jane'
        end
        it 'it should not allow user with same email to be created' do
          FactoryBot.create(:user)
          user = FactoryBot.build(:user, email: 'user@random.com')
          user.save
          expect(user).not_to be_valid
          expect(user.errors.messages[:email]).to eq ['has already been taken']
        end
        it 'should not create user with weak password' do
          user = FactoryBot.build(:user, password: '1238', password_confirmation: '1238')
          user.save
          expect(user).not_to be_valid
          expect(user.errors.messages[:password]).to eq ['Complexity requirement not met. Length should be at least 8 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character']
        end
        it 'should not create user with first_name longer 30' do
          user = User.create(first_name: 'kk' * 70, last_name: 'kk', email: 'janedoe@gmail.com', password: '123@emaillWl',
                            password_confirmation: '123@emaillWl')
          expect(user).not_to be_valid
          expect(user.errors.messages[:first_name]).to eq ['is too long (maximum is 30 characters)']
        end
        it 'should not create user with last_name longer 30' do
          user = User.create(first_name: 'kk' * 15, last_name: 'kk' * 70, email: 'janedoe@gmail.com', password: '123@emaillWl',
                            password_confirmation: '123@emaillWl')
          expect(user).not_to be_valid
          expect(user.errors.messages[:last_name]).to eq ['is too long (maximum is 30 characters)']
        end
      it 'should not create user with mistmatching passwords to be created' do
        user = User.create(first_name: 'kk', last_name: 'kk', email: 'janedoe@gmail.com', password: '123@emaillWl',
                          password_confirmation: '123@emailWl')
        expect(user).not_to be_valid
        expect(user.errors.messages[:password_confirmation]).to eq ["doesn't match Password"]
      end
      end

  end
