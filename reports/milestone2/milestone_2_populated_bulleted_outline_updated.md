# Milestone Two Draft Outline — Populated From Weeks 8–11 Notebooks

> **Use:** Convert the bullets into prose in your own words. Items labeled **[MISSING COMMENTARY]** or **[MISSING RESULT]** need to be added by you. They are not inferred from the notebooks.

# Working Title

- **Comparing Supervised and Unsupervised Machine Learning Across Two Cancer Datasets**
- Final title used in the current draft.

# 1. Project Overview and Questions

## Project description

- The project analyzes two cancer-related datasets:
  - Wisconsin breast cancer diagnostic dataset.
  - Brazil cancer-registry patient outcome dataset.
- The project applies both supervised and unsupervised machine-learning methods.
- Supervised methods:
  - K-nearest neighbors.
  - Gradient boosting.
- Unsupervised methods:
  - K-means.
  - DBSCAN.
  - Hierarchical agglomerative clustering.
- The analyses compare how the same general modeling approach behaves on two datasets with substantially different structures.
- The Wisconsin dataset is described in the notebooks as:
  - Smaller.
  - Cleaner.
  - Composed primarily of continuous numeric measurements.
  - Relatively separable by diagnosis.
  - Less severely imbalanced than the Brazil dataset.
- The Brazil dataset is described as:
  - Much larger.
  - More heterogeneous.
  - More imbalanced.
  - Partly sparse.
  - Containing coded registry variables and missing values.
  - Computationally expensive enough that reproducible samples were used for some analyses.

## Potential impact

- **[MISSING COMMENTARY: Explain who could benefit from the analysis.]**
- Comparing the datasets shows that evaluation and modeling choices that work well for a small, clean, comparatively separable dataset can be misleading on a large, heterogeneous, imbalanced registry dataset.
- **[MISSING COMMENTARY: State whether the intended audience is clinical, public-health, technical, educational, or another group.]**
- **[MISSING COMMENTARY: Avoid claiming that the models are ready for clinical use unless that is supported elsewhere.]**

## Questions of interest

- How well do distance-based and tree-based classifiers distinguish the known outcomes in each dataset?
- How does class imbalance affect the usefulness of accuracy, recall, F1, ROC-AUC, and precision-recall metrics?
- Does the choice of KNN distance metric meaningfully change performance?
- How does gradient boosting compare with a random-forest baseline?
- Do unsupervised clustering methods identify stable, well-separated groups?
- Do the discovered clusters differ descriptively in diagnosis or outcome rate?
- How sensitive are clustering results to scaling, representation, initialization, and parameter choices?

## Analysis roadmap

- Week 8:
  - K-nearest neighbors with Euclidean, Manhattan, and Minkowski distance.
- Week 9:
  - Gradient boosting and comparison with random forest.
- Week 10:
  - K-means, inertia, silhouette score, stability, PCA display, and outcome profiles.
- Week 11:
  - DBSCAN, hierarchical agglomerative clustering, parameter sensitivity, noise, and outcome profiles.
- The current draft selects two depth topics:
  - Week 10 K-means and silhouette score.
  - Week 11 DBSCAN and hierarchical clustering.
- These topics were selected because they best demonstrate why internal clustering metrics must be checked against stability, coverage, representation, and cluster-size balance.



# 2. Data and Exploratory Analysis

## Wisconsin dataset

- Dataset size reported in the gradient-boosting notebook:
  - 569 observations.
  - 31 columns before separating predictors and target.
- Diagnosis distribution:
  - Class 0: 357 observations, 62.74%.
  - Class 1: 212 observations, 37.26%.
- The notebooks characterize the dataset as:
  - Smaller and cleaner than Brazil.
  - Numeric.
  - Fairly separable.
  - Well suited to standardized Euclidean geometry.
- In the clustering analyses:
  - The known diagnosis is excluded during fitting.
  - Diagnosis is added back afterward only for descriptive interpretation.

## Brazil dataset

- Gradient-boosting analysis used a reproducible sample of:
  - 120,000 observations.
  - 40 columns before separating predictors and target.
- Outcome distribution in that sample:
  - Surviving/not deceased class: 111,602 observations, 93.0%.
  - Deceased class: 8,398 observations, 7.0%.
- The notebooks characterize the dataset as:
  - Large.
  - Highly imbalanced.
  - Heterogeneous.
  - Partly sparse.
  - Containing missingness and coded registry variables.
- Reproducible samples were used because:
  - KNN becomes computationally expensive on very large datasets.
  - Repeated K-means tuning on the full dataset was considered unnecessary for exploratory analysis.
  - DBSCAN and hierarchical clustering require neighborhood or pairwise-distance calculations.
- The sample size and random seed are intended to be documented so the computational choice is transparent.
- The current draft reports that the full Brazilian cancer registry contains approximately 1.74 million records. **[MISSING COMMENTARY: Add the formal dataset source/citation.]**
- The modeled outcome is whether a patient was recorded as deceased; approximately 7% of records were positive in the analyzed samples. **[MISSING COMMENTARY: Add restrictions involving follow-up, censoring, or registry reporting.]**

## Data preparation

- Across distance-based models:
  - Target variables were removed before preprocessing and model fitting.
  - Diagnosis year was removed in the clustering notebooks.
  - Numeric predictor missingness was median-imputed.
  - Predictors were standardized.
