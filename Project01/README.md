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
Prompts user for **EXSTENSION** and returns the number of files with  **EXTENSION**.  
**EXTENSION** should not contain any whitespace characters. [WIKI](https://en.wikipedia.org/wiki/Filename_extension)
### Exmaple
```bash
CS1XA3/Project01/project_analyze.sh -fsl
```
## Custom Feature -a|-all 
Includes all files like .gitignore and .git etc
do option only got gitignore do allow only certain files depndeonding on the input
  ...
