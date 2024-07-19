# HJOSET
Human Joints Orthosis Sizing and Evaluation Tools.
_______________________________________________________________________
This repository is linked to "On the design of simulation-assisted human-centered variable stiffness actuator ankle orthosis" article (Link available later)

It contains all the code and data elements necessary to set up the simulation illustrated in the article.

## Article summary 
This article, among other things, describes the design and application on examples of an early framework focused on multiple simulation software, enabling the study of a task performed by a human user (walking, picking up an object from the floor, climbing stairs or a slope...) with or without external assistance provided by human-machine devices such as orthoses or exoskeletons.

## Requirements
This framework mainly relies on both OpenSim 4.4 software [^1] - an open free software offering tools to execute biomechanics analysis - and Matlab 2019 and earlier version [^2].
Additionnal functions such as GRFM estimation need :
* Symbolic Matlab Toolbox
* Optimization Toolbox
* Parallel Computing Toolbox
* DSP System Toolbox or Signal Processing Toolbox
* Robotics System Toolbox

## Content 
The different tools proposed in this framework include:

- The use of OpenSim tools such as "Scaling", "Inverse Kinematics", "Inverse Dynamics", "Residual Reduction Algorithm" and "Computed Muscle Control". This sequence of tools enables, from motion capture data augmented with Ground Reaction Forces and Moments (GRFM), to successively determine joint kinematics from the task recording, calculate the joint torques required to generate these trajectories, and finally trace back to the muscle activation of the simulated musculoskeletal model that allows for the completion of this task.
This last function "CMC" is often used in two scenarios :
  * The possibility to add external assistance to the model and defining the actuation profile of this assistance.
  * Thanks to the muscle activation values with and without extra assistance, calculating a performance metric based on the variations in activity of certain muscles during        the task with assistance.

- In the case where motion capture data is not augmented with GRFM data, or to simulate the wearing of additional load not present during the task recording, a MatLab toolkit named "CusToM" presented in Muller et al. 2019 [^3] allows for the prediction of GRFM from the kinematic data and the characteristics of the simulated user.

- A code snippet is also present to extract the quasi-stiffness cycle (AQS cycles in the article) of a joint to define its torque response when generating a trajectory during the requested task.
  
- Moreover, this framework also proposes a Simulink block diagram pattern to define the actuation strategy of the assistance. It is possible to parameterize the number of active elements such as motors, or passive elements such as springs and their operating ranges and characteristics. A state machine also allows for the simulation of activation sequences of these actuators to simulate complex mechanism.
  
- At last, a code snippet is provided to define and calculate performance metrics of the assistance, as well as different graphical displays.

_______________________________________________________________________
**Links and Citations** : 
[^1]: Download the lastest version of [OpenSim](https://simtk.org/projects/opensim)
[^2]: Download the lastest version of [MatLab](https://fr.mathworks.com/products/matlab.html?s_tid=hp_products_matlab)
[^3]: [Muller et al. 2019](http://joss.theoj.org/papers/10.21105/joss.00927)