- Reason for standardization:
  - KNN, K-means, DBSCAN, and hierarchical clustering depend on distances.
  - Variables measured on larger scales could otherwise dominate the calculations.
  - Large numeric registry codes could dominate distance despite not necessarily representing meaningful continuous distances.
- Target leakage prevention:
  - Outcome labels were not supplied to any clustering algorithm.
  - Outcomes were added back only after clustering for descriptive comparisons.
- The draft states that analyses selected numeric predictors and retained coded registry variables such as age, profession code, and morphology code. **[MISSING COMMENTARY: Clarify whether these were original numeric codes, dummy encoded categories, or otherwise transformed.]**
- **[MISSING COMMENTARY: Explain whether numeric registry codes should be interpreted as ordered quantities and how that limitation affects distance-based methods.]**

## EDA findings and modeling consequences

- Wisconsin:
  - Moderate class imbalance, but both classes are well represented.
  - Mostly continuous measurements.
  - Expected to work well with scaled KNN and K-means.
- Brazil:
  - Strong class imbalance, approximately 93% versus 7% in the gradient-boosting sample.
  - Accuracy can appear high even when positive-case recall is poor.
  - Recall, F1, average precision/PR-AUC, and threshold tradeoffs are therefore more informative.
  - Heterogeneous and coded features make Euclidean geometry more questionable.
  - Clustering results may depend heavily on feature representation.
- EDA directly informed:
  - Stratified splitting.
  - Metric choice.
  - Use of scaling.
  - Use of computational samples.
  - Cautious interpretation of Brazil clusters.
- EDA identified related Wisconsin measurements of tumor size and shape, including radius, perimeter, and area, recorded on different scales.
- Wisconsin predictors included strongly related measurement families, so the 30 columns did not represent 30 independent biological signals. Brazil contained missing values and heterogeneous coded registry fields. **[MISSING COMMENTARY: Add any formal correlation or missingness summaries if available.]**

## Suggested EDA figure

- **Figure 1: Class balance comparison across the Wisconsin and Brazil datasets.**
- Caption points:
  - Wisconsin is comparatively balanced.
  - Brazil has a rare positive/deceased outcome.
  - The imbalance motivates the use of recall, F1, balanced accuracy, and precision-recall metrics.
- **[MISSING: Create or select the final figure.]**

# 3. Modeling and Evaluation Framework

## Validation strategy

- Supervised models used:
  - Separate training and test sets.
  - Stratified splitting to preserve class proportions.
  - Cross-validation for hyperparameter selection.
- Wisconsin gradient-boosting split:
  - 426 training observations.
  - 143 test observations.
- Brazil gradient-boosting split:
  - 90,000 training observations.
  - 30,000 test observations.
- KNN conclusions state that overfitting was controlled through:
  - Scaling.
  - Train/test separation.
  - Stratified cross-validation.
  - Tuning the number of neighbors rather than defaulting to a very small neighborhood.
- Clustering validation was handled differently:
  - K-means used repeated random seeds and adjusted Rand index.
  - DBSCAN focused on parameter sensitivity because it is deterministic for fixed data and parameters.
  - Hierarchical clustering compared linkage methods and values of k.
- **[MISSING COMMENTARY: Add the exact number of cross-validation folds used in Weeks 8 and 9.]**
- Brazil method-specific samples all used `random_state=42`:
  - KNN: 10,000 rows.
  - Gradient boosting: 120,000 rows.
  - K-means: 100,000 rows.
  - DBSCAN: 30,000 rows.
  - Hierarchical clustering: 5,000 rows.

## Evaluation metrics

- Supervised classification:
  - Accuracy.
  - Balanced accuracy.
  - Precision.
  - Recall.
  - F1 score.
  - ROC-AUC.
  - Average precision or PR-AUC.
- Why multiple metrics were used:
  - Accuracy is useful but can hide poor minority-class performance.
  - Recall measures how many actual positive cases were detected.
  - Precision measures how many predicted positives were correct.
  - F1 balances precision and recall.
  - ROC-AUC assesses ranking across thresholds.
  - PR-AUC or average precision is particularly useful when the positive class is uncommon.
  - Balanced accuracy gives equal weight to sensitivity and specificity.
- Clustering:
  - Inertia.
  - Silhouette score.
  - Adjusted Rand index for stability.
  - Number of clusters.
  - Noise fraction for DBSCAN.
  - Descriptive outcome prevalence by cluster.
- Important limitation:
  - Outcome differences across clusters are not predictive-accuracy measures.
  - They are descriptive and hypothesis-generating.
  - They do not demonstrate causality or validated clinical risk groups.

# 4. Week 8: K-Nearest Neighbors

## Purpose and setup

- Applied KNN to both datasets.
- Main goals:
  - Compare Euclidean, Manhattan, and Minkowski distance.
  - Examine the effect of neighborhood size and weighting.
  - Compare behavior on a cleaner dataset versus a large imbalanced dataset.
- Scaling was included in the model pipeline because KNN is entirely distance-based.
- Stratified train/test splits and cross-validation were used.
- Brazil was analyzed using a stratified sample to keep KNN computationally feasible.

## Hyperparameters and tuning

- Tuned parameters included:
  - Distance metric:
    - Euclidean.
    - Manhattan.
    - Minkowski.
  - Number of neighbors, `k`.
  - Uniform versus distance weighting.
  - Minkowski power parameter where applicable.
- Models were tuned separately for:
  - ROC-AUC.
  - F1 score.
