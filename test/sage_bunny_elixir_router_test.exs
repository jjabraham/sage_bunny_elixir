defmodule SageBunnyElixirTest.Router do
  use ExUnit.Case, async: true

  use Plug.Test

  @opts SageBunnyElixir.Router.init([])

  test "GET / should return ok" do
    conn = conn(:get, "/")
    conn = SageBunnyElixir.Router.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end

  describe "Posts" do
    # The setup callback is called before each test executes and the on_exit after each test is complete
    # We will use this hook to list all the mongo db collections and for each of
    # the collection to clear out the entire collection. This way for every test
    # case we will start from a clean slate
    setup do
      on_exit fn ->
        Mongo.show_collections(:mongo)
        |> Enum.each(
          fn collection -> Mongo.delete_many!(:mongo, collection, %{})
            end)
      end
    end
  end
end
