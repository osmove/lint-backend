json.signed_in @signed_in
if @user
  json.partial! 'users/user', user: @user
  # json.repositories @user.repositories.order(type: :asc), partial: 'repositories/repository', as: :repository
  # json.master_devices @user.master_devices.order(id: :desc), partial: 'master_devices/master_device', as: :master_device
  # json.rooms @user.rooms.order(id: :desc), partial: 'rooms/room', as: :room
  json.url me_path(@user, format: :json)
  # json.settings @settings
end
