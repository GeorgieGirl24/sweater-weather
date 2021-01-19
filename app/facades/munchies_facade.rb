class MunchiesFacade
  def self.get_restaurant(munchies_params)
    destination = munchies_params[:end]
    term = munchies_params[:food]
    restaurant = MunchiesService.get_restaurant(destination, term)
  end
end
