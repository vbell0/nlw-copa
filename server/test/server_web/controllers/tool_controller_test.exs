defmodule ServerWeb.ToolControllerTest do
  use ServerWeb.ConnCase

  import Server.ToolsFixtures

  alias Server.Tools.Tool

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
    test "lists all tools", %{conn: conn} do
      conn = get(conn, Routes.tool_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tool" do
    test "renders tool when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tool_path(conn, :create), tool: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tool_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "code" => "some code",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tool_path(conn, :create), tool: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tool" do
    setup [:create_tool]

    test "renders tool when data is valid", %{conn: conn, tool: %Tool{id: id} = tool} do
      conn = put(conn, Routes.tool_path(conn, :update, tool), tool: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tool_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "code" => "some updated code",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tool: tool} do
      conn = put(conn, Routes.tool_path(conn, :update, tool), tool: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tool" do
    setup [:create_tool]

    test "deletes chosen tool", %{conn: conn, tool: tool} do
      conn = delete(conn, Routes.tool_path(conn, :delete, tool))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tool_path(conn, :show, tool))
      end
    end
  end

  defp create_tool(_) do
    tool = tool_fixture()
    %{tool: tool}
  end
end