- Interpretation:
  - Smaller `k` creates a more flexible, locally responsive decision boundary and can overfit.
  - Larger `k` smooths the decision boundary and can underfit.
  - Uniform weighting gives each neighbor equal influence.
  - Distance weighting gives closer neighbors more influence.
  - Euclidean distance is equivalent to Minkowski distance with p = 2.
  - Manhattan distance is equivalent to Minkowski distance with p = 1.

## Wisconsin results

- ROC-AUC-tuned model:
  - Best parameters:
    - Euclidean distance.
    - 11 neighbors.
    - Distance weighting.
  - Cross-validation ROC-AUC: 0.9892.
  - Test accuracy: 0.9474.
  - Test precision: 0.9737.
  - Test recall: 0.8810.
  - Test F1: 0.9250.
  - Test ROC-AUC: 0.9823.
  - Test PR-AUC: 0.9794.
- F1-tuned model:
  - Best metric: Manhattan.
  - **[MISSING RESULT: Insert the full best parameter combination from the notebook display; the compact output truncates the neighbor and weighting values.]**
  - Cross-validation F1: 0.9667.
  - Test accuracy: 0.9649.
  - Test precision: 1.0000.
  - Test recall: 0.9048.
  - Test F1: 0.9500.
  - Test ROC-AUC: 0.9735.
  - Test PR-AUC: 0.9656.
- Interpretation already supported by notebook:
  - KNN worked strongly after scaling.
  - Euclidean and Manhattan results were sufficiently close that dataset separability appeared more important than distance-metric choice.
  - The result was expected because the data are numeric, relatively clean, and fairly separable.

## Brazil results

- ROC-AUC-tuned model:
  - Best parameters:
    - Euclidean distance.
    - 21 neighbors.
    - Uniform weighting.
  - Cross-validation ROC-AUC: 0.9095.
  - Test accuracy: 0.9385.
  - Positive-class precision: 0.6481.
  - Positive-class recall: 0.2518.
  - Test F1: 0.3627.
  - Test ROC-AUC: 0.8776.
  - Test PR-AUC: 0.4405.
- F1-tuned model:
  - Best parameters:
    - Euclidean distance.
    - 3 neighbors.
    - Uniform weighting.
  - Cross-validation F1: 0.4904.
  - Test accuracy: 0.9380.
  - Positive-class precision: 0.5758.
  - Positive-class recall: 0.4101.
  - Test F1: 0.4790.
  - Test ROC-AUC: 0.8039.
  - Test PR-AUC: 0.3841.
- Key comparison:
  - F1 tuning increased positive recall from about 0.25 to 0.41.
  - F1 tuning increased test F1 from about 0.36 to 0.48.
  - This came with lower precision and lower ranking metrics.
  - Accuracy remained near 0.94 for both models, demonstrating that accuracy concealed substantial minority-class weakness.
- Interpretation already supported by notebook:
  - Brazil was the more informative KNN case.
  - A model can rank cases reasonably well while missing many positive cases at the default classification threshold.
  - Metric selection changes the operational tradeoff.
  - Dataset structure mattered more than the relatively modest differences among distance metrics.

## Overfitting and generalization

- Methods used:
  - Scaling within the modeling workflow.
  - Separate train and test data.
  - Stratified cross-validation.
  - Hyperparameter tuning.
  - Avoiding an arbitrarily tiny value of `k`.
- Evidence:
  - Strong Wisconsin cross-validation and test performance were broadly consistent.
  - Brazil performance remained weaker on minority-class metrics despite tuning, suggesting a real data/model limitation rather than only a poor split.
- **[MISSING COMMENTARY: Explicitly compare training and test performance if training scores were saved.]**
- **[MISSING COMMENTARY: Explain whether the Brazil sample limits generalizability to the full registry.]**

## Expected and unexpected findings

- Expected:
  - Wisconsin would perform strongly.
  - Scaling would be essential.
  - Brazil class imbalance would make accuracy misleading.
- Potentially unexpected:
  - Distance metric mattered less than dataset structure.
  - Brazil ROC-AUC could remain respectable while positive-class recall was very low.
  - F1 tuning improved recall but worsened ROC-AUC and PR-AUC in the test results.
- **[MISSING COMMENTARY: State which of these findings personally surprised you and why.]**

## Suggested KNN figure

- Cross-dataset metric comparison from the notebook.
- Include:
  - Wisconsin ROC-AUC- and F1-tuned results.
  - Brazil ROC-AUC- and F1-tuned results.
- Main caption message:
  - Wisconsin performed strongly across metrics.
  - Brazil accuracy stayed high while recall and F1 remained much lower.
  - Tuning objective materially changed the precision-recall balance.
- **[MISSING: Select and export final figure.]**

# 5. Week 9: Gradient Boosting

## Purpose and setup

- Applied gradient boosting to both supervised datasets.
- Compared gradient boosting with a random-forest baseline.
- Dataset-specific implementation:
  - Wisconsin:
    - Standard `GradientBoostingClassifier`.
    - Full dataset was small enough for conventional tuning and interpretation.
  - Brazil:
    - `HistGradientBoostingClassifier`.
    - A 120,000-row reproducible sample was used.
    - Histogram-based boosting was selected for computational efficiency.
    - Greater attention was paid to imbalance and decision-threshold behavior.

## How gradient boosting works

- Trees are built sequentially.
- Each new tree attempts to improve errors remaining from the earlier ensemble.
- Important hyperparameter relationships:
  - Smaller learning rates generally require more boosting rounds.
  - Tree depth and leaf structure control interaction complexity.
  - More estimators can improve fit but can also increase overfitting.
  - Subsampling can reduce variance and add regularization.
  - Minimum leaf size and maximum leaf nodes constrain model complexity.
  - L2 regularization penalizes overly complex fits.

