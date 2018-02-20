defmodule Identicon do
  
    def main(input) do
        input 
        |> hash_input
        |> pick_color
        |> build_grid
        |> filter_odd_squares
        |> build_pixel_map
        |> draw_image
        |> save_image(input)
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
         grid = 
            hex
            |> Enum.chunk(3) ##Enum.chunk(hex,3)
            |> Enum.map(&mirror_row/1) # &referencia a una funcion, /1 se refiere a la funcion que tiene un solo un argumento
            |> List.flatten
            |> Enum.with_index

         %Identicon.Image{image | grid: grid}
    end

    def mirror_row([first,second | _tail] = row) do
         #[first, second | _tail] = row

         row ++ [second, first]
    end

    def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
        grid = Enum.filter grid, fn({code, _index }) ->  #igual que Enum.filter(grid, fn(square) -> end)
            rem(code,2) == 0 #igual que % de javascript, resto de la divicion por 2
        end

        %Identicon.Image{image | grid: grid}
    end

    def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    
      pixel_map = Enum.map grid, fn({_code, index}) ->
            horizontal = rem(index,5) * 50
            vertical = div(index, 5) * 50
            top_left = {horizontal,vertical}
            bottom_right = {horizontal + 50, vertical + 50}
            {top_left, bottom_right}
        end

        %Identicon.Image{image | pixel_map: pixel_map}

    end

    def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
        image = :egd.create(250,250)
        fill = :egd.color(color)

        Enum.each pixel_map, fn({start, stop}) ->
            :egd.filledRectangle(image, start, stop, fill)
        end

        :egd.render(image)

    end

    def save_image(image,filename) do
        File.write("#{filename}.png",image)
    end

end
