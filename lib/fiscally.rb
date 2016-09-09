module Fiscally

  Dir[File.dirname(__FILE__) + '/fiscally/*.rb'].each do |file|
    require file
  end

end
