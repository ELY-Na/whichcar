# Whichcar

Whichcar is a website designed to help you easily find the car you want by answering simple questions. The website scrapes a well-known French car website to provide you with the best results.

## Installation

To get started with Whichcar, you'll need to ensure you have the following software installed:

- Ruby 3.1.4
- Rails 7.1.3
- Node.js
- Yarn

1. Install RVM:

Follow the instructions on the [RVM installation page](https://rvm.io/rvm/install)


2. Install Ruby 3.1.4 version:

```bash
rvm install 3.1.4 
```

```bash
rvm use 3.1.4
```

```bash
gem install bundler
```


3. Install Node.js, Yarn and dependencies:

Using Homebrew:

```bash
brew install node
```

```bash
brew install yarn 
```

```bash
yarn install
```


4. Setup the project:

```bash
bundle install
```

```bash
rails db:migrate
```

This step is crucial for scraping data from [Aramis Auto](https://www.aramisauto.com/):

```bash
rails db:seed
```

## Contributing or Finding a bug?

If you encounter any issues or would like to contribute to Whichcar, please open an issue in the repository.
