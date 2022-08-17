Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :tiny_urls, only: [], path: '' do
        collection do
          post :encode
          post :decode
        end
      end
    end
  end
end
