defmodule Demo.SecretsTest do
  use Demo.DataCase

  alias Demo.Secrets

  describe "secrets" do
    alias Demo.Secrets.Secret

    @valid_attrs %{key: "some key", value: "some value"}
    @update_attrs %{key: "some updated key", value: "some updated value"}
    @invalid_attrs %{key: nil, value: nil}

    def secret_fixture(attrs \\ %{}) do
      {:ok, secret} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Secrets.create_secret()

      secret
    end

    test "list_secrets/0 returns all secrets" do
      secret = secret_fixture()
      assert Secrets.list_secrets() == [secret]
    end

    test "get_secret!/1 returns the secret with given id" do
      secret = secret_fixture()
      assert Secrets.get_secret!(secret.id) == secret
    end

    test "create_secret/1 with valid data creates a secret" do
      assert {:ok, %Secret{} = secret} = Secrets.create_secret(@valid_attrs)
      assert secret.key == "some key"
      assert secret.value == "some value"
    end

    test "create_secret/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Secrets.create_secret(@invalid_attrs)
    end

    test "update_secret/2 with valid data updates the secret" do
      secret = secret_fixture()
      assert {:ok, %Secret{} = secret} = Secrets.update_secret(secret, @update_attrs)
      assert secret.key == "some updated key"
      assert secret.value == "some updated value"
    end

    test "update_secret/2 with invalid data returns error changeset" do
      secret = secret_fixture()
      assert {:error, %Ecto.Changeset{}} = Secrets.update_secret(secret, @invalid_attrs)
      assert secret == Secrets.get_secret!(secret.id)
    end

    test "delete_secret/1 deletes the secret" do
      secret = secret_fixture()
      assert {:ok, %Secret{}} = Secrets.delete_secret(secret)
      assert_raise Ecto.NoResultsError, fn -> Secrets.get_secret!(secret.id) end
    end

    test "change_secret/1 returns a secret changeset" do
      secret = secret_fixture()
      assert %Ecto.Changeset{} = Secrets.change_secret(secret)
    end
  end
end
