defmodule Server.PoolsTest do
  use Server.DataCase

  alias Server.Pools

  describe "pools" do
    alias Server.Pools.Pool

    import Server.PoolsFixtures

    @invalid_attrs %{code: nil, title: nil}

    test "list_pools/0 returns all pools" do
      pool = pool_fixture()
      assert Pools.list_pools() == [pool]
    end

    test "get_pool!/1 returns the pool with given id" do
      pool = pool_fixture()
      assert Pools.get_pool!(pool.id) == pool
    end

    test "create_pool/1 with valid data creates a pool" do
      valid_attrs = %{code: "some code", title: "some title"}

      assert {:ok, %Pool{} = pool} = Pools.create_pool(valid_attrs)
      assert pool.code == "some code"
      assert pool.title == "some title"
    end

    test "create_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pools.create_pool(@invalid_attrs)
    end

    test "update_pool/2 with valid data updates the pool" do
      pool = pool_fixture()
      update_attrs = %{code: "some updated code", title: "some updated title"}

      assert {:ok, %Pool{} = pool} = Pools.update_pool(pool, update_attrs)
      assert pool.code == "some updated code"
      assert pool.title == "some updated title"
    end

    test "update_pool/2 with invalid data returns error changeset" do
      pool = pool_fixture()
      assert {:error, %Ecto.Changeset{}} = Pools.update_pool(pool, @invalid_attrs)
      assert pool == Pools.get_pool!(pool.id)
    end

    test "delete_pool/1 deletes the pool" do
      pool = pool_fixture()
      assert {:ok, %Pool{}} = Pools.delete_pool(pool)
      assert_raise Ecto.NoResultsError, fn -> Pools.get_pool!(pool.id) end
    end

    test "change_pool/1 returns a pool changeset" do
      pool = pool_fixture()
      assert %Ecto.Changeset{} = Pools.change_pool(pool)
    end
  end
end
