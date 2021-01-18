# Project-Candygram
A screenshot reader that interprets data for Silph Road's Candygram research project for the purpose of automating the process of uploading data. Future iterations may include support for other Silph Road research projects as well as support for alternate resolutions. This project takes input screenshots for Pokemon released and determines the amount of XL candy received from the next screenshot, storing all important data (date, specie, IV's, etc), and exports it as a spreadsheet. Bulk uploading is supported.

# Requirements
This program was written in MATLAB R2020b. Running this code requires a working version of MATLAB (the closer to R2020b the better, but it should work on other versions) as well as MATLAB's Computer Vision Toolbox. This program was written to support screenshots on the Samsung Galaxy S10 Lite (1080x2400 pixel screenshots) device. While it may be possible to resize screenshots from phones of different resolutions, I do not have other phones to test this on so I can't guarantee any results. If people are interested, I may develop a version of this program which is able to interpret data regardless of screenshot size and distortions. 

# How To Use
The main function for this project is located in *candygram.m*. The program takes no arguments, so just call the *candygram* function and the program will run. All screenshots that you want interpreted must be placed in the *Images* folder and must be in *.jpg* format.
