defmodule Server.ToolsTest do
  use Server.DataCase

  alias Server.Tools

  describe "tools" do
    alias Server.Tools.Tool

    import Server.ToolsFixtures

    @invalid_attrs %{code: nil, title: nil}

    test "list_tools/0 returns all tools" do
      tool = tool_fixture()
      assert Tools.list_tools() == [tool]
    end

    test "get_tool!/1 returns the tool with given id" do
      tool = tool_fixture()
      assert Tools.get_tool!(tool.id) == tool
    end

    test "create_tool/1 with valid data creates a tool" do
      valid_attrs = %{code: "some code", title: "some title"}

      assert {:ok, %Tool{} = tool} = Tools.create_tool(valid_attrs)
      assert tool.code == "some code"
      assert tool.title == "some title"
    end

    test "create_tool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_tool(@invalid_attrs)
    end

    test "update_tool/2 with valid data updates the tool" do
      tool = tool_fixture()
      update_attrs = %{code: "some updated code", title: "some updated title"}

      assert {:ok, %Tool{} = tool} = Tools.update_tool(tool, update_attrs)
      assert tool.code == "some updated code"
      assert tool.title == "some updated title"
    end

    test "update_tool/2 with invalid data returns error changeset" do
      tool = tool_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_tool(tool, @invalid_attrs)
      assert tool == Tools.get_tool!(tool.id)
    end

    test "delete_tool/1 deletes the tool" do
      tool = tool_fixture()
      assert {:ok, %Tool{}} = Tools.delete_tool(tool)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_tool!(tool.id) end
    end

    test "change_tool/1 returns a tool changeset" do
      tool = tool_fixture()
      assert %Ecto.Changeset{} = Tools.change_tool(tool)
    end
  end
end
