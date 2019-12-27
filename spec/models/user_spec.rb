# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user table columns' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :first_name }
    it { is_expected.to have_db_column :last_name }
    it { is_expected.to have_db_column :password_digest }
    it { is_expected.to have_db_column :email }
  end
  describe 'user attributes validation' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(30) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(30) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it { is_expected.to validate_presence_of(:email) }
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
    before { FactoryBot.build(:user) }
    it 'should create user with valid attributes' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
      expect(user.first_name).to eq 'Jane'
    end
    it 'it should not allow user with same email to be created' do
      FactoryBot.create(:user)
      user = User.create(first_name: 'kk', last_name: 'kk', email: 'JANEDOE@gmail.com', password: '123@emaillWl',
                         password_confirmation: '123@emaillWl')
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to eq ['has already been taken']
    end
    it 'should not create user with weak password' do
      user = User.create(first_name: 'kk', last_name: 'kk', email: 'janedoe@gmail.com', password: '123',
                         password_confirmation: '123')
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to eq ['enter stronger password']
    end
    it 'should not create user with first_name longer 70' do
      user = User.create(first_name: 'kk' * 70, last_name: 'kk', email: 'janedoe@gmail.com', password: '123@emaillWl',
                         password_confirmation: '123@emaillWl')
      expect(user).not_to be_valid
      expect(user.errors.messages[:first_name]).to eq ['is too long (maximum is 30 characters)']
    end
    it 'should not create user with mistmatching passwords to be created' do
      user = User.create(first_name: 'kk', last_name: 'kk', email: 'janedoe@gmail.com', password: '123@emaillWl',
                         password_confirmation: '123@emailWl')
      expect(user).not_to be_valid
      expect(user.errors.messages[:password_confirmation]).to eq ["doesn't match Password", "doesn't match Password"]
    end
  end
end
