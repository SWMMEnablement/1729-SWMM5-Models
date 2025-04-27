# Repository Overview: 1729-SWMM5-Models

This repository contains a wide range of SWMM5 input files and related documents for simulating hydrology and hydraulics across various projects. Below is a summary of the key directories:

## Directories

- **1000Years**  
  Contains long-term simulation models (e.g., `1000yearSimulation_Case0_wq.inp`) and supporting files for extended period analyses.

- **Hydraulics**  
  Includes hydraulic model input files and configuration documents used in SWMM5 hydraulic simulations.

- **Hydrology**  
  Contains hydrologic model input files, rainfall data, runoff models, and analysis reports.

- **SWMM5_NCIMM**  
  Hosts SWMM5 models for NCIMM projects, featuring example files ranging from small-scale tests to large-scale simulations.

- **EPA**  
  Includes model files and documentation associated with EPA projects, as well as Extran Manual examples.

- **OWA_USER**  
  Contains user-specific simulation files and generated reports (e.g., files named with `user1`, `user2`, etc.).

- **LID**  
  Contains Low Impact Development (LID) simulation files and supporting documentation.

- **NCIMM_ROUTING**  
  Comprises routing model files and documentation used in advanced NCIMM routing analyses.

- **LEW_CHI_SWMM5.2**  
  Contains test cases and examples for the LEW/CHI SWMM5.2 implementation.

- **Special**  
  Contains special case models and scenarios, such as files addressing many isolated nodes or other unusual configurations.

- **DataFiles**  
  Houses external data files (e.g., rainfall data in `.dat` and `.rff` formats) that models use as input.

## Root Directory Content

In addition to the above directories, the root folder includes:

- Session files such as `Session1_user1.*`, `Session29_292_Storage_Nodes_200_Subs.md`, etc.
- Configuration files like `.gitattributes` and `LICENSE`.
- Batch files like `generate_summaries.bat` for automating summary generation and other tasks.

## How to Use

- Open any of the input files (for instance, [1000yearSimulation_Case0_wq.inp](1000Years/1000yearSimulation_Case0_wq.inp)) to review project settings defined in sections like `[OPTIONS]`, `[SUBCATCHMENTS]`, and others.
- Use the provided batch files to generate reports or summaries.
- Detailed project documentation can be found within each directory’s files.

---

For more detailed information on individual files or directories, please refer to the corresponding documents in each folder.