## Wisconsin tuning and results

- Best parameters:
  - Learning rate: 0.1.
  - Maximum depth: 3.
  - Number of estimators: 300.
  - Subsample: 0.8.
- Gradient boosting test metrics:
  - Accuracy: 0.965.
  - Balanced accuracy: 0.9528.
  - F1: 0.9505.
  - ROC-AUC: 0.9977.
  - Average precision: 0.9966.
- Random forest test metrics:
  - Accuracy: 0.965.
  - Balanced accuracy: 0.9528.
  - F1: 0.9505.
  - ROC-AUC: 0.9958.
  - Average precision: 0.9935.
- Gradient-boosting classification report:
  - Class 0 precision: 0.95.
  - Class 0 recall: 1.00.
  - Class 1 precision: 1.00.
  - Class 1 recall: 0.91.
  - Overall accuracy: approximately 0.97.
- Interpretation:
  - Gradient boosting and random forest produced nearly identical threshold-based performance.
  - Gradient boosting had slightly higher ROC-AUC and average precision.
  - Both models worked very well on this dataset.
  - The small differences do not establish a major practical advantage without additional validation.
- **[MISSING COMMENTARY: Explain whether the slight AUC differences are meaningful for the project.]**

## Brazil tuning and results

- Best `HistGradientBoostingClassifier` parameters:
  - L2 regularization: 0.0.
  - Learning rate: 0.05.
  - Maximum depth: unrestricted/None.
  - Maximum leaf nodes: 31.
  - Minimum samples per leaf: 50.
- Histogram gradient boosting:
  - Accuracy: 0.9535.
  - Balanced accuracy: 0.7350.
  - F1: 0.5917.
  - ROC-AUC: 0.9584.
  - Average precision: 0.6751.
- Random forest:
  - Accuracy: 0.8833.
  - Balanced accuracy: 0.8793.
  - F1: 0.5120.
  - ROC-AUC: 0.9508.
  - Average precision: 0.6392.
- Histogram gradient-boosting classification report at threshold 0.50:
  - Class 0 precision: 0.96.
  - Class 0 recall: 0.99.
  - Positive-class precision: 0.77.
  - Positive-class recall: 0.48.
  - Positive-class F1: 0.59.
- Model comparison:
  - HistGradientBoosting had higher accuracy, F1, ROC-AUC, and average precision.
  - Random forest had substantially higher balanced accuracy.
  - This indicates that the two models made different tradeoffs between majority- and minority-class performance.
- **[MISSING COMMENTARY: Explain why balanced accuracy favored random forest despite its lower overall accuracy and F1.]**

## Threshold analysis

- Default threshold 0.50:
  - Balanced accuracy: 0.7350.
  - F1: 0.5917.
- Highest listed F1:
  - Threshold: 0.325.
  - F1: 0.6428.
  - Balanced accuracy: 0.8106.
- Highest listed balanced accuracy:
  - Threshold: 0.075.
  - Balanced accuracy: 0.8870.
  - F1: 0.4996.
- Intermediate threshold example:
  - Threshold 0.20:
    - Balanced accuracy: 0.8545.
    - F1: 0.6172.
- Main finding:
  - The default threshold was not optimal for either F1 or balanced accuracy.
  - Lowering the threshold improved minority-case detection and balanced accuracy.
  - The preferred threshold depends on the relative cost of missed positive cases versus false alarms.
- **[MISSING COMMENTARY: Select and justify one operating threshold, or clearly state that no deployment threshold is being recommended.]**
- **[MISSING COMMENTARY: Explain the real-world consequence of false negatives and false positives in this outcome definition.]**

## Overfitting and generalization

- Wisconsin controls:
  - Cross-validated hyperparameter tuning.
  - Shallow trees.
  - Subsampling.
  - Held-out test set.
  - Training-deviance plot.
- Brazil controls:
  - Histogram-based implementation for practical tuning.
  - Minimum leaf size.
  - Maximum leaf nodes.
  - Learning-rate tuning.
  - L2-regularization tuning.
  - Held-out test set.
  - Comparison with random forest.
- Notebook interpretation:
  - Depth, leaf size, and related settings matter because they control how easily boosting can overfit.
- **[MISSING COMMENTARY: Describe the actual training-deviance pattern shown in the Wisconsin plot.]**
- **[MISSING COMMENTARY: State whether validation performance plateaued or worsened as boosting rounds increased.]**
- **[MISSING COMMENTARY: Discuss why the selected Brazil model having zero L2 regularization does not mean overfitting was impossible.]**

## Expected and unexpected findings

- Expected:
  - Gradient boosting would perform strongly on Wisconsin.
  - Brazil would require a more efficient implementation.
  - Accuracy alone would be inadequate for Brazil.
- Potentially unexpected:
  - Wisconsin gradient boosting and random forest were almost tied.
  - Brazil random forest had better balanced accuracy while histogram boosting had better F1 and ranking metrics.
  - Changing the threshold improved both F1 and balanced accuracy over the 0.50 default across part of the range.
- **[MISSING COMMENTARY: State what personally surprised you and what you learned from it.]**

## Suggested gradient-boosting figures

- Strong figure option:
  - Brazil threshold versus F1 and balanced accuracy.
- Supporting figure option:
  - Wisconsin and Brazil ROC/precision-recall comparisons.
