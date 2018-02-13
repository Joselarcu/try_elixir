defmodule Cards do
    @moduledoc """
        Provides methos for creating and handling a deck of playing cards
    """

    @doc """
        Return a list of strings representing a list of cars
    """
    def create_deck do
        values = ["Ace", "Two", "Three","Four","Five"]
        suits = ["Spades","Clubs","Hearts","Diamons"]

        for suit <- suits, value <- values do
            "#{value} of #{suit}"
        end

    end

    def shuffle(deck) do
        Enum.shuffle(deck)
    end

    @doc """
        Determines whether a deck contains a given cards

    ## Examples

            iex> deck = Cards.create_deck
            iex> Cards.contains?(deck, "Ace of Spades") 
            true            
    """
    def contains?(deck, hand) do
        Enum.member?(deck,hand);
    end

    @doc """
        Divides a  deck into a hand and the remainder of the deck.
        The `hand_size` argument indicates how many cards should be in the hand.

    ##Examples

            iex> deck = Cards.create_deck
            iex> {hand, deck} = Cards.deal(deck,1)
            iex> hand
            ["Ace of Spades"]
    """
    


    def deal(deck, hand_size) do
        Enum.split(deck,hand_size)
    end

    def save(deck,filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary)
    end

    def load(filename) do
       ## {status,binary} = File.read(filename)

        case File.read(filename) do
            {:ok, binary} -> :erlang.binary_to_term binary
            {:error, _reason} -> "That file does not exist"
        end
    end

    def create_hand(hand_size) do
        ##sin pipe
        ##deck = Cards.create_deck 
        ##deck = Cards.shuffle(deck)
        ##hand = Cards.deal(deck, hand_size)
        ##con pipe
        Cards.create_deck
        |> Cards.shuffle
        |> Cards.deal(hand_size)
    end
    
end

## iex -S mix --> Call interative elixir shell. -S compila nuestro proyecto
## recompile -> recompila para ver los cambios hechos en el archivo

##las funciones no modifican estructuras, hacen una copia que devuelven
##inmutability -> se crea una copia del dato que queremos cambiar y eso es lo que se cambia
##{deck, hand} -> Tuplas, seria como un objeto javascript pero sin key. Es como {"deck":[],"hand":[]}, no hace falta las keys porque sabemos que siempre en la ##primera posicion viene el deck y en la segunda el hand.
## para coger el primer elemento de una tupla {elem, elem2} = Card.deal(myHand,5)
## lo mismo con arrays, esto se llam pattern matching
##atom ->controlan el flujo de nuestra aplicacion, por ejemplo :ok o :error

##["red", color] = ["red", "blue"] -> si se hardcodea el primer valor tiene que ser igual en los dos lados de la igualdad, si no lanzará un error
## {:ok, _reason} -> _reason se utiliza para el pattern matching pero el valor no se usara para nada

## pipe |> el resultado de la primera operacion se pasa como primer argumento de la siguiente, no habría manera de pasarlo como segundo 

##instalar paquetes -> en la funcion deps del archivo mix.exs y luego ejecutar mix deps.get

##mix test -> lanzar los test que estan en cards_test.exs
