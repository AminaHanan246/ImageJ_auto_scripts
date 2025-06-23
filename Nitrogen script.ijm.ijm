//Run a function in all the files in folder

// Select the directory containing the images
dir = getDirectory("C:/Users/Amina Hanaan Majeed/OneDrive/Documents/MAJ PROJECT/Stem/Nitrogen/K359W/1.6x");

// Get the list of files in the directory
list = getFileList(dir);

// Loop through each file
for (i = 0; i < list.length; i++) {
    filename = list[i];
    if (endsWith(filename, ".tif")) { // Process only .tif files
        // Open the image
        open(dir + filename);
        
        //scale values
        // x0.8 1mm 180px
        // x1 1mm 230px
        // x1.25 1m 277
        // x1.6 1m 373
        // x2 1mm 462px
        // x2.5 1mm 579px
        // x3.2 1mm 744px
        
        
run("Set Scale...", "distance=373 known=1 unit=mm global");        

        // Process the image
        setBackgroundColor(255, 255, 255);
        run("Clear", "slice");
        run("Create Mask");
        run("Invert");
        doWand(1323, 840);
        run("Measure");

       
        run("RGB Stack");

setAutoThreshold("Default no-reset");
run("Threshold...");
setThreshold(0, 0);
setOption("BlackBackground", true);
run("Convert to Mask", "background=Light calculate only black");



        // Create output filename for results
        resultFileName = dir + replace(filename, ".tif", "Pith.csv");

        // Analyze particles and save the results
        run("Analyze Particles...", "size=0.01-Infinity display stack");
        
        // Save the results to a unique file
        saveAs("Results", resultFileName);

        // Close the results table
        close("Results");

        // Close the images
        close();
     
    }
}

//////////////////////////////////////////////////////////////////

//ImageJ Macro to Open All Files in a Folder

// Select the directory containing the images
dir = getDirectory("C:/Users/Amina Hanaan Majeed/OneDrive/Documents/MAJ PROJECT/Stem/Nitrogen/K359W");

// Get the list of files in the directory
fileList = getFileList(dir);

// Open all images in the directory
for (i = 0; i < fileList.length; i++) {
    filename = fileList[i];
    if (endsWith(filename, ".tif") || endsWith(filename, ".jpg") || endsWith(filename, ".png")) { // Process only image files
        open(dir + filename);
    }
}

/////////////////////////////////////////////////////////////////////

//ImageJ Macro Code to Close All Open Images
// Get the list of all open images
imageTitles = getList("image.titles");

// Iterate through each open image and close it
for (i = 0; i < imageTitles.length; i++) {
    selectImage(imageTitles[i]);
    close();
}

///////////////////////////////////////////////////////////////////////

//apply function to all open images in a folder without closing the images

// Get the list of all open images
imageTitles = getList("image.titles");

function processImage() {
	//write the function script below
	 run("Clear");

}
// Iterate through each open image and apply the process
for (i = 0; i < imageTitles.length; i++) {
    selectImage(imageTitles[i]);
    processImage();
}

////////////////////////////////////////////////////////////////////////

//ImageJ Macro to Save and Close All Open Images with Modified Filenames

// Select the directory where you want to save the images
saveDir = getDirectory("C:/Users/Amina Hanaan Majeed/OneDrive/Documents/MAJ PROJECT/Stem/Nitrogen/K359W");

// Get the list of all open images
imageTitles = getList("image.titles");

// Loop through each open image
for (i = 0; i < imageTitles.length; i++) {
    // Select the image by its title
    selectImage(imageTitles[i]);

    // Extract the base name of the file (excluding the extension)
    baseName = substring(imageTitles[i], 0, indexOf(imageTitles[i], "."));
    
    // Construct the new filename by appending "R" to the base name
    newFilename = saveDir + baseName + "R.tif";

    // Save the image
    saveAs("Tiff", newFilename);

    // Close the image
    close();
}
