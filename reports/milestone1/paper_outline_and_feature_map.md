# Milestone 1 Paper Outline and Feature Map

## Source Inventory Used

- Repo structure and helper files: `src/load_data.py`, `src/preprocessing.py`.
- Roadmap: `reports/milestone1/milestone1_roadmap.md`.
- Notebook evidence: `notebooks/milestone1/01_week1_poly_interactions.ipynb` through `06_week6_trees_random_forest.ipynb`.
- Empty figure factory to build next: `notebooks/milestone1/07_milestone1_summary_figures.ipynb`.
- External assignment files one directory above the repo:
  - `../Mod C Milestone 1 Guidelines and Rubric.pdf`.
  - `../milestone_1_supplimental_instructions.rtf`.

## Working Paper Thesis

This project evaluates machine learning methods for cancer-related classification using two datasets with very different modeling difficulty: the Wisconsin breast cancer dataset and a large Brazil cancer registry modeling dataset. Wisconsin is small, clean, and highly separable, so many methods perform near ceiling. Brazil is much larger and severely imbalanced, with deceased cases at about 7.0 percent of the processed dataset, so it is the stronger test of whether model evaluation, threshold choice, and overfitting controls match a diagnostic decision-support problem.

Use the paper to argue that the most important modeling lesson is not simply which model has the highest accuracy. The strongest evidence comes from Week 4 and Week 6: logistic regression shows how scaling, class weighting, and threshold tuning change precision-recall tradeoffs, while random forests improve nonlinear performance and provide interpretable feature importance on the harder Brazil dataset.

## Required Paper Structure

Target format from the rubric: 8 to 10 pages, double-spaced, 12-point Times New Roman, one-inch margins, with 3 to 8 body figures. Tables count as figures. The notebook appendix is separate and should include either the notebooks or a public repo/notebook link. Include an AI appendix and citations.

### 1. Problem Statement and Project Description

Target length: about half a page.

Cover:

- Project: cancer classification and risk/outcome modeling using Wisconsin breast cancer measurements and Brazil cancer registry features.
- Impact: decision support for prioritizing review, screening model behavior, and understanding which evaluation metrics matter when false negatives have clinical cost.
- Dataset contrast:
  - Wisconsin: 569 rows, 30 numeric tumor-measurement predictors, `Diagnosis` target, 212 positive cases and 357 negative cases.
  - Brazil: 1,742,813 rows, 40 processed predictors before the target, `target_deceased`/`deceased` target, 122,706 deceased cases and 1,620,107 non-deceased cases.
- Scope note: the repo also contains LC25000 image-derived files, but the Milestone 1 roadmap and Weeks 1-6 notebooks use Wisconsin and Brazil only. Keep LC25000 out of this paper unless the assignment direction changes.

### 2. Data and EDA Bridge

Target length: one short section or two paragraphs.

Use this as the modeling bridge, not a long standalone EDA section.

Key points:

- Wisconsin features are continuous tumor measurements such as radius, texture, compactness, symmetry, concavity, and concave points. These features are on different scales, which supports the use of standardization for logistic regression and SVM.
- Brazil features are a mixture of demographics, diagnostic method, morphology code, tumor extension, laterality, education, marital status, profession code, rare-case indicators, and age. `diagnosis_year` is dropped by the default loader.
- Brazil class imbalance is central: only about 7.0 percent of cases are positive for deceased. This justifies ROC-AUC, PR-AUC, recall, F1, stratified train/test splits, and threshold tuning instead of relying on accuracy alone.
- Correlated Wisconsin tumor measurements justify regularization, feature selection, PCR, and PLSR.

### 3. Breadth Across Weeks 1-6

Target length: about 2.5 to 3 pages. This is worth 30 rubric points, so make every week visible.

Use this structure for each week:

- What was run.
- What metrics were used.
- Best or most important result.
- Limitation or overfitting issue.
- Short takeaway connecting Wisconsin vs Brazil.

