require 'rails_helper'

RSpec.describe EventsController do
  allow_user_to(:manage, Event)

  describe 'GET #index' do
    it 'sets instance_variables' do
      create(:event, title: 'Second', start_time: 5.days.ago)
      create(:event, title: 'First', start_time: 10.days.ago)

      get(:index)
      expect(assigns(:events).map(&:title)).to eq(['First', 'Second'])
      expect(response).to have_http_status(200)
    end

    it 'renders with cover_photo' do
      image = create(:image)
      Settings.events_cover_image = image.id

      get(:index)
    end

    it 'renders .ics format' do
      create(:event)
      get(:index, format: :ics)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'sets event and returns 200' do
      event = create(:event)
      get(:show, id: event.to_param)

      expect(assigns(:event)).to eq(event)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'sets new event and returns 200' do
      get(:new)

      expect(assigns(:event)).to be_a_new(Event)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it 'creates with valid parameters' do
      attributes = { start_time: 1.day.from_now,
                     end_time: 2.days.from_now,
                     title_sv: 'Ett evenemang',
                     title_en: 'An event',
                     tags: [] }

      expect do
        post(:create, event: attributes)
      end.to change(Event, :count).by(1)

      expect(response).to redirect_to(event_path(Event.last))
    end

    it 'renders with errors if invalid parameters' do
      attributes = { start_time: nil, tags: [] }

      expect do
        post(:create, event: attributes)
      end.to change(Event, :count).by(0)

      expect(response).to have_http_status(422)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'sets event and returns 200' do
      event = create(:event)
      get(:edit, id: event.to_param)
      expect(assigns(:event)).to eq(event)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH #update' do
    it 'updates event with valid parameters' do
      event = create(:event, title_sv: 'Ett evenemang')
      attributes = { title_sv: 'Ett annat evenemang', tags: [] }

      patch(:update, id: event.to_param, event: attributes)
      event.reload
      expect(event.title_sv).to eq('Ett annat evenemang')
      expect(response).to redirect_to(edit_event_path(event))
    end

    it 'renders with errors with invalid parameters' do
      event = create(:event, title_sv: 'Ett evenemang')
      create(:tag, title: 'First tag')
      attributes = { title_sv: '', tags: [] }

      patch(:update, id: event.to_param, event: attributes)

      event.reload
      expect(event.title_sv).to eq('Ett evenemang')
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(422)
      expect(assigns(:tags).map(&:title)).to eq(['First tag'])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes event and redirects' do
      event = create(:event)

      expect do
        delete(:destroy, id: event.to_param)
      end.to change(Event, :count).by(-1)

      expect(response).to redirect_to(events_path)
    end
  end
end
