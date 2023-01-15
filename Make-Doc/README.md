the make file in this folder contains a Architecture.md file for dokcumentation. it requires 2 .png files to show.
changes are done on .drawio files. the make file has targets for _generate_ and for _clean_

% is a substitution for all of the matching targets

_make clean_ will remove all .png files

_make all_ will generate the .png files

_make -j 2 all_ will generate the .png files in two concurrent jobs