- Optional interpretation figure:
  - Feature importance or partial-dependence plots from Wisconsin.
- **[MISSING COMMENTARY: Explain the substantive meaning of any features shown before including feature-interpretation plots.]**

# 6. Week 10: K-Means and Silhouette Score

## Purpose and setup

- Applied K-means to both datasets.
- Known outcomes were excluded from clustering.
- Outcomes were used only afterward to compare diagnosis or outcome prevalence across clusters.
- Questions:
  - How does K-means behave on each dataset?
  - What value of k is supported by inertia and silhouette score?
  - How sensitive are clusters to scaling and feature representation?
  - Are cluster assignments stable across random initializations?
  - Do clusters differ descriptively in the known outcome?

## Preprocessing

- Removed:
  - Outcome/target.
  - Diagnosis-year field.
- Median-imputed predictor missingness.
- Standardized every predictor.
- Rationale:
  - K-means minimizes squared Euclidean distance.
  - Unscaled large-unit variables or large numeric codes could dominate.
- Brazil was sampled reproducibly because repeated K-means tuning on the full registry would be computationally expensive.
- Brazil K-means sample: 100,000 rows with `random_state=42`.

## Selection of k

- Evaluated k = 2 through k = 8.
- Used 20 initializations per fit.
- Inertia:
  - Must decline as k increases.
  - Used as an elbow diagnostic rather than a standalone decision rule.
- Silhouette score:
  - Compares within-cluster cohesion with separation from the nearest alternative cluster.
  - Higher values indicate better separation.
- Final k:
  - Selected using the highest silhouette score.
- Wisconsin selected k = 2.
- Wisconsin silhouette: 0.345. Inertia declined with every added cluster and did not provide a decisive elbow; silhouette declined from 0.345 at k=2 to 0.314 at k=3 and 0.280 at k=4, then fell below 0.17 for k=5 through k=8.
- Brazil selected k = 3.
- Brazil silhouette: 0.195. This was the best tested value but still indicated weak separation.

## Stability analysis

- Refit the silhouette-selected solution using five different random seeds.
- Compared assignments with adjusted Rand index.
- Used `n_init = 20` to reduce dependence on one unlucky centroid initialization.
- Interpretation:
  - High ARI indicates reproducible grouping despite arbitrary cluster-label numbering.
  - Stability across seeds is analogous to an overfitting or robustness check.
  - Stability does not prove generalization to a new population.
- Wisconsin repeated-seed mean ARI: 0.993, indicating nearly unchanged assignments across starts.
- Brazil repeated-seed mean ARI: 0.424, indicating substantial reassignment across starts.
- Wisconsin stability supports reproducibility of the partition, but the moderate silhouette means the clusters should still be treated as a broad, imposed split rather than proof of natural biological subtypes.

## PCA visualization

- PCA was used only to display assignments in two dimensions.
- Clusters were fitted in the full standardized feature spaces.
- Visual overlap in two principal components does not prove overlap in the full space.
- **[MISSING RESULT: The current draft does not describe the Wisconsin PCA display.]**
- **[MISSING RESULT: The current draft does not describe the Brazil PCA display.]**
- **[MISSING COMMENTARY: State how much variance the plotted components explained, if shown.]**

## Outcome profiles

- Outcome was added only after clustering.
- Cluster outcome differences:
  - Are descriptive associations.
  - Do not measure predictive accuracy.
  - Do not establish causal mechanisms.
  - Do not validate clinical risk strata.
- Wisconsin k-means clusters contained 189 and 380 observations, with diagnosis rates of 92.6% and 9.7%.
- Brazil k-means outcome rates were 0.7%, 16.6%, and 17.1% across the three groups. **[MISSING RESULT: Add exact cluster sizes if needed.]**
- The Wisconsin diagnosis-rate difference was large and descriptively interesting. Brazil showed one large low-outcome group and two smaller groups near 17% deceased, but the low silhouette and stability prevent treating them as established risk groups.

## Sensitivity to representation

- Wisconsin reduced representation:
  - Ten mean measurement variables.
- Brazil reduced representation:
  - Excluded age, profession code, and morphology code.
- Compared:
  - Silhouette scores.
  - ARI between reduced- and full-feature assignments.
- Purpose:
  - Determine whether clusters reflected robust data structure or were driven by selected feature coding.
- Restricting Wisconsin to the ten mean measurement variables increased silhouette from 0.345 to 0.395 while retaining substantial agreement with the full standardized solution (ARI 0.848). Removing scaling increased silhouette to 0.697 but reduced agreement to ARI 0.521 and changed cluster sizes from 189/380 to 131/438.
- **[MISSING RESULT: The current draft does not report the Brazil full-versus-reduced representation sensitivity values.]**
- Wisconsin shows that a higher silhouette can result from a scale-dominated geometry rather than a better version of the same clustering. Brazil already had weak separation and stability, so any additional representation sensitivity would further reduce confidence.

## Supported interpretation from notebook text

- Wisconsin continuous tumor measurements are more naturally suited to standardized Euclidean geometry.
- Brazil combines:
  - Sparse indicators.
  - Missingness.
  - Coded registry variables.
- Brazil clustering therefore requires greater caution.
- Cluster quality and stability may reflect the representation as much as naturally occurring subgroups.
- Strong substantive evidence would require convergence among:
  - Silhouette.
  - Stability.
  - Sensitivity analysis.
  - PCA display.
  - Outcome profiles.
- Disagreement among these diagnostics should be reported rather than hidden.

