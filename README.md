# FizzBuzz Rails

This app is an implementation of the famous FizzBuzz problem. The problem is an
interview problem used to weed out engineers that just plain can't code.

> Write a program that prints the numbers from 1 to 100. But for multiples of
> three print “Fizz” instead of the number and for the multiples of five print
> “Buzz”. For numbers which are multiples of both three and five print
> “FizzBuzz”.

## Implementation

Everything lives in one controller at
`app/controllers/fizz_buzz_controller.rb`. A lot of the implementation is
client-side code. It's only been tested in Chrome on Mac OSX but...hey. Should
work elsewhere.

## Running the Application

In order to run the application in a development environment you'll need the
following:

* rvm
* ruby 2.1.0

Actually getting up and running is pretty straight forward:

```bash
$ git clone git@github.com:cloudability/fizz-buzz-rails.git
$ cd fizz-buzz-rails
$ bundle install
$ foreman start
$ open "http://localhost:5000/"
```

## Deploying the Application

The preferred deployment is as follows:

* ruby 2.1.0 (system installed)
* unicorn
* nginx

Details are:

* Nginx configured with Unicorn as the upstream.
* Multiple unicorn processes, controller via `config/unicorns/nginx.rb`
  configuration.
* Rolling restarts using the USR2 signal against the master unicorn process.
