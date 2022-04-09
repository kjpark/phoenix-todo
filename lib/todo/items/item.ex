defmodule Todo.Items.Item do

  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false

    timestamps()
  end

  @doc """
  changeset validates data before inserting into the database.
  """
  def changeset(item, params) do
    item
    |> cast(params, [:title, :description, :completed])
    |> validate_required(:title)
    |> unique_constraint(:title)
  end
end