## Suggested K-means figure

- One combined figure could include:
  - Silhouette and inertia by k.
  - PCA projection of selected clusters.
- Figure 3 in the current draft combines silhouette and relative inertia, repeated-start ARI, and outcome profiles.
- A compact table could summarize:
  - Selected k.
  - Silhouette.
  - Mean/minimum ARI.
  - Cluster sizes.
  - Outcome prevalence differences.
- Remember that the table counts toward the rubric’s figure total.

# 7. Week 11: DBSCAN and Hierarchical Agglomerative Clustering

## Shared setup

- Applied both methods to Wisconsin and Brazil.
- Target was excluded from fitting.
- Target was added back afterward only for descriptive outcome profiles.
- Predictors were:
  - Median-imputed.
  - Standardized.
- Brazil used a reproducible sample because both methods require neighborhood or pairwise-distance calculations.
- Hierarchical clustering specifically used a documented 5,000-row Brazil sample.
- Brazil DBSCAN sample: 30,000 rows with `random_state=42`.

## 7.1 DBSCAN

### Purpose

- DBSCAN was treated as the primary Week 11 analysis.
- It asks whether the data form sufficiently dense regions under a chosen distance scale.
- It can leave isolated observations unassigned as noise.
- This differs from methods that force every point into a cluster.

### Hyperparameters

- `eps`:
  - Neighborhood radius.
  - Larger values make more observations neighbors.
  - Usually reduces the noise fraction and may merge clusters.
- `min_samples`:
  - Number of observations required to define a dense core point.
  - Larger values make the density criterion stricter.
- For each configuration, the notebook was designed to record:
  - Number of clusters.
  - Noise fraction.
  - Silhouette score among non-noise observations.
- Silhouette is not meaningful when:
  - Every observation is noise.
  - Only one non-noise cluster remains.

### Selection rule

- Preferred configuration:
  - Highest non-noise silhouette.
  - At least two clusters.
  - No more than 80% noise.
- Reason:
  - Prevents choosing a trivial result with excellent separation among a tiny retained subset while labeling almost everyone else as noise.
- Limitation:
  - The 80% cap is an exploratory project rule, not a universal DBSCAN standard.
- **[MISSING COMMENTARY: Explain why an 80% cap is reasonable—or revise the threshold before reporting it.]**

### Wisconsin results

- Selected `eps`: 2.2.
- Selected `min_samples`: 10.
- Selected solution retained multiple non-noise clusters. **[MISSING RESULT: Add the exact Wisconsin cluster count if required.]**
- Noise fraction: 63.1%.
- Non-noise silhouette: 0.416.
- The Wisconsin grid was highly sensitive: eps 0.3-1.0 labeled all observations as noise; eps=1.7/min_samples=10 retained one cluster with 92.1% noise; eps=2.2/min_samples=5 reduced noise to 54.8% but produced four clusters with silhouette 0.166.
- **[MISSING COMMENTARY: The draft does not profile the Wisconsin noise observations substantively.]**

### Brazil results

- Selected `eps`: 0.5.
- Selected `min_samples`: 20.
- Number of non-noise clusters: 63.
- Noise fraction: 48.3%.
- Non-noise silhouette: 0.541.
- The selected Brazil result combined a reasonably high non-noise silhouette with nearly half the data labeled noise and 63 retained clusters, demonstrating that silhouette alone did not yield a practical segmentation.
- The draft treats Brazil DBSCAN as evidence that some local dense regions existed, not as a manageable or interpretable patient segmentation.

### Robustness and overfitting

- DBSCAN is deterministic for fixed data and parameters.
- The main robustness question is parameter sensitivity, not random initialization.
- Noise was kept as a descriptive category rather than silently discarded.
- A high silhouette with extreme noise is not automatically a good solution.
- A low silhouette is evidence that the representation does not support well-separated dense regions.

## 7.2 Hierarchical agglomerative clustering

### Purpose and setup

- Starts with each observation in its own cluster.
- Repeatedly merges the closest groups.
- Unlike DBSCAN:
  - Does not identify noise by itself.
  - Produces a complete partition.
  - Requires a requested number of clusters.
- Compared:
  - Ward linkage.
  - Average linkage.
  - k = 2 through k = 8.
- Ward linkage:
  - Minimizes increases in within-cluster variance.
- Average linkage:
  - Uses average pairwise distances between clusters.
  - Serves as a sensitivity comparison.

### Wisconsin results

- Average linkage produced the highest silhouette, but Ward linkage produced the more interpretable balanced split.
- k = 2 for the main comparison.
- Average-linkage silhouette: 0.634; Ward-linkage silhouette: 0.339.
- Average-linkage split: 566/3. Ward-linkage split: 184/385. **[MISSING RESULT: Add diagnosis prevalence by hierarchical cluster if required.]**
- Ward and average linkage did not agree structurally. Average linkage improved silhouette by isolating only three observations, while Ward produced a much more balanced partition.

### Brazil results

- Based on a 5,000-row sample with `random_state=42`.
- Average linkage produced the highest silhouette, but its partition was not substantively useful.
- k = 2.
- Average-linkage silhouette: 0.876.
- Average-linkage split: 4,998/2. **[MISSING RESULT: Add outcome prevalence by hierarchical cluster if required.]**
- The 5,000-row sample was selected for computational feasibility, so the exact partition and extreme observations may vary across other samples from the approximately 1.74-million-record registry.
- The draft reports that the highest-scoring average-linkage solution was an almost one-cluster partition and therefore prefers balanced structure over the maximum silhouette alone. **[MISSING RESULT: Add the exact Brazil Ward solution if needed.]**

