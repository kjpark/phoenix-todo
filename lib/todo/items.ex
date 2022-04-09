defmodule Todo.Items do
  alias Todo.Items.Item
  alias Todo.Repo
  import Ecto.Query

  def get_item(id) do
    Repo.get(Item, id)
  end

  def list_items() do
    Item
    |> order_by(desc: :id)
    |> Repo.all()
  end

  def mark_complete(id) do
    Item
    |> Repo.get(id)
    |> Ecto.Changeset.change(completed: true)
    |> Repo.update()
  end

  def mark_incomplete(id) do
    Item
    |> Repo.get(id)
    |> Ecto.Changeset.change(completed: false)
    |> Repo.update()
  end

  def delete_item(id) do
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
