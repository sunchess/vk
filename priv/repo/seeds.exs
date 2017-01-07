# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Vg.Repo.insert!(%Vg.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
#Change the password and email when install app
changeset = Vg.User.changeset(%Vg.User{}, %{name: "SuperAdmin", email: "example@gmail.com", password: "adminpassword"})
Vg.Repo.insert!(changeset)

