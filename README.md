This project uses LaTeX to keep a research diary on your Linux system, with useful tools and scripts to simplify the process. It is forked from mikhailklassen's research diary, but there are some major new features here.

## Adding entries

Run `./today` from the source directory of the repository. This will create a new file within the current year's directory named `current_date.tex` (e.g. `2017-09-04.tex`). Then it opens the file in Kile (replace your favourite TeX editor, if necessary).

If you run `./today`, but the day's file already exists, it skips the fle creation, and only opens the document in Kile for editing.

Place your images within subfolders named after the date in in the `images` directory.

### Project names

You can add project names to your entries with the `./today` command. Usage may differ depending on the scenario. At first call, you can use

	$ ./today project1 project2 etc.
	
which will add the corresponding lines to `./src/projects` (see below).

Or if you would like to add project tags later, then you can use

	$ ./today -p project1 project2 etc.
	
which will write the necessary lines to `./src/projects`, but won't open the file itself.

## Compiling the day's entry

There is a possiblity to compile the day's entry standalone with the `./today compile` command. But usually, just use your TeX editors commands to do the trick while editing. Do not forget BibTeX compilation for your references!

## Includes

You can put your favourite commands and environments into separate files that will be included into all of your generated tex. Just type the filenames without the `.tex` ending into `src/include` line by line.

## Bibliography management

There is a folder `biblio` in the root folder of the repository. The bib files intended for use in this project are placed here.

In the `src/bibinclude` file, the lines list the bibliography files to include in current project/in the current day's files. They are going to be added with `biblatex`'s `\addbibresource{...}` command.

## Creating anthologies

### Yearly

At the end of the year, to create a master file with all the entries of that year, you must modify the Makefile, specifying the year you wish to compile, and setting your name and institution. After this, save your modified Makefile and from the research diary main directory type

	$ make anthology

This will create a PDF will all the entries from the year specified. 


## By project

You can add tags to your diary entries, and later compile files based on that specific tag.

The file `projects` links the files to the project names. For older entries, you still have to add the entries manually, and you have to include the yearly folder name before the filename. e.g.

	$ 2018/2018-02-04.tex,some_project
	
But `./today` script is capable of automatically adding project tags, see above.

Then to compile files belonging to that project, use

	$ make project name=some_project

This will create a PDF containing all entries.

## Cleaning

To clean up you main directory after compilation, type

	$ make clean

And that's it!

Happy researching!

