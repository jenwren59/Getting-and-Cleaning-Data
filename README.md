Getting-and-Cleaning-Data
=========================

Coursera Class Project

This repository contains a program that demonstrates how to obtain data from a website and use it to construct a tidy data set. It is also a first attempt for me at creating markdown files and building workflow in Git.

There is one program here for the project that is titled run_analysis.R. It picks up a zipped folder from a specified URL, unzips it, and identifies the contents. After reading the project instructions, the needed files were identified and read into R. One of the TA's (David Hood) provided a nice graphic that shows how the files should be manipulated to get the desired result:

https://coursera-forum-screenshots.s3.amazonaws.com/ab/a2776024af11e4a69d5576f8bc8459/Slide2.png

The gist of the program includes the following steps:
- correctly attaching the data unique keys to two sets of data
- stacking the two data sets
- merge a label to one of the unique keys. This is done after attaching the keys with a merge step. The order of steps is important so as not to reorder the unique keys in step one
- there were 563 columns obtained in the data. Subset the data based on a criterion where the measures contain "mean" or "std". I choose not to include measures with "meanFreq" or "gravityMean" since these may not be true means.
- get averages of all columns in the subset per subject and activity (the two unique keys)
- create a tidy data set. I interpreted this as a very tall data set. I used tidyr to transpose the 66 columns into one measure by subject, activity, and "Measures" ( the new column label for a field containing 66 unique levels). The resulting structure has dimension 11,880 rows and 4 columns (the flat data set had 180 rows and 68 columns)
- order the results by subject, activity and Measure
- write the result out to a text file. Show code after that to read the data back into R.

Good project! Thanks, Coursera!
