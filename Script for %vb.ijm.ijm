//ImageJ Macro to Open All Files in a Folder

// Select the directory containing the images
dir = getDirectory("Select the folder containing the images");

// Get the list of files in the directory
fileList = getFileList(dir);

// Open all images in the directory
for (i = 0; i < fileList.length; i++) {
    filename = fileList[i];
    if (endsWith(filename, ".tif") || endsWith(filename, ".jpg") || endsWith(filename, ".png")) { // Process only image files
        open(dir + filename);
    }
}



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

        selectImage(filename);
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
        close();
    }
}

//ImageJ Macro Code to Close All Open Images
// Get the list of all open images
imageTitles = getList("image.titles");

// Iterate through each open image and close it
for (i = 0; i < imageTitles.length; i++) {
    selectImage(imageTitles[i]);
    close();
}

//apply function to all open images in a folder without closing the images

// Get the list of all open images
imageTitles = getList("image.titles");

// Iterate through each open image and apply the process
for (i = 0; i < imageTitles.length; i++) {
    selectImage(imageTitles[i]);
    processImage();
}