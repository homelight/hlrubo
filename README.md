# HomeLight Rubo

HomeLight shared ruby style configs.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem "hlrubo"
end
```

And then execute:

```bash
$ bundle install
```

## Usage

Create a `.rubocop.yml` with the following directives:

```yaml
inherit_gem:
  hlrubo:
    - default.yml
```

Now, run:

```bash
$ bundle exec rubocop
```

No need to include rubocop directly application dependencies. Hlrubo will include specific versions of `rubocop`, `rubocop-performance`, `rubocop-rails` and `rubocop-rspec` that is shared across projects.

### GitHub Actions Integration using Pronto
- Paste below in `.github/workflows/pronto.yml` of project root.

  ```yaml
  name: Pronto
  on: [pull_request]

  jobs:
    pronto:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@master
        - uses: actions/setup-ruby@v1
          with:
            ruby-version: '2.6.6'
        - run: gem install pronto pronto-rubocop hlrubo
        - run: git fetch
        - run: PRONTO_PULL_REQUEST_ID="$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")" PRONTO_GITHUB_ACCESS_TOKEN="${{ secrets.PRONTO_TOKEN }}" pronto run -f github_status github_pr -c origin/master
  ```

- Match `ruby-version: '2.6.6'` to repo ruby version.
- Keep `"$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")"` as is.
- For `secrets.PRONTO_TOKEN`, create token in `https://github.com/project/repo-name/settings/secrets`
