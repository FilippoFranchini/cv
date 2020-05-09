# Forked and edited from https://github.com/nstrayer/cv

## Main changes

- Made as an R-package for a cleaner strucutre and easier execution.
- Took out google sheet dependency that caused crashes when compiling pdf. Deleted related functions.
- Bug fix in css file that was causing errors during compiling.
- Everything depends on .csv files stored in the /csvs folder.
- Cleaned .Rmd file for easier interpreatation.

## Structure

This repo contains the source-code in R-package format. To load the package on your machine perss `Ctrl + Alt + L`.

The main files are:

- `FFranchini_CV.Rmd`: Source template for the cv. Rename it.
- `FFranchini_CV.html`: The final output of the template in html format.
- `FFranchini_CV.pdf`: The final exported pdf as rendered by Chrome on my mac laptop.
- `/R`: Folder with functions that help to build your cv. Do not worry about them, they will work in the background.
- `/csvs`: Folder with containing a series of CSVs with information about your CV. These CSVs have to be modified with your own personal information, education and experience.
- `/css`: Directory containing the custom CSS files used to tweak the default 'resume' format from pagedown. 

## Want to use this to build your own CV/resume? 

1. Fork, clone, download the zip of this repo to your machine with RStudio.
2. Update the contents of the CSVs stored in the `csvs/` folder. 
3. Go through and personalize the supplementary text in the Rmd you desire.
4. Print each unique `section` (as encoded in the `section` column of `positions.csv`) in your `.Rmd` with the command `position_data %>% print_section('education')`.
5. Get the PDF out by pressing `Ctrl+ Alt + K`.



