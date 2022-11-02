defmodule ServerWeb.TestControllerTest do
  use ServerWeb.ConnCase

  import Server.TestsFixtures

  alias Server.Tests.Test

  @create_attrs %{
    test: "some test"
  }
  @update_attrs %{
    test: "some updated test"
  }
  @invalid_attrs %{test: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tools", %{conn: conn} do
      conn = get(conn, Routes.test_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create test" do
    test "renders test when data is valid", %{conn: conn} do
      conn = post(conn, Routes.test_path(conn, :create), test: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.test_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "test" => "some test"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.test_path(conn, :create), test: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update test" do
    setup [:create_test]

    test "renders test when data is valid", %{conn: conn, test: %Test{id: id} = test} do
      conn = put(conn, Routes.test_path(conn, :update, test), test: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.test_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "test" => "some updated test"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, test: test} do
      conn = put(conn, Routes.test_path(conn, :update, test), test: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete test" do
    setup [:create_test]

    test "deletes chosen test", %{conn: conn, test: test} do
      conn = delete(conn, Routes.test_path(conn, :delete, test))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.test_path(conn, :show, test))
      end
    end
  end

  defp create_test(_) do
    test = test_fixture()
    %{test: test}
  end
end
