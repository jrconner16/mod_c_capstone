# Milestone 1 Roadmap

## Goal

Finish Milestone 1 with a 95+ target by satisfying every rubric section exactly, using only the Wisconsin and Brazil cancer datasets.

## Current State

- Weeks 1-4 notebooks now cover both datasets where needed and include supporting graphs.
- Week 1 now includes Wisconsin and Brazil comparisons plus a combined Week 1 graph.
- Week 2 now includes a regularization comparison graph built from CV ROC-AUC for both datasets.
- Week 3 now includes Wisconsin and Brazil method comparisons plus a combined Week 3 graph.
- Week 4 now includes both the Brazil threshold-tuning graph and a compact model-comparison graph.
- Week 5 SVM notebook is now built and executed.
- Week 6 decision tree / random forest notebook is now built and executed.
- `07_milestone1_summary_figures.ipynb` is empty and should become the paper figure factory.
- The paper should follow the Milestone 1 section guidance closely.
- EDA should be handled as a short rubric-required modeling bridge, not as a separate EDA paper.
- Next highest-value task is to build the summary-figures notebook and export paper-ready visuals.

## Rubric Priorities

- Breadth and depth are the highest-value categories: 60 of 100 points.
- Breadth requires clear discussion of all six weekly techniques.
- Depth requires explicitly naming 1-2 techniques and discussing them thoroughly.
- Planned depth topics:
  - Week 4: logistic regression, scaling, threshold tuning, and Brazil class imbalance.
  - Week 6: decision trees and random forests, especially on Brazil.
- Week 5 SVM is likely a breadth section unless the results are unexpectedly strong or interesting.

## Phase 1: Complete Notebook Evidence

### Week 1: Polynomial and Interaction Terms

File: `notebooks/milestone1/01_week1_poly_interactions.ipynb`

Status:
- Completed and executed.

What is in the notebook:
- Wisconsin and Brazil Week 1 comparisons are included.
- Each dataset compares a full-feature baseline, a reduced-feature baseline, and a polynomial expansion of the reduced set.
- A combined comparison graph is included.

Paper point:
- Polynomial terms improved the reduced-feature model but did not beat the full original-feature model.

### Week 2: Ridge, Lasso, and Elastic Net

File: `notebooks/milestone1/02_week2_regularization.ipynb`

Status:
- Completed and executed.

What is in the notebook:
- Wisconsin and Brazil regularization runs are included.
- Ridge, lasso, and elastic net are compared with ROC-AUC-driven tuning.
- A regularization comparison graph is included using best CV ROC-AUC by penalty.
- Best penalty and best `C` are visible in notebook outputs and figure labels.

Paper point:
- Regularization mainly improved stability and controlled correlated predictors, rather than producing a large raw-performance gain.

### Week 3: Feature Selection, PCR, and PLSR

File: `notebooks/milestone1/03_week3_feature_selection_pcr_pls.ipynb`

Status:
- Completed and executed.

What is in the notebook:
- Wisconsin and Brazil Week 3 runs are included.
- Forward selection, PCR, and PLSR are compared on both datasets.
- A combined comparison graph is included using best CV ROC-AUC by method.
- Selected feature counts or component counts are shown in graph annotations.

Paper point:
- Component methods may improve generalization, while feature selection is more interpretable.

### Week 4: Logistic Regression and Feature Scaling

File: `notebooks/milestone1/04_week4_logistic_scaling_thresholds.ipynb`

Status:
- Completed and executed.

What is in the notebook:
- Wisconsin scaled vs unscaled logistic regression is included.
- Brazil standard vs balanced logistic regression is included.
- The Brazil threshold tradeoff graph is included.
- A compact comparison graph for recall and F1 is included.
- Precision, recall, F1, ROC-AUC, and PR-AUC are preserved in the notebook tables.

Paper point:
- Scaling helps Wisconsin logistic regression, and Brazil shows why accuracy alone is weak under severe class imbalance.

Depth candidate:
- Yes. This is the planned first deep-dive topic.

### Week 5: Support Vector Machines

File: `notebooks/milestone1/05_week5_svm.ipynb`

Status:
- Completed and executed.

What is in the notebook:
- Wisconsin and Brazil SVM runs are included.
- Scaling pipelines are used for both datasets.
- Linear and RBF kernels are compared.
- `C` is tuned for both kernels, and `gamma` is tuned for RBF.
- Metrics include accuracy, precision, recall, F1, ROC-AUC, and PR-AUC.
- ROC-AUC and PR-AUC comparison graphs are included.

Paper point:
- SVM satisfies breadth. It becomes a depth topic only if it produces a more interesting result than random forest.

Observed result:
- Wisconsin was essentially saturated after scaling: linear and RBF SVM performed almost identically.
- Brazil was more informative: RBF improved ROC-AUC and PR-AUC over linear, but recall remained modest at the default threshold.
- This supports the paper point that Brazil evaluation must go beyond accuracy.

### Week 6: Decision Trees and Random Forests

File: `notebooks/milestone1/06_week6_trees_random_forest.ipynb`

Status:
- Completed and executed.

What is in the notebook:
- Decision tree and random forest are run on Wisconsin and Brazil.
- `max_depth`, `min_samples_leaf`, and `n_estimators` are tuned.
- Train ROC-AUC, CV ROC-AUC, and test metrics are included to support overfitting discussion.
- A model-comparison graph is included.
- A Brazil random forest feature-importance graph is included.

Paper point:
- Random forest should support the second deep dive by showing nonlinear modeling, overfitting control, and interpretable feature importance.

Depth candidate:
- Yes. This is the planned second deep-dive topic unless SVM is unexpectedly stronger.

