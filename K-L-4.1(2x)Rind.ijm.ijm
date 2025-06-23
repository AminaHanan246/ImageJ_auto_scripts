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



        
        // Analyze particles and save the results
        run("Analyze Particles...", "size=100-Infinity display stack");
        
        // Save the results to a unique file
        saveAs("Results", resultFileName);

        // Close the results table
        close("Results");

        // Close the images
        close();
        close();
    }
}