## DBSCAN versus hierarchical clustering

- DBSCAN:
  - Searches for dense regions.
  - Can label points as noise.
  - Is sensitive to eps, min_samples, scaling, and dimensionality.
- Hierarchical clustering:
  - Forces all observations into a partition.
  - Can produce groups even when natural separation is weak.
  - Depends on linkage choice and requested k.
- Interpretive lesson already stated in notebook:
  - Hierarchical clustering can hide the possibility that the data do not contain naturally separated groups.
  - DBSCAN can more openly reveal weak density structure through high noise or unstable parameter behavior.
- Neither Week 11 method produced a fully convincing segmentation. For Wisconsin, Ward hierarchical clustering was more interpretable than average linkage or high-noise DBSCAN. For Brazil, neither the 63-cluster DBSCAN solution nor the 4,998/2 hierarchical split was suitable to carry forward.

## Suggested Week 11 figure

- Strong option:
  - DBSCAN parameter heatmap or plot showing silhouette and noise fraction across eps and min_samples.
- Supporting option:
  - Side-by-side PCA views of DBSCAN and hierarchical assignments.
- Alternative:
  - A table comparing selected parameters, cluster count, noise, and silhouette across datasets.
- Figure 4 in the current draft compares DBSCAN noise/silhouette/cluster count with hierarchical linkage scores and extreme cluster-size imbalance.

# 8. Cross-Model Findings and Supported Conclusions

## Question 1: How well can the known outcomes be classified?

- Wisconsin:
  - KNN and gradient boosting both performed strongly.
  - Best reported KNN F1-tuned test performance:
    - Accuracy: 0.9649.
    - F1: 0.9500.
  - Gradient boosting:
    - Accuracy: 0.965.
    - F1: 0.9505.
    - ROC-AUC: 0.9977.
  - Supported conclusion:
    - The Wisconsin features contain strong information for diagnosis under both a distance-based model and a nonlinear tree ensemble.
  - Caution:
    - **[MISSING COMMENTARY: Explain why high performance on this dataset does not establish clinical deployment readiness.]**
- Brazil:
  - KNN struggled with positive-case recall and F1.
  - Histogram gradient boosting improved ranking and F1 substantially.
  - At threshold 0.50:
    - HistGradientBoosting positive recall: 0.48.
    - HistGradientBoosting F1: 0.5917.
    - KNN F1-tuned recall: 0.4101.
    - KNN F1-tuned F1: 0.4790.
  - Supported conclusion:
    - A nonlinear boosting model captured more useful outcome-related structure than KNN in the sampled Brazil data.
  - Caution:
    - Performance depends strongly on the classification threshold and the chosen metric.

## Question 2: What did class imbalance change?

- Brazil accuracy remained high even when minority recall was weak.
- KNN examples:
  - Accuracy near 0.94.
  - Recall between approximately 0.25 and 0.41.
- HistGradientBoosting:
  - Accuracy approximately 0.95.
  - Positive recall 0.48 at threshold 0.50.
- Supported conclusion:
  - Accuracy alone was insufficient for evaluating the Brazil outcome.
  - Recall, F1, balanced accuracy, and average precision revealed important differences hidden by accuracy.
- Threshold analysis further showed:
  - Model quality cannot be summarized entirely by the default 0.50 cutoff.
- **[MISSING COMMENTARY: Explain which error type matters most for the project and why.]**

## Question 3: Did unsupervised methods reveal meaningful groups?

- Methodological evidence available:
  - K-means:
    - Silhouette-based k selection.
    - Repeated-seed ARI.
    - Representation sensitivity.
    - PCA display.
    - Outcome profiles.
  - DBSCAN:
    - Parameter sensitivity.
    - Noise fraction.
    - Non-noise silhouette.
    - Outcome profiles.
  - Hierarchical clustering:
    - Linkage and k comparison.
    - Complete partition for contrast with DBSCAN.
- Numerical clustering results are now available and included above.
- Wisconsin k-means produced a reproducible broad split, but moderate silhouette and representation sensitivity limit stronger claims. Brazil diagnostics did not converge on a credible cluster structure: k-means separation and stability were weak, DBSCAN had high noise and many clusters, and hierarchical clustering rewarded trivial partitions.
- Required caution:
  - Cluster outcome differences are exploratory associations.
  - Stable clusters are not automatically biologically meaningful.
  - High silhouette among a small non-noise subset may be misleading.
  - Forced hierarchical partitions may appear interpretable even without natural separation.

## Cross-dataset conclusion

- Wisconsin:
  - Better suited to standard distance geometry.
  - Strong supervised performance.
  - K-means produced a stable broad split, although only moderate separation and sensitivity to scaling limited claims of natural subtypes.
- Brazil:
  - Imbalance affected supervised evaluation.
  - Heterogeneous and coded features complicated distance-based models.
  - Gradient boosting was better able than KNN to capture nonlinear structure.
  - Unsupervised findings require greater caution because representation may drive the geometry.
- Broad supported lesson:
  - The appropriateness of the workflow depends on dataset structure.
  - The same method should not be applied identically without considering sample size, imbalance, feature scale, sparsity, and coding.

# 9. Limitations and Implications

## Limitations already supported by notebooks