#### Week 1: Polynomial and Interaction Terms

Evidence:

| Dataset | Model | Test Accuracy | Test ROC-AUC | Takeaway |
|---|---:|---:|---:|---|
| Wisconsin | Full baseline | 0.9649 | 0.9960 | Best Week 1 Wisconsin result. |
| Wisconsin | Reduced subset | 0.9298 | 0.9858 | Removing features hurt performance. |
| Wisconsin | Reduced subset + polynomial | 0.9474 | 0.9888 | Polynomial terms recovered some signal but did not beat full features. |
| Brazil | Full baseline | 0.9419 | 0.9237 | Best Week 1 Brazil result. |
| Brazil | Reduced subset | 0.9294 | 0.7428 | Reduced feature set lost substantial ranking power. |
| Brazil | Reduced subset + polynomial | 0.9294 | 0.7615 | Interactions helped the reduced set slightly but remained far below full features. |

Paper conclusion: polynomial expansion is useful as a diagnostic check for nonlinear signal, but in both datasets the richer original feature set was more valuable than polynomial complexity on a reduced subset.

#### Week 2: Ridge, Lasso, and Elastic Net

Evidence:

- Brazil regularized logistic regression used 5-fold CV and ROC-AUC. Best result: L2/ridge-style logistic regression with `C=0.1`, CV ROC-AUC 0.9388, with elastic net nearly identical.
- Wisconsin regularized logistic regression used 5-fold CV and ROC-AUC. Best result: L2/ridge-style logistic regression with `C=10`, CV ROC-AUC 0.9960, with L1 and elastic net close behind.

Paper conclusion: regularization mainly improved stability and controlled correlated predictors rather than creating a large raw performance gain. Explain `C` as inverse regularization strength: lower `C` means stronger shrinkage.

#### Week 3: Feature Selection, PCR, and PLSR

Evidence:

| Dataset | Best Method by CV ROC-AUC | Test Accuracy | Test ROC-AUC | Takeaway |
|---|---:|---:|---:|---|
| Wisconsin | PLSR, CV ROC-AUC 0.9958 | 0.9912 | 0.9974 | Component methods were very strong. |
| Wisconsin | PCR, CV ROC-AUC 0.9952 | 0.9825 | 0.9970 | Similar to PLSR. |
| Wisconsin | Forward selection, CV ROC-AUC 0.9948 | 0.9561 | 0.9947 | Most interpretable, slightly weaker. |
| Brazil | Forward selection, CV ROC-AUC 0.9282 | 0.9444 | 0.9134 | Interpretable and best by CV ROC-AUC. |
| Brazil | PLSR, CV ROC-AUC 0.9279 | 0.9425 | 0.9180 | Very close, slightly better test ROC-AUC. |
| Brazil | PCR, CV ROC-AUC 0.9213 | 0.9394 | 0.9067 | Weaker than forward selection and PLSR. |

Paper conclusion: Week 3 is a tradeoff between interpretability and dimension reduction. Forward selection is easier to explain because it keeps original predictors; PCR/PLSR help manage correlated feature spaces through components.

#### Week 4: Logistic Regression, Scaling, Class Balance, and Thresholds

Evidence:

| Dataset/Model | Accuracy | Precision | Recall | F1 | ROC-AUC | PR-AUC |
|---|---:|---:|---:|---:|---:|---:|
| Wisconsin unscaled logistic | 0.9386 | 0.9730 | 0.8571 | 0.9114 | 0.9924 | 0.9869 |
| Wisconsin scaled logistic | 0.9649 | 0.9750 | 0.9286 | 0.9512 | 0.9960 | 0.9943 |
| Brazil scaled logistic | 0.9443 | 0.6827 | 0.3835 | 0.4911 | 0.9386 | 0.4986 |
| Brazil balanced logistic | 0.8442 | 0.2991 | 0.9088 | 0.4501 | 0.9410 | 0.4791 |

