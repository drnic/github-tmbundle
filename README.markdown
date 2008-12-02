GitHub TextMate bundle
--------------------

Contains the following commands specific to the current file:

* Show in GitHub - opens the current file in github, and selects the same lines that are selected in the current file
* Annotate/Blame/Comment Line - finds the original commit where this line was created and opens that commit in GitHub, whereby you can use the GitHub comment feature

Contains the following commands specific to the repository:

* Show Network in GitHub - opens the "Network" view in GitHub so you can see who has interesting commits that you don't have

Contains the following commands for creating [gists](http://gist.github.com):

* Create gist from selection - will create a gist using your GitHub credentials (see below). It will either use the current selection, or the whole file, using the filename and the currently active language. The URL of the gist will be copied to your clipboard.
* Create private gist from selection - same as above, but the Gist will be private.

Prerequisites
=============

The bundle requires Ruby, RubyGems, and the 
[git](http://www.jointheconversation.org/rubygit/) RubyGem:

		sudo gem install git

Installation
============

To install via Git:

		mkdir -p ~/Library/Application\ Support/TextMate/Bundles
		cd ~/Library/Application\ Support/TextMate/Bundles
		git clone git://github.com/drnic/github-tmbundle.git "GitHub.tmbundle"
		osascript -e 'tell app "TextMate" to reload bundles'

Source can be viewed or forked via GitHub: [http://github.com/drnic/github-tmbundle/tree/master](http://github.com/drnic/github-tmbundle/tree/master)

To install without Git:

		mkdir -p ~/Library/Application\ Support/TextMate/Bundles
		cd ~/Library/Application\ Support/TextMate/Bundles
		wget http://github.com/drnic/github-tmbundle/tarball/master
		tar zvf drnic-github-tmbundle*.tar.gz
		rm drnic-github-tmbundle*.tar.gz
		mv drnic-github-tmbundle* GitHub.tmbundle
		osascript -e 'tell app "TextMate" to reload bundles'

To enable [Gist](http://gist.github.com) support, make sure you've followed the instructions on your [account page](https://github.com/account) for adding your GitHub user and API Token to your global Git config. You can
create gists without specifying your credentials, but they won't be associated with your account.

Author
======

Dr Nic Williams, drnicwilliams@gmail.com, [http://drnicwilliams.com](http://drnicwilliams.com)

With contributions from: 
 
* [Pedro Melo](http://github.com/melo)
* [Mathias Meyer](http://github.com/mattmatt)
* [Geoff Cheshire](http://github.com/gtcaz)