- Samples rather than full data were used for several Brazil analyses.
- Findings may vary with the sampled observations.
- Distance-based methods are sensitive to:
  - Scaling.
  - Feature coding.
  - Dimensionality.
  - Representation.
- Numeric registry codes may create artificial distances.
- KNN is computationally burdensome on very large datasets.
- K-means imposes approximately spherical Euclidean clusters.
- DBSCAN is sensitive to eps and min_samples and may struggle in high dimensions.
- Hierarchical clustering forces every observation into a cluster.
- PCA plots show only a two-dimensional projection.
- Cluster outcome profiles are descriptive, not causal or validated predictive strata.
- A stable clustering result does not prove external generalizability.
- Threshold selection was evaluated on the available data and would need independent validation before deployment.

## Missing limitations to address

- **[MISSING COMMENTARY: Dataset provenance and data-quality limitations.]**
- **[MISSING COMMENTARY: Whether the Brazil outcome is subject to follow-up duration, censoring, or registry-reporting issues.]**
- **[MISSING COMMENTARY: Whether any predictors could leak information collected after the outcome.]**
- **[MISSING COMMENTARY: Demographic or representativeness limitations.]**
- **[MISSING COMMENTARY: Whether model probabilities were calibrated.]**
- **[MISSING COMMENTARY: Whether repeated or nested cross-validation would provide a less optimistic estimate.]**

## Implications and next steps

- Validate the best supervised models on an independent dataset or untouched validation sample.
- Select operating thresholds based on the practical cost of false negatives and false positives.
- Evaluate probability calibration if predicted probabilities will be interpreted directly.
- Run and verify the Week 10 and 11 notebooks before drawing clustering conclusions.
- Test alternative Brazil feature representations that treat coded variables appropriately.
- Consider dimensionality reduction or mixed-data distance methods before clustering Brazil.
- Compare cluster stability across independent samples.
- **[MISSING COMMENTARY: Choose only the next steps most relevant to your intended audience.]**

# 10. Figure and Table Plan

- **Figure 1:** Dataset class-balance comparison.
- **Figure 2:** KNN cross-dataset metric comparison.
- **Figure 3:** Brazil gradient-boosting threshold tradeoff.
- **Figure 4:** K-means k-selection and/or PCA result.
- **Figure 5:** DBSCAN parameter sensitivity and noise fraction.
- Optional **Table 1:** Supervised-model performance summary.
- Optional **Table 2:** Clustering diagnostics summary.
- Keep total figures plus tables within the required 3–8.
- The current draft uses four visuals: Brazil threshold tradeoff; supervised generalization evidence; K-means tuning/stability/outcome profiles; and DBSCAN/hierarchical clustering cautions. Table 1 summarizes dataset characteristics and supervised performance.

# 11. References

- **[MISSING: Add dataset source for Wisconsin.]**
- **[MISSING: Add dataset source for Brazil.]**
- Scikit-learn Developers (2026a), *Nearest neighbors* user guide.
- Scikit-learn Developers (2026b), *Ensembles* user guide.
- Scikit-learn Developers (2026c), *Clustering* user guide.
- Scikit-learn Developers (2026c), *Clustering* user guide.
- Scikit-learn Developers (2026c), *Clustering* user guide.
- The draft uses the nearest-neighbors guide for KNN controls, the ensemble guide for standard versus histogram gradient boosting, the clustering guide for k-means/silhouette/DBSCAN/agglomerative definitions, and the metrics guide for matching evaluation metrics to the prediction goal.

# Appendix A: AI Use Statement

- Week 10 notebook states that AI assistance was used to:
  - Organize the notebook workflow.
  - Identify Milestone 2 rubric requirements.
  - Draft analysis-cell language.
  - Suggest diagnostic comparisons.
- Week 11 notebook states the same categories of AI assistance.
- Both notebooks state that:
  - Data loading.
  - Model fitting.
  - Metrics.
  - Plots.
  - Interpretations.
  - Should be reviewed and verified by the student.
- **[MISSING COMMENTARY: Add the AI use associated with Weeks 8 and 9.]**
- **[MISSING COMMENTARY: Add AI use in preparing the final report and outline.]**
- **[MISSING COMMENTARY: State specifically how you checked calculations, code execution, and interpretations.]**

# Appendix B: Jupyter Notebooks

- Week 8: `08_week8_knn_distance_metrics(2).ipynb`
- Week 9: `09_week9_gradient_boosting(2).ipynb`
- Week 10: `10_week10_kmeans_silhouette(2).ipynb`
- Week 11: `11_week11_dbscan_hierarchical(2).ipynb`
- **[MISSING: Add Week 12 notebook if required.]**
- **[MISSING: Add full GitHub repository URL.]**

# Critical Items to Complete Before Drafting Prose

- [x] Week 10 and Week 11 results have been reproduced and incorporated into the current draft.
- [x] K-means selected-k, silhouette, ARI, main cluster-profile, and Wisconsin sensitivity results added.
- [x] Main DBSCAN parameters, cluster count, noise, and silhouette results added. **[MISSING: Add outcome profiles only if required.]**
- [x] Main hierarchical linkage, k, silhouette, and cluster-size results added. **[MISSING: Add outcome profiles only if required.]**
- [x] Deep dives selected: Week 10 K-means and Week 11 DBSCAN/hierarchical clustering.
- Add project impact and intended audience.
- Add full dataset provenance.
- [x] Scikit-learn and JMLR references added in the current draft.
- Explain the real-world importance of false negatives versus false positives.
- Review every AI-generated analysis sentence against the actual outputs before using it.