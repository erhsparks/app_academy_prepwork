# Pair Programming Setup

On the day of a pair project, you will be sent an email with the list of
pairs for the day. Find your name in the left-most column of the email;
on the right, you will find your partner's name, email, and Github handle. Get in
touch and follow these steps to get started:

0. Sign in to [Cloud9][cloud9] using your Github account.
0. Decide which partner will be the "host" the pairing session. Both
   partners will work in the host's workspace.
0. The host should add the "guest" as an editor on the workspace.
  * Click the **Share** button at the top right of the window.
  * Under "Invite People", enter your partner's username (most likely
    their Git handle). Make sure to give them **RW** (read/write)
    access.
0. The host should send the workspace link to the guest; at this point,
   both participants should be able to use the workspace's text editor
   and terminal.
0. Use [Skype][skype] to communicate and collaborate with your partner.
0. Remember to follow the [pair programming
   guidelines][pair-programming]!

[cloud9]: https://c9.io/
[pair-programming]: ./pair-programming.md
[skype]: http://www.skype.com/

## Sharing the Terminal

The workspace's terminal should be shared by default. If for some reason
you and your partner find yourselves looking at different terminals, you
should be able to get it back into a shared state by following these
steps:

#### USER A: Identify your TMUX session

```
  $ tmux display-message -p '#S'
  username@workspace_042
```

#### USER B: (on the same workspace) - switch to that terminal

```
  $ tmux switch -t username@workspace_042
```
