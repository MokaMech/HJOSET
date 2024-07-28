# HJOSET
Human Joints Orthosis Sizing and Evaluation Tools.
![Oscar Alley_modif](https://github.com/user-attachments/assets/a6d31301-eceb-4bde-ad63-b066caa7caec)

_______________________________________________________________________
This repository is linked to "On the design of simulation-assisted human-centered variable stiffness actuator ankle orthosis" article (Link available later)

It contains all the code and data elements necessary to set up the Human-Orthosis interaction simulation illustrated in the article.

## Article summary 
This article, among other things, describes the design and its application on a example of an early framework focused on several simulation software, enabling the study of a MoCap recorded task performed by a human user (walking, picking up an object from the floor, climbing stairs or a slope...) with or without external assistance provided by human-machine devices such as orthoses or exoskeletons.
_______________________________________________________________________
## Framework features 
The different tools proposed in this framework include:

- The use of OpenSim tools such as "Scaling", "Inverse Kinematics", "Inverse Dynamics", "Residual Reduction Algorithm" and "Computed Muscle Control". This sequence of tools enables, from motion capture data augmented with Ground Reaction Forces and Moments (GRFM), to successively determine joint kinematics from the task recording, calculate the joint torques required to generate these trajectories, and finally trace back to the muscle activation of the simulated musculoskeletal model that allows for the completion of this task.
This last function "CMC" is often used in two scenarios :
  * The possibility to add external assistance to the model and defining the actuation profile of this assistance.
  * Thanks to the muscle activation values with and without extra assistance, calculating a performance metric based on the variations in activity of certain muscles during        the task with assistance.

- In the case where motion capture data is not augmented with GRFM data, or to simulate the wearing of additional load not present during the task recording, a MatLab toolkit named "CusToM" presented in [Muller et al. 2019][^1] allows for the prediction of GRFM from the kinematic data and the characteristics of the simulated user.

- A code snippet is also present to extract the quasi-stiffness cycle (AQS cycles in the article) of a joint to define its torque response when generating a trajectory during the requested task.
  
- Moreover, this framework also proposes a Simulink block diagram pattern to define the actuation strategy of the assistance. It is possible to parameterize the number of active elements such as motors, or passive elements such as springs and their operating ranges and characteristics. A state machine also allows for the simulation of activation sequences of these actuators to simulate complex mechanism.
  
- At last, a code snippet is provided to define and calculate performance metrics of the assistance, as well as different graphical displays.
  
### Requirements
This framework mainly relies on both [OpenSim](https://simtk.org/projects/opensim) 4.4 software - an open free software offering tools to execute biomechanics analysis - and [Matlab](https://fr.mathworks.com/products/matlab.html?s_tid=hp_products_matlab) 2019 and earlier version.
Additionnal functions such as GRFM estimation need :
* Symbolic Matlab Toolbox
* Optimization Toolbox
* Parallel Computing Toolbox
* DSP System Toolbox or Signal Processing Toolbox
* Robotics System Toolbox

### Installation
- First step is to install the latest version of OpenSim (at least 4.0) and MatLab (at least 2019).
- If you want to compute GRF prediction since you lack this data, make sure your MatLab installation fullfill the requested toolbox described above.
- I recommand also to install Mokka software to preview, label MoCap data and translate it into other CusToM compatible formats.
- Since you get all those 3 software, paste the content of the **Matlab_tools/CusToM_master/Models** folder of this repo into your CusToM/Models installation directory. This will allow you to use the dedicated Gait2354 model and markers adapted from OpenSim to CusToM.

_______________________________________________________________________
## Experiment

### Dataset
The dataset used to illustrate this framework is drawn from a [project](https://simtk.org/projects/mspeedwalksims) available on SimTK forum and presented in [Liu et al. 2008][^2]
Only a part of this dataset was used to run a demonstration of the framework.

### How to use

### Repository content
This repository relies on two main folders.
 - The **Tools** folder house all you need to provide your Matlab environment with the custom code to run the different design tools.
   * "CusToM_Excel_process" folder archives all spreadsheets necessary to understand the GRF prediction protocol described in the article.
   * "CusToM-master" contains the "Models" folder to insert in your current CusToM install location. The "Mokadim_sim_GRF_prediction" folder stores the resultats of     each CusToM simulation to predict subjects GRF in backpack carrying conditions. "OpenSim_Utilities" contains all functions to extract, manipulate and reshape data    from OpenSim.
   * "markersLocationTF" stores the needed functions to swap from declared markersets in OpenSim to another one suitable with CusToM.
   * Finally, "Matlab" folder contains reshaped and augmented GIL data to be used to drawn AQS curves (see "Methods" section in the article for details), as well as
   all code to import/extract data from OpenSim .sto files, reshape and augment with subject features, draw and merge curves to get AQS cycles, and compute 
   evaluation metrics.  At last, it also includes Simulink projects for all retained subjects and speeds to let designers sketch their assitance strategy and test 
   it. 
   
 - The **Exemple** folder contains subfolders for each subjects retained from the [Liu et al. 2008] dataset for this framework exemple.
   Each folder follows the storage system below :
   Subject(GIL 6/8/11) > Speed(free/slow) > Load Condition(noLoad/Backpack/Backpack+Orthosis) > OpenSim tools results and models.
   A scaled version (raw and RRA adjusted) of the default Gait10DOF18muscl or modified version for the purpose of this experiment is also present in each subfolders.
    
   Along with the models, each folder stores the outputs of OpenSim analysis tools.
   - Analyze : Raw Kinematics and Markers coords in the world frame. Mostly to be used by the transform functions in the **Tools** folder for CusToM.
   - CMC : setup files including tracking tasks and reserve actuators, plus results folder. 
   - datafiles : Data (Kinematics and GRF) provided by the dataset.
                 Eventually may contain the CusToM-generated GRF for backpack conditions and the Simulink-generated orthosis control signal.
   - IK : Inverse kinematics setup file and results computed with the provided data
   - RRA : Reduce Residual Algorythm setup file and results. 
_______________________________________________________________________
**Citations** : 
[^1]: [Muller et al. 2019](http://joss.theoj.org/papers/10.21105/joss.00927)
[^2]: [Liu et al.2009](https://www.sciencedirect.com/science/article/pii/S0021929008003771?via%3Dihub)

