GitHub TextMate bundle
--------------------

Contains the following commands specific to the current file:

* Show in GitHub - opens the current file in github, and selects the same lines that are selected in the current file
* Annotate/Blame/Comment Line - finds the original commit where this line was created and opens that commit in GitHub, whereby you can use the GitHub comment feature

Contains the following commands specific to the repository:

* Show Network in GitHub - opens the "Network" view in GitHub so you can see who has interesting commits that you don't have

Prerequisites
=============

The bundle requires Ruby, RubyGems, and the 
[git](http://www.jointheconversation.org/rubygit/) RubyGem:

		sudo gem install git

Installation
============

To install via Git:

		cd ~/"Library/Application Support/TextMate/Bundles/"
		git clone git://github.com/drnic/github-tmbundle.git "GitHub.tmbundle"
		osascript -e 'tell app "TextMate" to reload bundles'

Source can be viewed or forked via GitHub: [http://github.com/drnic/github-tmbundle/tree/master](http://github.com/drnic/github-tmbundle/tree/master)

To install without Git:

		wget http://github.com/drnic/github-tmbundle/tarball/master
		open drnic-github-tmbundle*
		rm drnic-github-tmbundle*.tar.gz
		mv drnic-github-tmbundle* GitHub.tmbundle
		osascript -e 'tell app "TextMate" to reload bundles'

Either way, restart TextMate or select "Reload Bundles" from the Bundles >> Bundle Editor menu.

Author
======

Dr Nic Williams, drnicwilliams@gmail.com, [http://drnicwilliams.com](http://drnicwilliams.com)