Threshold evidence:

- Brazil balanced logistic default threshold: positive-class recall 0.91, precision 0.30, F1 0.45, accuracy 0.84.
- Tuned F1 threshold 0.75: precision 0.44, recall 0.74, F1 0.55, accuracy 0.92.
- Confusion matrices show the tuned threshold reduced false positives from 2,988 to 1,306 while false negatives rose from 128 to 371.

Paper conclusion: this is the first depth topic. It directly addresses why accuracy is not enough for the Brazil dataset and why threshold selection should reflect the decision context.

#### Week 5: Support Vector Machines

Evidence:

| Dataset | Kernel | Accuracy | Precision | Recall | F1 | ROC-AUC | PR-AUC | Best Params |
|---|---|---:|---:|---:|---:|---:|---:|---|
| Wisconsin | Linear | 0.9825 | 1.0000 | 0.9524 | 0.9756 | 0.9964 | 0.9951 | `C=0.1` |
| Wisconsin | RBF | 0.9825 | 1.0000 | 0.9524 | 0.9756 | 0.9960 | 0.9947 | `C=10`, `gamma=0.01` |
| Brazil | Linear | 0.9444 | 0.7143 | 0.3540 | 0.4734 | 0.8779 | 0.4584 | `C=1` |
| Brazil | RBF | 0.9462 | 0.7647 | 0.3451 | 0.4756 | 0.9330 | 0.5607 | `C=1`, `gamma=0.01` |

Paper conclusion: SVM satisfies breadth. Wisconsin did not benefit much from the nonlinear kernel because the classes were already separable after scaling. Brazil benefited more from RBF on ROC-AUC and PR-AUC, but recall remained modest at the default threshold.

#### Week 6: Decision Trees and Random Forests

Evidence:

| Dataset | Model | Accuracy | Precision | Recall | F1 | ROC-AUC | PR-AUC | Train ROC-AUC | CV ROC-AUC |
|---|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Wisconsin | Decision tree | 0.9123 | 1.0000 | 0.7619 | 0.8649 | 0.9688 | 0.9533 | 0.9929 | 0.9559 |
| Wisconsin | Random forest | 0.9737 | 1.0000 | 0.9286 | 0.9630 | 0.9929 | 0.9893 | 1.0000 | 0.9889 |
| Brazil | Decision tree | 0.9356 | 0.6042 | 0.2566 | 0.3602 | 0.8840 | 0.4648 | 0.9129 | 0.8856 |
| Brazil | Random forest | 0.9406 | 0.6875 | 0.2920 | 0.4099 | 0.9363 | 0.5429 | 0.9733 | 0.9339 |

Best hyperparameters:

- Wisconsin tree: `max_depth=5`, `min_samples_leaf=10`.
- Wisconsin random forest: `max_depth=None`, `min_samples_leaf=1`, `n_estimators=100`.
- Brazil tree: `max_depth=5`, `min_samples_leaf=10`.
- Brazil random forest: `max_depth=None`, `min_samples_leaf=5`, `n_estimators=200`.

Paper conclusion: this is the second depth topic. Random forests improved both datasets, with the most important gain on Brazil. Discuss overfitting controls through CV, `min_samples_leaf`, forest averaging, and train-vs-CV ROC-AUC.

### 4. Depth Topic 1: Week 4 Logistic Regression

Target length: about 1.25 to 1.5 pages.

Develop these points:

- Why logistic regression fits the project: interpretable baseline, probability scores, and threshold control.
- Why scaling matters: coefficients and optimization are sensitive to feature scale; Wisconsin scaled logistic improved recall from 0.8571 to 0.9286 and F1 from 0.9114 to 0.9512.
- Why Brazil needs class imbalance handling: the positive class is only about 7.0 percent of the full processed dataset.
- Why class weighting and threshold tuning answer different questions:
  - Class weighting changes the training objective so mistakes on the minority class matter more.
  - Threshold tuning changes the operating point after the model produces probabilities.
