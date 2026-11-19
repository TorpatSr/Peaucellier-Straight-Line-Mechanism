## Project overview

- **Project name:** Peaucellier Straight-Line Mechanism
- **Problem / purpose:** The purpose of this project is to investigate how the Peaucellier–Lipkin mechanism converts rotational input into exact straight-line motion without requiring a sliding guide. The project focuses on analyzing the mechanism's degrees of freedom, workspace, and kinematic behavior using MATLAB Symbolic Math and Simscape Multibody. The analytical and simulation results are compared to verify the straight-line motion, while a physical prototype is built to demonstrate the mechanism's operation.
- **Team:** กลุ่มนี้ไม่ใช้เไ
- **Status:** Planning
- **Last updated:** [2026-11-10]
- **Group Members:**
  |Name|Student ID|
  |---|---|
  |Torpat Sirilattaporn|6730192621|
  |Thanayut Thawornpracha|6730222821|
  |Ruj Samarnworakit|6730454021|

## Repository structure

| Path | Purpose |
|---|---|
| `hardware/mechanical/` | CAD models, drawings, and fabrication files |
| `hardware/bom.csv` | Bill of materials with quantities, units, and sourcing details |
| `machine-skills/` | Machine commands, procedures, and skill instructions |
| `simulation/` | Models, scripts, assumptions, and simulation results |
| `docs/` | Assembly, setup, operation, and maintenance instructions |
| `media/` | Images, GIFs, and links to demonstration videos |
| `experiments/` | Procedures, raw data, and results |
| `publications/` | Project-related journal and conference papers |

## Collaboration and file practices

Use descriptive filenames and commit messages. Record units, revisions, software versions, and assumptions. Keep editable source files where practical. Avoid committing credentials, private data, temporary files, or duplicate exports. Consider Git LFS for large CAD, simulation, and video files.

## Safety and validation

Document hazards, safeguards, and operating limits before testing hardware. Validate important calculations and simulation results against measurements where practical.

## Part I: Basics including kinematic diagram, DoF analysis
![Peaucellier Straight-Line Mechanism kinematics diagram](media/kinematics.jpg)
*Figure 1. Kinematic diagram of the Peaucellier Straight-Line Mechanism.*

The Peaucellier Straight-Line Mechanism consists of **8 links**, including the ground, connected by revolute joints. Link 4 serves as the input crank, while joint G produces straight-line motion.

The main function of the Peaucellier Straight-Line Mechanism is to convert the rotational motion of the input crank (Link 4) into exact straight-line motion at output joint G. Unlike approximate straight-line mechanisms, its ideal geometry constrains G to move along a perfectly vertical line within the allowable working range.

### 1.1. Link and Joint Identification

| Link | Description | Length |
|:---:|---|:---:|
| 1 | Ground (O₂,O₃–O₄) | 35 mm |
| 2–3 | Connecting links (O₂–A, O₃–E) | 105 mm |
| 4 | Input crank (O₄–C,D) | 35 mm |
| 5–8 | Rhombus links (A–C, D–E, B–G, F–G) | 40 mm |

The mechanism has **6 physical revolute joint locations**: O₂/O₃, O₄, A/B, C/D, E/F, and G. Four locations connect three links each, giving **10 equivalent revolute joints**.

### 1.2. Degrees of Freedom (DOF)

Using the planar Grübler–Kutzbach equation:

$$
DOF = 3(n-1)-2J_1-J_2
$$

where:
- n = 8 links
- J₁ = 10 equivalent revolute joints
- J₂ = 0 higher pairs

The four ternary joint locations (O₂,O₃; A/B; C/D; E/F) each count as two equivalent revolute joints, while O₄ and G each count as one.

Substituting:

$$
DOF = 3(8-1)-2(10)=\boxed{1}
$$

The mechanism has **one degree of freedom**, controlled by the rotation of Link 4.

### 1.3. Workspace Analysis

The output joint G follows an exact vertical straight-line path. Using the link dimensions of a = 105 mm, b = 40 mm, and r = 35 mm, the workspace was evaluated in MATLAB.

