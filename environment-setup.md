# Setting Up Your Programming Environment

Before you start to work on the prep course material, it is important
that you make sure that your machine is compatible with the correct
version of Ruby, as well as the text editors we will use for the course.
Please carefully follow the instructions in each section below to ensure
that pair programming proceeds smoothly, with as few technical hiccups
as possible.

## The Command Line

Your operating system should have shipped with a program giving you
access to the command line (Terminal in OS X, GNOME Terminal in Ubuntu,
or the `cmd` prompt in Windows). You won't need to install any
additional software to use the command line, but we do expect you to be
familiar with basic commands. We recommend [the "hard way"
tutorial][cli-hardway]. Don't be scared, the tutorial isn't really that
hard; you'll simply learn through practical examples.

[cli-hardway]: http://cli.learncodethehardway.org/book/

## Ruby

The course currently supports Ruby version 2.1.2.

We highly recommend that you use [Mac OS X][osx-ruby-install] or Linux
for the course. If you are running one of those operating systems, you
should be able to install Ruby with little trouble. Linux users should
be able to follow along with the OS X install process, substituting the
appropriate Linux commands/packages where applicable (i.e., `sudo
apt-get` rather than `brew`). rbenv is Linux-compatible, and it's what
we'll use in the main course, so prefer to use it over other Ruby
version managers.

[osx-ruby-install]: http://github.com/appacademy/meta/setup/ruby.md

If you have no choice but to work on a Windows machine, there are a
couple options:

- [Run OS X or Ubuntu on a virtual machine][virtual-machines]
- [Install Ruby via the Ruby installer][ruby-installer-windows]

A virtual machine gives much more flexibility when it comes to Ruby
version management, and the environment will more closely resemble what
we'll use in the full course. Simply using the Ruby installer is,
however, easier in the short term. The approach you take is up to you,
but you are responsible for making sure that your machine can run the
specified Ruby version prior to pairing sessions.

[virtual-machines]: http://lifehacker.com/5204434/the-beginners-guide-to-creating-virtual-machines-with-virtualbox
[ruby-installer-windows]: http://rubyinstaller.org/

## Text Editor

For pair programming, we'll be using a collaborative online editor
called [Floobits][floobits]. It is probably best to register using your
Github username; this will make it easier us (and your partners) to find
you! Floobits has good voice and video integration, which makes
communicating with your partner much easier. It also has a built-in
workspace feature, which gives you a directory structure for organizing
your files ([here's a guide on that][floobits-setup]). If you decide
that the web editor isn't your style, Floobits also supports [Sublime
Text][sublime-text], a powerful cross-platform editor very similar to
[Atom][atom-editor], which we use in the main course.  Given these
advantages, we feel that Floobits is the logical choice of editor for
the pre-course. You will need to set up an account and a workspace, and
add your partner as a collaborator before you'll be able to pair.

[floobits]: http://www.floobits.com/
[floobits-setup]: ./floobits/
[sublime-text]: http://www.sublimetext.com/
[atom-editor]: https://atom.io/

## Slack

Slack is a chat client similar to IRC. It supports public and private
channels, private messages, formatted code blocks, and more. Slack is
our go-to app for team communication, and it will be your best bet for
chatting with classmates and getting assistance from TAs. You should
either install the desktop client, or bookmark the web version.

* [App Academy Slack Organization][aa-slack]

[aa-slack]: https://app-academy.slack.com/
