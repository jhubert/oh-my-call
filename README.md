# OhMyCall!

## The Intent of the Project

The goal is to build a simple, developer friendly, easy to configure emergency alert system for when things go wrong in mission critical systems. 

For example, if a system performs a time sensitive action and someone needs to be notified if it fails, an email won't really work in the middle of the night. However, if their phone starts ringing and an automated voice tells when what went wrong, that's a different story.

So, it works like this:

1. Setup a situation and assign a call list (phone numbers)
2. Get a URL to ping whenever that situation occurs
3. When the URL is hit, phone calls get made to the people on the call list

Simple.

## Using the docs

Our API documentation is powered by Apiary, a startup that is building an API documentation framework that's easy to read and understand.

You can read a [formatted version of the docs on Apiary.io](http://docs.ohmycall.apiary.io/) or read the raw apib file in the room of this repo.

## Testing

To run all of the tests, you can just run `rake`

During active development, you can use `bundle exec guard` to run tests as you make changes. 

## Contributing

1. Fork it.
2. Create a feature branch (git checkout -b my-change-branch)
3. Commit your changes (git commit -am "Made a valuable contribution")
4. Run the tests and rubocop for syntactic checks
5. Push to the branch (git push origin my_markup)
6. Open a Pull Request
7. Enjoy a refreshing Diet Coke and wait
