defmodule Identicon do
  
    def main(input) do
        input 
        |> hash_input
        |> pick_color
    end

    def hash_input(input) do
      hex =  :crypto.hash(:md5,input)
       |> :binary.bin_to_list

       %Identicon.Image{hex: hex}
    end

     def pick_color(%Identicon.Image{hex: [r,g,b | _tail]} = image) do
      
        ##asignamos a,b y c los 3 primeros valores de la lista de la propiedad hex de la struct, tail contiene el resto de la lista
        ##%Identicon.Image{hex: [r,g,b | _tail]} = image
        
        ##asignamos a la propiedad color de la estructura la tupla con los valores r,g,b
        ## serioa como image.color = {r,g,b} en un lenguaje normal
        %Identicon.Image{image | color: {r, g, b}}
    
    end

    #en javascript seria
    ##pick_color: function(image){
    ##    image.color = {
    ##        r: image.hex[0],
    ##        g: image.hex[1],
    ##        b: image.hex[2]
    ##    }
    ##}

end