- Use the threshold tradeoff figure to explain the practical choice:
  - Default balanced model catches more positives but creates many false positives.
  - F1-tuned threshold improves precision and F1 but accepts more missed positive cases.
- Tie to clinical impact: in a triage or screening workflow, the preferred threshold depends on whether the system is used for early warning, scarce-resource allocation, or confirmatory review.

### 5. Depth Topic 2: Week 6 Trees and Random Forests

Target length: about 1.25 to 1.5 pages.

Develop these points:

- Why tree methods fit the project: nonlinear relationships, interactions without manual polynomial expansion, and feature importance.
- Single trees are interpretable but high variance. The tuned tree used `max_depth` and `min_samples_leaf` to limit overfitting.
- Random forests reduce variance by averaging many trees and randomizing splits/features.
- Brazil result is the stronger story: random forest improved ROC-AUC from 0.8840 to 0.9363 and PR-AUC from 0.4648 to 0.5429 compared with the single tree.
- Use train-vs-CV discussion honestly:
  - Brazil random forest train ROC-AUC 0.9733 vs CV ROC-AUC 0.9339 shows some fit to training data, but the CV score and test ROC-AUC remain stronger than the single tree.
  - `min_samples_leaf=5` on Brazil is a useful overfitting control because leaves must contain more samples before the model can isolate small patterns.
- Feature importance story:
  - Top Brazil features were `diagnostic_method_sdo` 0.2069, `morphology_code` 0.1421, `age` 0.0753, `laterality_not_applicable` 0.0733, `profession_code` 0.0704, and `diagnostic_method_primary_tumor_histology` 0.0698.
  - Present these as model-attribution evidence, not causal claims.

### 6. Overfitting Section

Target length: about half a page. The rubric gives this 10 points, so make it explicit.

Mention:

- Stratified train/test splits preserved class balance.
- Cross-validation was used for model selection and hyperparameter tuning.
- Regularization controlled coefficient size in logistic models.
- Polynomial features were restricted to reduced subsets because expanding all features would sharply increase variance and complexity.
- PCR/PLSR reduced dimensionality to manage correlated predictors.
- SVM tuning controlled margin complexity through `C` and RBF flexibility through `gamma`.
- Tree models used `max_depth`, `min_samples_leaf`, and random forest averaging.
- Brazil sampling made heavy notebooks runnable; acknowledge this as a computational limitation and state that stratification helped preserve the target distribution.

### 7. Metrics and Hyperparameter Tuning Section

Target length: about half a page.

Metrics to justify:

- Accuracy for general comparability, but not sufficient for Brazil.
- ROC-AUC for ranking performance across thresholds.
- PR-AUC for imbalanced Brazil performance.
- Precision, recall, and F1 for the minority positive class.
- Confusion matrices for Week 4 threshold tradeoffs.

Hyperparameters to explain:

- Logistic/regularized models: `C` is inverse regularization strength; penalty type controls shrinkage behavior.
- Elastic net: `l1_ratio` balances lasso-like sparsity and ridge-like shrinkage.
- PCR/PLSR: number of components controls dimensionality and bias-variance tradeoff.
- SVM: `C` controls margin violations; `gamma` controls local flexibility for RBF.
- Trees: `max_depth` limits tree growth; `min_samples_leaf` prevents tiny leaves.
- Random forest: `n_estimators` controls number of trees; more trees can stabilize estimates at higher computational cost.

### 8. Expected and Unexpected Results

Target length: about half a page.

Expected:

- Wisconsin performed strongly across almost every method because it is clean, numeric, and highly separable.
- Scaling helped logistic regression and was necessary for SVM.
- Brazil accuracy was misleading because the majority class is dominant.
- Random forests beat single trees because averaging reduces variance.

