![Oscar Alley_modif](https://github.com/user-attachments/assets/6a2205a6-f152-4860-9dfa-d272e03285e0)
# Human Joints Orthosis Sizing and Evaluation Tools.
_______________________________________________________________________
This repository is linked to "On the design of simulation-assisted human-centered variable stiffness actuator ankle orthosis" article (Link available later)

It contains all the code and data elements necessary to set up the Human-Orthosis interaction simulation illustrated in the article.

## Article summary 
This article, among other things, describes the design and its application on a example of an early framework focused on several simulation software, enabling the study of a MoCap recorded task performed by a human user (walking, picking up an object from the floor, climbing stairs or a slope...) with or without external assistance provided by human-machine devices such as orthoses or exoskeletons.
This framework was used to help design a personnalized assistance for each simulated subjects. Designs performances was then evaluated regarding muscular joint torque savings.  
_______________________________________________________________________
## Framework features 
The different tools proposed in this framework include:

- The use of OpenSim tools such as "Scaling", "Inverse Kinematics", "Inverse Dynamics", "Residual Reduction Algorithm" and "Computed Muscle Control". This sequence of tools enables, from motion capture data augmented with Ground Reaction Forces and Moments (GRFM), to successively determine joint kinematics from the task recording, calculate the joint torques required to generate these trajectories, and finally trace back to the muscle activation of the simulated musculoskeletal model that allows for the completion of this task.
This last function "CMC" is often used in two scenarios :
  * The possibility to add external assistance to the model and defining the actuation profile of this assistance.
  * Thanks to the muscle activation values with and without extra assistance, calculating a performance metric based on the variations in activity of certain muscles during the task with assistance.

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

### How to use
Here is an overview of the HJOSET workflow to study a motion, with and without any extra device assistance.
![Framework_workflow](https://github.com/user-attachments/assets/94bc3d41-9c16-4ef2-bfc7-c97aa17cc5a2)
[HJOSET_workflow.pdf](https://github.com/user-attachments/files/16405244/HJOSET_workflow.pdf)

#### Step 0 (Optional) : Run the CusToM matlab toolbox to estimate GRFM from your MoCap data
- First thing is to gather your MoCap data, idealy with ground reaction forces and moments (GRFM).
- If GRFM is missing, run the CusToM toolbox. Once your model setting is done, run the pipeline till "GRF estimation" to get the missing data according to the provided kinematics.
  Instructions to start and run this toolbox can be found in the "exmeples" folder of CusToM. Follow ex.1 for GRF estimation.
- CusToM also provide tools to add extra load onto your model to simulate load-carrying task.
- In [Mokadim et al. 2024], a methodology is provided to estimate an extra-load carrying user GRFM based on the recorded no extra-load user GRFM while ignoring inconsistencies between OpenSim and CusToM model definitions.
  
#### Step 1 : Run the OpenSim tools pipeline
- First, choose a neuromuscular model to scale according to your needs.
- Get a static pose of the subject to run the **Scale** tool to fit the OpenSim model with the MoCap one. Make sure to add the markers from your static pose to your OpenSim models.
- Once done, run the **Inverse Kinematics** tool.

For the next steps, you will need the GRFM data matching the task kinematics.

- You may be interested in **Inverse Dynamics** right after IK. Else, run the **Residual Reduction Algorithm** tool to refine your model and your kinematics for the next step.
  
*Hint* : You may run this tool twice, first to get the COM-corrected model, then the second one applied onto the newly obtained model to get the matching corrected kinematics that minimize the residual.

- Finally, run the **Computed Muscle Control** tool to obtain the muscle excitation signals, joint positions, velocities and torques.  

Default config files are provided with OpenSim exemples for each tool. You may want to edit them if you want to loop steps faster and easier.

#### Step 2 : Compute the Quasi-Stiffness cycle to design a cyclic-task torque-assisting device
- Since your subject is executing a cyclic motion, such as walking, running, climbing stairs up or down and so on, you can define a **joint quasi-stiffness cycle** (QSC)
- First thing is to plot a joint torque response against the angular position. If you get a looped plot, here is a QSC cycle you can use to define your device assistance profil.
- If not, in case your MoCap data are not available on a whole task cycle, you can filter/merge data (use Matlab or a spreadsheet with graphs for that ) until you get a QSC.
  
#### Step 3 : Design your ideal device
- Once you are done with obtaining the QSC, you can use it either to loop define and test passives actuators stiffness like springs, or use the cycle as an active actuator controler input such as motor.
  Use the Simulink project template to declare your actuating strategy and global mechanism to simulate the torque response of your device.
The default Simulink project blocks are divided into 2 sections : main actuators are passives, and active actuators are implemented to supply the missing torque (up to a specific limit) between passive actuators and QSC reference.
One if free to implement an other stategy, or just bypass any unwanted feature.

**Warning**
As expected in the Simulink project, QSC torque component should be expressed in Nm/deg/**Kg**.
This allow the designer to scale its assistance based on the amount of "weight" the device should relieve. A “weight assistance” gain block is provided for this purpose.

- After that, you can check the torque generation split between scaled active and passive actuators to better observe the device inner torque generation. 
- Once the torque error between your ideal unscaled device assitance and the subject's joint QSC is low enough, you can export the ouput control signal as a device controler for **OpenSim CMC** tool into a *.sto* file.
  
#### Step 4 : Evaluate its performances
The authors of [Mokadim et al.2024] wish to compare the muscle activity of a simulated user walking without additional load with that of a user wearing a backpack and an ankle-foot orthosis on both legs.
As in the modified Gait10DOF18Musc models wearing orthosis provided in the repository, it is possible to use the OpenSim "Bushing Forces" to add compliant links between the device(s) and the body model for a more realistic representation.

- Modify your model by adding an additional load or device by editing the .osim file. 
- The next step consists in re-runing OpenSim **RRA** and **CMC** tools with an augmented model based on your task study and the device you wish to test.
- One can edit the mass and inertia properties of the existing ankle-foot orthosis, or design another simple joint orthosis with mass and inertia properties.
- When proceeding to the **CMC** tool, tick the "Actuator constraints" checkbox and provide your device controller *.sto* file.
- The final result files you get from the **CMC** tool now display the effets of your design. The final step consists in using the "ComputeAFOmetrics" evaluation script to compute metrics based on the 2 different conditions results.
Again, one is free to add/modify the metrics computed in the script if needed.
   
_______________________________________________________________________
## Article experiment

### Dataset
The dataset used to illustrate this framework is drawn from a [project](https://simtk.org/projects/mspeedwalksims) available on SimTK forum and presented in [Liu et al. 2008][^2]
Only a part of this dataset was used to run a demonstration of the framework.

### Results
The results presented in the article are stored in the "Exemple" section of this repository. The folder structure is explained above.
 
_______________________________________________________________________
**Citations** : 
[^1]: [Muller et al. 2019](http://joss.theoj.org/papers/10.21105/joss.00927)
[^2]: [Liu et al.2009](https://www.sciencedirect.com/science/article/pii/S0021929008003771?via%3Dihub)

