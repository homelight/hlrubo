# HomeLight Rubo

HomeLight shared ruby style configs.

## Installation

Add gem to application Gemfile:

```ruby
group :development do
  gem "hlrubo", require: false
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

No need to include rubocop in application gemfile.

Hlrubo will install [specific versions](https://github.com/homelight/hlrubo/blob/master/hlrubo.gemspec) of:
- `rubocop`
- `rubocop-performance`
- `rubocop-rails`
- `rubocop-rspec`

### GitHub Actions Integration using [Pronto](https://github.com/prontolabs/pronto)
#### Notes for below examples:
- Match `ruby-version: '2.6.6'` to repo ruby version.
- Keep `"$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")"` as is.
- For `secrets.PRONTO_TOKEN`, create token in `https://github.com/project/repo-name/settings/secrets`

#### Basic Implementation Example:
In `.github/workflows/pronto.yml` of project root add:
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
          ruby-version: "2.6.6"
      - run: gem install pronto pronto-rubocop hlrubo
      - run: git fetch
      - run: PRONTO_PULL_REQUEST_ID="$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")" PRONTO_GITHUB_ACCESS_TOKEN="${{ secrets.PRONTO_TOKEN }}" pronto run -f github_status github_pr -c origin/master
```

#### Caching Implementation Example:
Add below to application Gemfile:

```ruby
group :rubocop do
  gem "hlrubo", require: false
  gem "pronto", require: false
  gem "pronto-rubocop", require: false
end
```

In `.github/workflows/pronto.yml` of project root add:
```yaml
name: Pronto
on: [pull_request]

jobs:
  pronto:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-ruby@v1
        with:
          ruby-version: "2.6.6"
      - uses: actions/cache@v1
        with:
          path: vendor/bundle
          key: ${{ runner.os }}-gems-${{ hashFiles('**/Gemfile.lock') }}
          restore-keys: |
            ${{ runner.os }}-gems-
      - name: Bundle install
        run: |
          bundle config path vendor/bundle
          bundle install --jobs 4 --retry 3 --without default development test
      - run: git fetch
      - run: PRONTO_PULL_REQUEST_ID="$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")" PRONTO_GITHUB_ACCESS_TOKEN="${{ secrets.PRONTO_TOKEN }}" bundle exec pronto run -f github_pr -c origin/master
```
