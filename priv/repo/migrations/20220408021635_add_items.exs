defmodule Todo.Repo.Migrations.AddItems do
  use Ecto.Migration

  def change do
    create table (:items) do
      add :title, :string
      add :description, :string
      add :completed, :boolean

      timestamps()
    end
  end

end