Unexpected or more interesting:

- Polynomial features helped reduced subsets but did not beat full original features.
- On Wisconsin, linear and RBF SVM were nearly identical despite the added flexibility of RBF.
- On Brazil, the balanced logistic model had similar ROC-AUC to standard logistic but very different recall/precision behavior.
- Brazil random forest improved ranking and PR-AUC, but default-threshold recall remained lower than the threshold-tuned logistic approach. This is useful because it separates ranking quality from operating-threshold choice.

### 9. Conclusions

Target length: about half a page.

Conclusions to support:

- The project is less about a single universal best model and more about aligning model choice with dataset properties and clinical decision cost.
- Wisconsin shows that simpler, scaled, regularized models can be enough when the signal is strong.
- Brazil shows that imbalanced outcome modeling requires PR-AUC, recall, F1, and threshold analysis.
- Week 4 logistic regression provides the clearest evaluation lesson: thresholds change the practical consequences of the model.
- Week 6 random forest provides the strongest nonlinear modeling lesson: forests improved ROC-AUC/PR-AUC and produced a usable feature-importance summary.

### 10. AI Appendix and Citations

Include an AI appendix because the rubric requires it.

Suggested appendix language to adapt:

> AI was used to help review repository materials, summarize notebook results, and draft a paper outline and feature/figure map. The analysis and final writing were reviewed and edited by the student. The prompt asked the AI to check the repository, roadmap notebooks 1-6, rubric, and supplemental Milestone 1 information, then draft a paper outline and feature map.

Citation candidates:

- Wisconsin breast cancer dataset source.
- Brazil registry/data source used to create `brazil_modeling.csv`.
- scikit-learn documentation for logistic regression, regularization, SVM, decision trees, random forests, cross-validation, and metrics.
- Any course or YellowDig external educational sources used for model concepts.

## Feature Map

### Dataset Feature Families

| Dataset | Target | Feature Families | Paper Use |
|---|---|---|---|
| Wisconsin | `Diagnosis` | Numeric tumor measurements: radius, texture, perimeter, area, smoothness, compactness, concavity, concave points, symmetry, fractal dimension, with mean/SE/worst-style variants. | Clean benchmark for comparing methods; strong example of why scaling and correlated predictors matter. |
| Brazil | `deceased` / `target_deceased` | Age, profession code, morphology code, gender, race/color, education, marital status, rare-case indicator, diagnostic method, tumor extension, laterality. | Main applied dataset for imbalance, threshold choice, nonlinear modeling, and feature importance. |

### Engineered and Selected Features

| Notebook | Feature Treatment | Details | Interpretation |
|---|---|---|---|
| Week 1 | Reduced Wisconsin subset | `radius1`, `symmetry1`, `compactness1`, `texture1`, `concave_points1`. | Size, shape, texture, and boundary-related features provide a compact interpretable subset. |
| Week 1 | Reduced Brazil subset | `age`, `morphology_code`, `gender_female`, `diagnostic_method_primary_tumor_histology`, `extension_metastasis`. | Clinically plausible small subset, but it lost substantial ROC-AUC versus full features. |
| Week 1 | Polynomial and interaction terms | Degree 2-3 polynomial expansion on reduced subsets. | Captures nonlinear and interaction signal, but adds complexity and did not beat full original features. |
| Week 2 | Regularized full features | Ridge/L2, lasso/L1, elastic net after scaling. | Tests whether shrinkage helps correlated predictors and controls overfitting. |
| Week 3 | Forward selection | 5, 10, or 15 selected features. | Most interpretable because selected variables remain original predictors. |
| Week 3 | PCR | 2, 3, 5, 10, or 15 PCA components. | Compresses correlated predictors without using target information in component construction. |
| Week 3 | PLSR | 2, 3, 5, 10, or 15 PLS components. | Builds target-informed components; strong on Wisconsin and close on Brazil. |
| Week 4 | Scaled logistic features | Standardized continuous/mixed predictors. | Scaling improved Wisconsin and supported fair coefficient/optimization behavior. |
| Week 4 | Class weighting and thresholds | Balanced class weights and threshold grid 0.05 to 0.95. | Converts Brazil from an accuracy story into a precision-recall decision story. |
| Week 5 | SVM kernels | Linear and RBF kernels with standardized features. | Tests whether nonlinear boundary improves separation. |
| Week 6 | Tree splits and forest importance | Tree/forest uses original feature space; importance computed from Brazil forest. | Supports nonlinear modeling and interpretable feature ranking. |

