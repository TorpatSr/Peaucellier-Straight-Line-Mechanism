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

## Part IV: Built Mechanism