| Parameter | Value |
|---|---:|
| Horizontal position (xG) | 134.64 mm |
| Input angle range | −43.00° to +43.00° |
| Vertical range (yG) | −53.04 to +53.04 mm |
| Total output stroke | **106.08 mm** |

The results confirm that joint G moves along a vertical straight line with a total evaluated stroke of **106.08 mm**.




## Part II: Symbolic Math for the Selected Mechanism

### 2.1. MATLAB Kinematic Simulation

The Peaucellier Straight-Line Mechanism was analyzed in MATLAB to demonstrate the straight-line motion of output joint G. Link 4 was selected as the input crank and driven at a constant angular velocity of 1 rad/s.

The simulation illustrates the mechanism's motion, the straight-line trajectory of point G, and its extreme positions within the working range.

- [View MATLAB Script (.m)](simulation/Symbolic%20Math/SymbolicMath.m)
- [Download MATLAB Live Script (.mlx)](simulation/Symbolic%20Math/SymbolicMath.mlx)

![Symbolic Math Results](media/SymbolicMath.gif)
*Figure 2. MATLAB simulation of the straight-line motion of point G.*

### 2.2. Governing Equations and Position Analysis

The Peaucellier Straight-Line Mechanism operates based on the geometric inversion principle:

$$
O_2(C,D)\times O_2G=a^2-b^2
$$

Taking O₂,O₃ as the origin and O₄ at (r, 0), the coordinates of the input joint C/D are:

$$
x_{C,D}=r(1+\cos\theta)
$$

$$
y_{C,D}=r\sin\theta
$$

The output position of point G is:

$$
x_G=\frac{a^2-b^2}{2r}=L
$$

$$
y_G=L\tan\left(\frac{\theta}{2}\right)
$$

where:

- a = 105 mm: Length of Links 2–3
- b = 40 mm: Length of Links 5–8
- r = 35 mm: Length of Link 4 and the ground distance O₂O₄

Substituting the dimensions:

$$
L=\frac{105^2-40^2}{2(35)}=134.643\text{ mm}
$$

Since the horizontal coordinate of G remains constant, point G follows an exact vertical straight-line path.

### 2.3. Extreme Positions, Workspace, and Stroke

The output workspace is determined by the allowable input angle range of Link 4.

The theoretical limiting angle is:

$$
\theta_{\mathrm{limit}}=
2\cos^{-1}\left(\frac{a-b}{2r}\right)
$$

To avoid the limiting configuration, a small angular margin of 0.01 rad is applied:

$$
\theta_{\max}=\theta_{\mathrm{limit}}-0.01
$$

The evaluated input range is approximately:

$$
-43.03^\circ\leq\theta\leq43.03^\circ
$$

The extreme vertical positions are:

$$
y_{\max}=L\tan\left(\frac{\theta_{\max}}{2}\right)
$$

$$
y_{\min}=-y_{\max}
$$

The total output stroke is:

$$
S=y_{\max}-y_{\min}=2y_{\max}
$$

The output workspace of G is therefore a vertical line segment at x = 134.643 mm, bounded by the upper and lower extreme positions.

### 2.4. Straight-Line Verification

The ideal straight-line path is defined by:

$$
x_G=L
$$

The horizontal deviation from the ideal path is:

$$
e_x(\theta)=x_G(\theta)-L
$$

Since x_G is constant, the theoretical straightness error is:

$$
e_x(\theta)=0
$$

Therefore, the ideal Peaucellier Straight-Line Mechanism generates an exact straight line within its allowable working range.

The analytical trajectory provides the reference for the Simscape Multibody comparison in Part III, where numerical deviations from the ideal straight line are evaluated.

![Straight-Line Motion Analysis](media/Analysis.png?v=2)
*Figure 3. Output workspace and extreme positions of point G.*


## Part III: Simscape Multibody 
### 3.1. Simulation Setup

