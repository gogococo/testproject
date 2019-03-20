# cat config.ru
require "roda"
require "docker"

class App < Roda
  plugin :render
  def get_containers
    Docker::Container.all.map do |container|
      {:name => container.info["Names"][0], :status => container.info["Status"]}
    end
  end

  route do |r|

    r.get "containers" do
      @containers = get_containers
      render "containers"
    end
  end
end



run App.freeze.app
