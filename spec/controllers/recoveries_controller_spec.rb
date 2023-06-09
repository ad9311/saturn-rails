require 'rails_helper'
require 'devise'

RSpec.describe RecoveriesController, type: :controller do
  before(:each) do
    @user = User.create(
      first_name: 'Jon',
      last_name: 'Doe',
      username: 'jondoe',
      email: 'jon@mail.com',
      password: 'password'
    )
    sign_in @user
  end

  describe 'GET #index' do
    it 'gets all recoveries' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new recovery' do
      recovery_params = {
        recovery: {
          title: 'Recovery title',
          description: 'Recovery description',
          start_date: Time.zone.now.to_date,
          target_date: Time.zone.now.to_date + 5.days,
          user: @user
        }
      }
      post :create, params: recovery_params
      expect(response).to redirect_to(recovery_path(@user.recoveries.last))
      expect(@user.recoveries.count).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      recovery_params = {
        title: 'Recovery title',
        description: 'Recovery description',
        start_date: Time.zone.now.to_date,
        target_date: Time.zone.now.to_date + 5.days,
        user: @user
      }
      recovery = Recovery.create(recovery_params)
      get :show, params: { id: recovery.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      recovery_params = {
        title: 'Recovery title',
        description: 'Recovery description',
        start_date: Time.zone.now.to_date,
        target_date: Time.zone.now.to_date + 5.days,
        user: @user
      }
      recovery = Recovery.create(recovery_params)
      get :edit, params: { id: recovery.id }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end
end
