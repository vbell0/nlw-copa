defmodule ServerWeb.PoolControllerTest do
  use ServerWeb.ConnCase

  import Server.PoolsFixtures

  alias Server.Pools.Pool

  @create_attrs %{
    code: "some code",
    title: "some title"
  }
  @update_attrs %{
    code: "some updated code",
    title: "some updated title"
  }
  @invalid_attrs %{code: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pools", %{conn: conn} do
      conn = get(conn, Routes.pool_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pool" do
    test "renders pool when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pool_path(conn, :create), pool: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pool_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "code" => "some code",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pool_path(conn, :create), pool: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pool" do
    setup [:create_pool]

    test "renders pool when data is valid", %{conn: conn, pool: %Pool{id: id} = pool} do
      conn = put(conn, Routes.pool_path(conn, :update, pool), pool: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pool_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "code" => "some updated code",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pool: pool} do
      conn = put(conn, Routes.pool_path(conn, :update, pool), pool: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pool" do
    setup [:create_pool]

    test "deletes chosen pool", %{conn: conn, pool: pool} do
      conn = delete(conn, Routes.pool_path(conn, :delete, pool))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pool_path(conn, :show, pool))
      end
    end
  end

  defp create_pool(_) do
    pool = pool_fixture()
    %{pool: pool}
  end
end
