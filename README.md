## Project overview

- **Project name:** Peaucellier Straight-Line Mechanism
- **Problem / purpose:** 
- **Team:** กลุ่มนี้ไม่ใช้เไ
- **Status:** Planning
- **Last updated:** [2026-11-03]
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

## Part II: Symbolic Math for the selected mechanism : submit your script in the text box
The Peaucellier–Lipkin mechanism was modeled in MATLAB R2026a using Simscape Multibody. The planar assembly contains seven moving rigid links and ten revolute joints. The pin-to-pin lengths of the long links, rhombus links, and input crank are 105 mm, 40 mm, and 35 mm, respectively. The crank was driven sinusoidally through ±30° with a period of 8 s. One complete cycle was simulated with a fixed time step of 0.01 s.

A Transform Sensor measured the position, velocity, and acceleration of the output pin center $P$ in World coordinates. The simulated motion was compared with the analytical relation $y_P = x_0 \tan(\theta/2)$, where $x_0 = 134.643$ mm is the nominal horizontal position and $\theta$ is the prescribed crank angle.


<!-- Add the figure to figures/figure_1.png, then uncomment these two lines.
![Simscape model, output trajectory, vertical velocity, and vertical acceleration](figures/figure_1.png)
**Figure 1.** (a) Simscape Multibody model showing the fixed pivots and output point $P$. (b) Measured trajectory of $P$. (c) Vertical velocity and (d) vertical acceleration compared with analytical predictions.
-->

**Table 1. Numerical results for one input cycle.**

| Quantity | Result |
| --- | ---: |
| Vertical stroke of point $P$ | 72.155 mm |
| Peak vertical speed | 0.027685 m/s |
| Peak vertical acceleration magnitude | 0.023305 m/s² |
| Maximum horizontal deviation from the theoretical line | $5.98 \times 10^{-11}$ mm |
| Maximum absolute difference in vertical velocity from the analytical prediction | $1.01 \times 10^{-14}$ m/s |
| Maximum absolute difference in vertical acceleration from the analytical prediction | $8.14 \times 10^{-12}$ m/s² |

The output followed a vertical path and reversed direction at each end of the stroke. The largest acceleration difference occurred at $t=0$.

<!-- Add the AVI to media/Mechanism.avi at the repository root, then uncomment the line below.
[Download the simulation video (Mechanism.avi)](../../media/Mechanism.avi). The video shows one complete cycle, with the output pin traversing its full operating range.
-->

## Part III: Simscape Multibody 
### 1.1. Governing Equations and Position Analysis
The Peaucellier Straight-Line Mechanism operates based on the geometric inversion principle, which relates the distances from the fixed pivot O₂ to the input joint C,D and output joint G:
$$
O_2(C,D)\times O_2G=a^2-b^2
\tag{1}
$$
Taking O₂ as the origin and O₄ at (r, 0), the input joint C,D moves along a circular path as Link 4 rotates. Its coordinates are expressed as:
$$
x_{C,D}=r(1+\cos\theta)
\tag{2}
y_{C,D}=r\sin\theta
\tag{3}
$$

where θ is the angular displacement of Link 4. Since O₂, C,D, and G remain collinear, the inversion relationship can be used to determine the output position:

$$
x_G=\frac{a^2-b^2}{2r}=L
\tag{4}
$$

$$
y_G=L\tan\left(\frac{\theta}{2}\right)
\tag{5}
$$

where a = 105 mm is the length of Links 2–3, b = 35 mm is the length of Links 5–8, and r = 40 mm is both the input crank length (Link 4) and the distance between fixed pivots O₂ and O₄. Substituting these values into Equation (4) gives **L = 122.50 mm**. Since the horizontal position of G remains constant, the joint follows an exact vertical straight-line path.

### 1.2. Velocity and Acceleration Analysis

The velocity and acceleration of output joint G are obtained by differentiating its position equations with respect to time. Since the horizontal position remains constant, both horizontal velocity and acceleration are zero.

**Velocity:**

$$
v_{Gx}=\frac{dx_G}{dt}=0
\tag{6}
$$

$$
v_{Gy}=\frac{dy_G}{dt}
=\frac{L}{2}\sec^2\left(\frac{\theta}{2}\right)\omega
\tag{7}
$$

**Acceleration:**

$$
a_{Gx}=\frac{d^2x_G}{dt^2}=0
\tag{8}
$$

$$
a_{Gy}=\frac{dv_{Gy}}{dt}
=\frac{L}{2}\sec^2\left(\frac{\theta}{2}\right)
\left[\alpha+\omega^2\tan\left(\frac{\theta}{2}\right)\right]
\tag{9}
$$

where ω and α represent the angular velocity and angular acceleration of Link 4, respectively. For the numerical analysis, a constant angular velocity of **ω = 1 rad/s** and zero angular acceleration (**α = 0**) are assumed. These equations describe the vertical motion of joint G as the input crank rotates.

## Part IV: Built Mechanism
