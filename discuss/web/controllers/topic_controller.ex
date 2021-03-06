defmodule Discuss.TopicController do

    use Discuss.Web, :controller #coge los paquetes que necesita de web.ex de los imports del module controller

    alias Discuss.Topic

    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{},%{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do
        IO.inspect(topic)
         #%{"topic" => topic} = params
         changeset = Topic.changeset(%Topic{},topic)
        case Repo.insert(changeset) do
            {:ok,post} -> IO.inspect(post)
            {:error,changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end

    def index(conn, _params) do
        render conn, "list.html", changeset: changeset
    end

end