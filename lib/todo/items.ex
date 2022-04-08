defmodule Todo.Items do
  alias Todo.Items.Item
  alias Todo.Repo
  import Ecto.Query

  def get_item(id) do
    Repo.get(Item, id)
  end

  def list_items() do
    # query = Item
    # |> order_by(desc: :id)
    # Repo.all(query)

    # refactored into

    Item
    |> order_by(desc: :id)
    |> Repo.all()
  end

  def mark_completed(id) do
    # item = Repo.get(Item, id)
    # item = Ecto.Changeset.change item, completed: true
    # Repo.update(item)

    # refactored into

    Item
    |> Repo.get(id)
    |> Ecto.Changeset.change(completed: true)
    |> Repo.update()
  end

  def delete_item(id) do
    # item = Repo.get(Item, id)
    # Repo.delete(item)

    # refactored into

    Item
    |> Repo.get(id)
    |> Repo.delete()
  end

  def create_item(params) do
    %Item{}
    |> Item.changeset(params)
    |> Repo.insert()
  end
end
