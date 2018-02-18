defmodule Identicon do
  
    def main(input) do
        input 
        |> hash_input
        |> pick_color
        |> build_grid
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
        ##hay que poner el image para mantener el valor del hex, si no estarías obteniendo un struct con hex: nil y color {a,b,c}
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

    def build_grid(%Identicon.Image{hex: hex} = image) do
         hex
         |> Enum.chunk(3) ##Enum.chunk(hex,3)
         |> Enum.map(&mirror_row/1) # &referencia a una funcion, /1 se refiere a la funcion que tiene un solo un argumento
 
    end

    def mirror_row([first,second | _tail] = row) do
         #[first, second | _tail] = row

         row ++ [second, first]
    end

end
