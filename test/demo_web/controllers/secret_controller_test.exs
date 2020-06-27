defmodule DemoWeb.SecretControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Secrets

  @create_attrs %{key: "some key", value: "some value"}
  @update_attrs %{key: "some updated key", value: "some updated value"}
  @invalid_attrs %{key: nil, value: nil}

  def fixture(:secret) do
    {:ok, secret} = Secrets.create_secret(@create_attrs)
    secret
  end

  describe "index" do
    test "lists all secrets", %{conn: conn} do
      conn = get(conn, Routes.secret_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Secrets"
    end
  end

  describe "new secret" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.secret_path(conn, :new))
      assert html_response(conn, 200) =~ "New Secret"
    end
  end

  describe "create secret" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.secret_path(conn, :create), secret: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.secret_path(conn, :show, id)

      conn = get(conn, Routes.secret_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Secret"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.secret_path(conn, :create), secret: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Secret"
    end
  end

  describe "edit secret" do
    setup [:create_secret]

    test "renders form for editing chosen secret", %{conn: conn, secret: secret} do
      conn = get(conn, Routes.secret_path(conn, :edit, secret))
      assert html_response(conn, 200) =~ "Edit Secret"
    end
  end

  describe "update secret" do
    setup [:create_secret]

    test "redirects when data is valid", %{conn: conn, secret: secret} do
      conn = put(conn, Routes.secret_path(conn, :update, secret), secret: @update_attrs)
      assert redirected_to(conn) == Routes.secret_path(conn, :show, secret)

      conn = get(conn, Routes.secret_path(conn, :show, secret))
      assert html_response(conn, 200) =~ "some updated key"
    end

    test "renders errors when data is invalid", %{conn: conn, secret: secret} do
      conn = put(conn, Routes.secret_path(conn, :update, secret), secret: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Secret"
    end
  end

  describe "delete secret" do
    setup [:create_secret]

    test "deletes chosen secret", %{conn: conn, secret: secret} do
      conn = delete(conn, Routes.secret_path(conn, :delete, secret))
      assert redirected_to(conn) == Routes.secret_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.secret_path(conn, :show, secret))
      end
    end
  end

  defp create_secret(_) do
    secret = fixture(:secret)
    %{secret: secret}
  end
end