The Peaucellier Straight-Line Mechanism was modeled in MATLAB R2026a using Simscape Multibody. The model uses the same link dimensions and kinematic configuration defined in Parts I and II.

The input angle $\theta$ was measured from the `Input_O4` Revolute Joint, while a Transform Sensor measured the horizontal and vertical positions of output point $G$ in the World frame. The crank completed one constant-speed sweep at $1\ \text{rad/s}$.

The recorded input range was $-43.0000^\circ$ to $+42.9437^\circ$. The small difference from the intended symmetric range of $\pm43^\circ$ results from the final discrete simulation time step.

The Multibody positions were compared with the Symbolic Math results from Part II at the same recorded crank angles.

Relevant files:

- [Simscape Multibody model](simulation/multibody/Peaucellier.slx)
- [Result-analysis script](simulation/multibody/plot_peaucellier_results.mlx)

### 3.2. Extreme Positions and Working Space

The working extremes were identified from the minimum and maximum vertical positions of point $G$.

| Configuration | Crank angle | $x_G$ | $y_G$ |
|---|---:|---:|---:|
| Lower extreme | $-43.0000^\circ$ | 134.642857 mm | −53.037232 mm |
| Center sample | $-0.0282^\circ$ | 134.642857 mm | −0.033094 mm |
| Upper extreme | $+42.9437^\circ$ | 134.642857 mm | +52.960789 mm |

The Multibody working stroke was therefore

$$
S_{\mathrm{MB}}=105.998021\ \text{mm}.
$$

The center sample is slightly displaced from exactly $0^\circ$ because the results are stored at discrete time steps. The horizontal coordinate remains effectively constant throughout the sweep, so the working space of point $G$ is a vertical line segment.

### 3.3. Symbolic–Multibody Comparison

| Quantity | Result |
|---|---:|
| Symbolic Math stroke | 105.998121 mm |
| Simscape Multibody stroke | 105.998021 mm |
| Stroke difference | $-1.00422\times10^{-4}$ mm |
| Maximum vertical-position difference | $2.11812\times10^{-4}$ mm |
| Maximum horizontal deviation | $5.90035\times10^{-11}$ mm |
| Straightness band | $5.90319\times10^{-11}$ mm |

The Symbolic Math and Multibody vertical-position curves overlap throughout the simulated range. Their stroke values differ by approximately $0.000100$ mm, while the maximum vertical-position difference is approximately $0.000212$ mm. These small differences are attributed to solver tolerances, interpolation, and discrete time sampling.

Straightness was evaluated from the transverse error

$$
\Delta x_G = x_{G,\mathrm{MB}} - x_{G,\mathrm{symbolic}}.
$$

The maximum transverse deviation was $5.90\times10^{-11}$ mm, which is far below the selected numerical tolerance of $1.0\times10^{-6}$ mm. The visible fluctuations in the straightness-error graph therefore represent numerical noise rather than physical curvature of the path.

![Part III Simscape Multibody results](media/figure_1_new.png)

*Figure 4. (a) Simscape Multibody model. (b) Workspace and extreme positions of point G. (c) Symbolic–Multibody position comparison. (d) Transverse straightness error.*

### 3.4. Conclusion

The Simscape Multibody results agree closely with the Symbolic Math analysis. Point $G$ completed a working stroke of $105.998021$ mm while maintaining an effectively constant horizontal position.

The measured transverse deviation remained within the numerical precision of the solver. The ideal Multibody model can therefore be considered to reproduce the theoretical straight-line motion over the evaluated working range.

The video shows one complete cycle, with the output pin traversing its full operating range. [Download Video (.avi)](media/Peaucellier.avi)
![Mechanism.gif](media/Peaucellier.gif)


## Part IV: Built Mechanism
![Top View](media/iso.png)
![Isometric](media/overview.png)
<img width="1108" height="1477" alt="Overview hardware" src="https://github.com/user-attachments/assets/c8a97f3c-5698-4811-ba48-8e29fe709cd5" />


https://github.com/user-attachments/assets/3cfc7d60-94a3-4b69-b03c-a9fcc0345cbf


