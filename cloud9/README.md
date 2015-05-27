# Cloud9

[Cloud9][cloud9] will be our environment of choice for pair programming
during App Academy Prep. It has many of the same features as more
powerful desktop editors like Sublime Text or Atom, along with a
built-in terminal and robust support for collaboration.

### Registration

We encourage you to register for Cloud9 with your Github account. This
will automate some nice integrations with Github, and has the nice side
effect of allowing us to more easily find your workspace.

### Creating a workspace

There should be a button on the left-hand side of the window labeled
"Create a New Workspace". Click this button and you'll see something
like this:

![Creating a workspace](images/create_workspace.png)

Name your workspace "appacademy-prep" and choose the **Custom** option.
Once you've filled out the form, click the "Create" button below. You
can enter the workspace by selecting it from the menu on the left and
then clicking the "Start Editing" button.

![Entering the workspace](images/enter_workspace.png)

If you've chosen the "Full IDE" option, your workspace will look
something like this:

![Full IDE](images/full_ide.png)

Once you've entered the workspace, the basic workflow will be:

0. Create folders and files using the tree navigator on the left.
0. Write your Ruby code in the text editor, top and center.
0. Run your code in the terminal at the bottom.

The terminal behaves almost exactly as it would on a Mac. You can
install gems and run the programs you've written with commands like
`ruby hello_world.rb` This will allow you to see any output and error
messages produced by your program.

### Settings

You'll find that Cloud9 has good support for customization; you can
tweak the color scheme, window arrangement, and such to your heart's
content. Before you start working, please take the time to apply the
following settings. Our office workstations are configured to use these
options, and we feel this is the most sensible configuration for Ruby
development.

#### View (accessible from the top navigation bar)
* Wrap Lines: on
* Wrap to Print Margin: on

#### Preferences (under Cloud9, or by pressing `CMD + ,`)
##### Project Settings > Code Editor (Ace)
* Soft Tabs: 2 spaces

##### Settings > User Interface
* Use an Asterisk (\*) to Mark Changed Tabs: on

##### Settings > Code Editor (Ace)
* Auto-pair Brackets, Quotes, etc.: on
* Wrap Selection with Brackets, Quotes, etc.: on
* Highlight Active Line: on
* Highlight Gutter Line: on
* Show Gutter: on
* Show Print Margin: on, set to 80

### Recommended file structure

We recommend organizing your projects first by week, then by day. This
has been the easiest to work with in our experience:

```
appacademy-prep/
 |- w1/
 |  |- w1d1/
 |  |  |- array.rb
 |  |
 |  |- w1d2/
 |
 |- w2/
```

### Pair Programming in Cloud9

Please see our [pairing setup][pairing-setup] guide!

[pairing-setup]: ../pairing-setup.md