Observed result:
- Random forest outperformed the single decision tree on both datasets.
- The gain was larger on Brazil, where random forest improved ROC-AUC, PR-AUC, and F1.
- Brazil feature importance was readable enough to use in the paper, so Week 6 remains the best second depth section.

### Summary Figures

File: `notebooks/milestone1/07_milestone1_summary_figures.ipynb`

Tasks:
- Generate paper-ready versions of the final figures.
- Save final figures to `outputs/figures`.
- Keep figure styling consistent and legible.
- Target 5-6 final figures, staying within the rubric limit of 3-8.

Priority note:
- This is now the immediate next execution step.

## Phase 2: Figure Map

Use 5-6 figures in the paper body.

Recommended figures:

1. Dataset comparison table.
   - Wisconsin size, features, target balance.
   - Brazil size/sample, features, target balance.

2. Week 2 regularization comparison.
   - Prefer the CV ROC-AUC penalty comparison over the Week 1 chart for the paper body.

3. Week 3 feature selection / PCR / PLSR comparison.

4. Week 4 Brazil threshold tradeoff.
   - Precision, recall, and F1 across thresholds.

5. Week 5 SVM comparison.
   - Linear vs RBF, or tuned metric comparison across datasets.

6. Week 6 random forest figure.
   - Prefer Brazil feature importance if readable.
   - Otherwise use decision tree vs random forest metric comparison.

## Phase 3: Paper Outline

The paper should follow the Milestone 1 section guide closely.

### 1. Problem Statement / Description

Target length:
- About half a page.

Include:
- Chosen project.
- Wisconsin and Brazil datasets.
- Clinical or decision-support impact.
- Why model evaluation matters for this problem.

### 2. Modeling Techniques: Breadth

Cover all six weeks concisely:
- Week 1: polynomial and interaction terms.
- Week 2: ridge, lasso, elastic net.
- Week 3: forward/backward selection, PCR, PLSR.
- Week 4: logistic regression and feature scaling.
- Week 5: SVM, kernels, and SVM regularization.
- Week 6: decision trees and random forests.

For each week:
- State what was run.
- State the main metric result.
- State the main conclusion.
- Mention the main limitation or overfitting issue when relevant.

### 3. Modeling Techniques: Depth

Explicitly state the deep-dive topics.

Planned deep dives:
- Week 4: logistic regression, scaling, and threshold tuning.
- Week 6: decision trees and random forests.

For each deep dive:
- Explain why the technique was appropriate.
- Explain what was tuned.
- Explain what the hyperparameters mean.
- Discuss overfitting controls.
- Connect model behavior to the dataset and project goal.
- Support claims with figures and metrics.

### 4. Overfitting

Include a dedicated section or paragraph.

Discuss:
- Train/test split.
- Cross-validation.
- Regularization.
- Scaling pipelines.
- SVM `C`, kernel, and `gamma`.
- Tree depth limits.
- `min_samples_leaf`.
- Random forest averaging.

Required framing:
- What technique was used.
- Why it was expected to help.
- What the result showed.

### 5. Metrics and Hyperparameter Tuning

Include a dedicated section or paragraph.

Discuss:
- Why accuracy is useful for Wisconsin but insufficient for Brazil.
- Why Brazil needs precision, recall, F1, ROC-AUC, and PR-AUC.
- Why threshold tuning matters for imbalanced clinical outcomes.
- Tuned parameters:
  - Logistic regression `C` and penalty.
  - SVM `C`, kernel, and optional `gamma`.
  - Tree `max_depth` and `min_samples_leaf`.
  - Random forest `n_estimators`, `max_depth`, and `min_samples_leaf`.

### 6. Expected / Unexpected Results

Include a dedicated short section.

Good candidates:
- Wisconsin models perform very well because the dataset is clean and separable.
- Brazil accuracy is misleading because the positive class is rare.
- Threshold tuning may change conclusions more than model choice.
- Random forest may improve interpretability or nonlinear performance.
- SVM may underperform or be less interpretable on Brazil.

### 7. Exploratory Data Analysis Connection

Keep this short.

Purpose:
- Satisfy the rubric item requiring discussion of how EDA helped modeling.

Include only modeling-relevant EDA:
- Feature scaling was needed because predictor ranges differed.
- Regularization/PCR were relevant because predictors were correlated.
- PR-AUC, recall, and threshold tuning were important because Brazil was imbalanced.

### 8. Specific Supported Conclusions

Synthesize rather than repeat every result.

Include:
- What the models show.
- Why the conclusions are quantitatively supported.
- Why the conclusions matter for the project.
- Which dataset/model combinations are most trustworthy.
- Where the evidence is limited.

### 9. AI Appendix and Citations

Include:
- AI-use disclosure.
- Prompts or general purpose of AI help, if used.
- External citations for model concepts or implementation references.
- One consistent citation style.

## Phase 4: Final Rubric Audit

Before submission, verify:

- The project description is clear and impact-oriented.
- All six weeks are discussed.
- The deep-dive topics are explicitly named.
- Claims are supported by notebook outputs and figures.
- Overfitting prevention is explained with method, rationale, and result.
- Metrics and hyperparameter tuning are explained, not just listed.
- Expected and unexpected results are interpretive.
- EDA is included as a short modeling-focused paragraph.
- The paper has 3-8 figures in the body.
- Figures are legible and captioned.
- The paper is 8-10 pages, double-spaced, 12-point Times New Roman, with 1-inch margins.
- Notebook appendix or full GitHub repo link is included.
- AI appendix is included.
- Citations are included.

## Execution Order

1. Build the paper outline with figure map.
2. Create the summary figures notebook.
3. Write the paper draft.
4. Run the final rubric audit and tighten weak sections.