### Brazil Random Forest Feature Importance Map

| Rank | Feature | Importance | Discussion Use |
|---:|---|---:|---|
| 1 | `diagnostic_method_sdo` | 0.2069 | Strongest model split signal; define carefully in final paper based on data dictionary if available. |
| 2 | `morphology_code` | 0.1421 | Tumor morphology carries important registry signal. |
| 3 | `age` | 0.0753 | Demographic risk/outcome signal. |
| 4 | `laterality_not_applicable` | 0.0733 | Laterality coding has predictive association. |
| 5 | `profession_code` | 0.0704 | Registry/case context signal; avoid causal interpretation. |
| 6 | `diagnostic_method_primary_tumor_histology` | 0.0698 | Diagnostic method appears important in the forest. |
| 7 | `rare_case_false` | 0.0591 | Rare-case coding contributes to splits. |
| 8 | `education_elementary_1_to_4` | 0.0464 | Socio-demographic marker; discuss cautiously. |
| 9 | `marital_status_married` | 0.0366 | Demographic/context marker. |
| 10 | `education_no_schooling` | 0.0281 | Socio-demographic marker; discuss cautiously. |

Important wording: feature importance shows what the fitted forest used for prediction. It does not prove that these variables cause mortality.

## Figure Map

Use 6 body figures. This stays within the required 3 to 8 range and gives each major rubric area evidence without overcrowding the paper.

| Figure | Source | Type | Main Message | Paper Placement |
|---|---|---|---|---|
| Figure 1 | Dataset inventory from processed CSVs | Table | Wisconsin is small and moderately imbalanced; Brazil is very large and severely imbalanced. | Problem/data section. |
| Figure 2 | Week 2 notebook | Bar chart: best CV ROC-AUC by penalty for Wisconsin and Brazil | Regularization choices were close; shrinkage was mainly about stability and overfitting control. | Breadth section. |
| Figure 3 | Week 3 notebook | Bar chart: CV ROC-AUC by forward selection, PCR, PLSR | Shows interpretability vs component-method tradeoff. | Breadth section. |
| Figure 4 | Week 4 notebook | Brazil threshold tradeoff line chart | Precision, recall, and F1 move in opposite directions as threshold changes. | Depth topic 1. |
| Figure 5 | Week 5 notebook | SVM ROC-AUC/PR-AUC comparison, preferably PR-AUC if only one | RBF mattered more on Brazil than Wisconsin, but default-threshold recall remained limited. | Breadth section. |
| Figure 6 | Week 6 notebook | Brazil random forest feature importance | Random forest gives both nonlinear performance and a readable model story. | Depth topic 2/conclusions. |

Optional replacement if space is tight: drop Figure 5 and keep SVM as text-only breadth evidence. Do not drop Figures 1, 4, or 6.

## Next Build Tasks

1. Populate `notebooks/milestone1/07_milestone1_summary_figures.ipynb` with clean, consistent versions of Figures 1-6.
2. Save final images into `outputs/figures/milestone1`.
3. Draft the Word paper from the outline above, keeping Week 4 and Week 6 explicitly labeled as depth topics.
4. Add final citations and an AI appendix.
5. Attach or link notebooks 1-6 as the required appendix.
