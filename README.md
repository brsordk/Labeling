# **User's Guide**



### System Requirements
This algorithm is developed using a CAD software and MATLAB R2023b; hence, system requirements are identical to those required for MATLAB. The following toolboxes should be installed before running the algorithm:
-	Statistics and Machine Learning Toolbox
-	Computer Vision Toolbox 
-	Image Processing Toolbox

It is recommended to install the newest version of MATLAB software.

In case of using CAD models as inputs, the algorithm requires a CAD processing software with the following properties:

-	The CAD tool is able to export images of CAD models automatically (e.g., SolidWorks Task Scheduler)
-	The default template of the CAD tool is set to have no shadow and no background graphics.

### Instructions to Run the Software
**Step 1:** Ensure you have the newest version of MATLAB and a CAD software are installed on your computer. Install the aforementioned toolboxes as MATLAB add-ins. Then, use the CAD software you have installed in your computer to extract images from CAD models. Below you can find the steps to export images using SOLIDWORKS Task Scheduler, but you can use another CAD software to acquire the images.
-	Open SOLIDWORKS and set the default template properties as no background and no shadow
-	Open SOLIDWORKS Task Scheduler
-	Select the folder that contains the CAD models
-	Specify the extracted file type as image (e.g., jpeg or PNG)
-	Specify the folder to save the extracted images

**Step 2:** Open **AMvsTM.m** file from the directory. This file contains the code for reading the images and clustering them. This code is responsible for the functionality of the software, so it is important to avoid making unexpected changes to the source code unless you have a good understanding of the implications of those changes. Download and store the file named **Labeled Images.xlsx** in the same location as the **AMvsTM.m** file.
**Labeled Images.xlsx** file contains five initially AM-labeled parts.


Note: The proposed software was configured by default to operate with .JPG images. However, additional image formats such as .PNG, .TIFF among others are supported, if they are not encrypted.

 **Step 3:** After opening the file, specify the location of the image folder by copying it from your computer’s directory. 

 **Step 4** Execute AMvsTM.m, simply click on the "run" button in the MATLAB environment. After executing the code, the algorithm will generate three figures. The following figures are the outputs of the algorithm:
 
-	Figure 1: Resulting dendrogram with two clusters
-	Figure 2: Images that are in Additive Manufacturing Cluster
-	Figure 3: Images that are in Traditional Manufacturing Cluster

The algorithm also saves and exports an “.XLSX” file containing clusters of each image in the dataset.

**Step 5** Visualize the resulting clusters and the dendrogram.

## LICENSE

GNU General Public License v3.0
