defmodule DemoWeb.SecretController do
  use DemoWeb, :controller

  alias Demo.Secrets
  alias Demo.Secrets.Secret

  def index(conn, _params) do
    secrets = Secrets.list_secrets()
    render(conn, "index.html", secrets: secrets)
  end

  def new(conn, _params) do
    changeset = Secrets.change_secret(%Secret{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"secret" => secret_params}) do
    case Secrets.create_secret(secret_params) do
      {:ok, secret} ->
        conn
        |> put_flash(:info, "Secret created successfully.")
        |> redirect(to: Routes.secret_path(conn, :show, secret))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    secret = Secrets.get_secret!(id)
    render(conn, "show.html", secret: secret)
  end

  def edit(conn, %{"id" => id}) do
    secret = Secrets.get_secret!(id)
    changeset = Secrets.change_secret(secret)
    render(conn, "edit.html", secret: secret, changeset: changeset)
  end

  def update(conn, %{"id" => id, "secret" => secret_params}) do
    secret = Secrets.get_secret!(id)

    case Secrets.update_secret(secret, secret_params) do
      {:ok, secret} ->
        conn
        |> put_flash(:info, "Secret updated successfully.")
        |> redirect(to: Routes.secret_path(conn, :show, secret))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", secret: secret, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    secret = Secrets.get_secret!(id)
    {:ok, _secret} = Secrets.delete_secret(secret)

    conn
    |> put_flash(:info, "Secret deleted successfully.")
    |> redirect(to: Routes.secret_path(conn, :index))
  end
end
