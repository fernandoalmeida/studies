alias Rumbl.Repo
alias Rumbl.Category

for category <- ~w(Action Comedy Drama Romance Sci-fi Thriller) do
    Repo.insert!(%Category{name: category})
end
