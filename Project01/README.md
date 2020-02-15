#  CS 1XA3 Project01 - rapopord

## Installation
   Copy this repository into desired location with:  
   ```
   git clone https://github.com/fafusha/CS1XA3/
   ```
  
   Execute this script from the installation location with:  
   ```
   chmod +x CS1XA3/Project01/project_analyze.sh
   ````
 ## Usage
```
CS1XA3/Project01/project_analyze.sh [OPTION]... [FILE]...
```
Perfoms analysis of the FILEs (current CS1XA3 repository by default).
   
With possible **OPTION**
* `-fm, --fixme` lists all files with `#FIXME` in the last line, creates *file.log* at `CS1XA3/Project01/`.
* `-fsl, --file-size-list` list all files and corresonding size in descending order.
* `--ftc, --file-type-count` prompts user for **EXSTENSION** and returns the number of files with  **EXTENSION**.
      

## Feature 6.2 **FIXME Log**
### About
Lists all files with `#FIXME` in the last line, creates *file.log* at `CS1XA3/Project01/`, which contains relative filepaths to main repository folder.
 
### Example
```bash
CS1XA3/Project01/project_analyze.sh -fm
```
   
## Feature 6.4 **File Size List**
### About
List all files and corresonding size in descending order, divided by subdirectories.
### Example
```bash
CS1XA3/Project01/project_analyze.sh -fsl
```
## Feature 6.5 **File Type Count**
## About
Prompts user for extenstion and returns the number of files with extension.  
Extension should not contain any whitespace characters. [Wikipedia](https://en.wikipedia.org/wiki/Filename_extension)
### Exmaple
```bash
CS1XA3/Project01/project_analyze.sh -fsl
```
## Custom Feature I Unix Philosphy
In order to make our program more modular and reusable we need to follow UNIX Philosphy.  
One of the UNIX paradigms is :"Write programs to work together".  
To make this program better with other scripts we need to add more `[OPTIONS]` common to many other bash commands. These options include, but are not limited to:  
`-h, --help`: help referfence for options  
`-f, --force`: do not raise errors for invalid inputs  
`-q, --qiet`: display no output     
Part of this was already implemented in the script input. On the possible arguments to the script is `[FILES]`. It allows the user to specify the files on which script should operate and does not limit usability of the script to a single directory.  
Refernce: [Wikpidea](https://en.wikipedia.org/wiki/Unix_philosophy)

## Custom Feature II Dividing Directories in files Into Groups
This features allows user to divide files in the repository in customs groups. Each group  is assigned a custom tags. By creating these tags and divding diles into groups user could apply same opertion to all files in the custom group.

### Example
Creating custom group tag:
```bash
CS1XA3/Project01/project_analyze.sh -t [TAG]
```
Adding file into the group with:
```bash
CS1XA3/Project01/project_analyze.sh -at [TAG] [FILE]...
```
Listing all files in the grpoup: 
```bash
CS1XA3/Project01/project_analyze.sh -at [TAG]
```

Example: removing all files with a tag:

```bash
CS1XA3/Project01/project_analyze.sh -at [TAG] | rm
```
