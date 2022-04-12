defmodule TodoWeb.ItemsController do
  use TodoWeb, :controller

  alias Todo.Items
  alias Todo.Items.Item

  def index(conn, _params) do
    items = Items.list_items()
    changeset = Item.changeset(%Item{}, %{})
    render(conn, "index.html", items: items, changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    # Items.create_item(item_params)
    # redirect(conn, to: "/items")

    case Items.create_item(item_params) do
    {:ok, item} ->
      conn
      |> put_flash(:info, "Successfully created: \"#{item.title}\"")
      |> redirect(to: Routes.items_path(conn, :index))

    {:error, %Ecto.Changeset{} = changeset} ->
      # https://elixirforum.com/t/how-to-print-changeset-errors-without-using-the-changeset-in-form-for/24106
      errors = changeset
      |> Ecto.Changeset.traverse_errors(fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)
      |> Enum.map(fn {key, errors} -> "#{key}: #{Enum.join(errors, ", ")}" end)
      |> Enum.join("\n")

      conn
      |> put_flash(:error, "Error: #{errors}")
      |> redirect(to: Routes.items_path(conn, :index))
    end
  end

  def complete(conn, %{"id" => id}) do
    Items.mark_complete(id)
    redirect(conn, to: "/items")
  end

  def incomplete(conn, %{"id" => id}) do
    Items.mark_incomplete(id)
    redirect(conn, to: "/items")
  end

  def delete(conn, %{"id" => id}) do
    Items.delete_item(id)
    redirect(conn, to: "/items")
  end
end
