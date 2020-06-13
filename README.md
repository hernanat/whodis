# whodis

## About

This is a naive implementation of a keystroke anonymizer using Swift. People can be identified
  by [keystroke biometric](https://en.wikipedia.org/wiki/Keystroke_dynamics) techniques. By introducing
  variance into the time between key presses and releases, we can trick / disrupt creepy surveillance
  that tries to identify us by our keystrokes.

## Motivations

This project was motivated by [kloak](https://github.com/vmonaco/kloak), a keystroke anonymization tool
  for Linux (which ships with [Whonix](https://www.whonix.org/)).

As users become more privacy aware, companies and governments are doing more to make sure that they can
  identify them. This is gross.

## Disclaimer / known issues with this code

Like I said, this particular application is incredibly naive. *DO NOT* use this and feel safe. Though I've
  done some anecdotal testing using keystroke identifier applications and it seems to work,
  you should always err on the side of caution. If you feel like you know how to improve this project,
  please open a PR with your changes / suggestions.

One issue that was immediately apparent was that if you enter in too many keystrokes at a given time,
  and the upper-bound on the random number generator is too high, the program will fail silently
  and your keystroke patterns will not be varied. I have not figured out a way to make it fail more
  loudly.

The work around here was to tinker with the lower and upper bounds of the random number generator. In reality,
  this crashing problem isn't really an issue and was only discovered when I decided to smash my keyboard a
  bunch of times to see what would happen.

## Usage

Compile and run the Swift code (open it up in XCode). When you run it, you will be prompted to allow the application
  to have accessibility access. I set this up as an "accessibility" tool using `CGEvent` stuff because I couldn't figure
  out an elegant way to accomplish what I wanted to otherwise (I'm new to Swift and Apple I have found does a shitty job
  at documenting anything).

## LICENSE

MIT
