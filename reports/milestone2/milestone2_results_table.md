# Milestone 2 Consolidated Results Table — Working Draft

This is a drafting table, not the final paper table. Supervised results below come from saved Week 8–9 notebook outputs. Week 10–11 values were reproduced directly from the current notebook code with `random_state=42`; the notebooks themselves were not saved with execution outputs, so the remaining check is presentation-level confirmation against the student's local run.

## Dataset facts

| Dataset | Rows used | Predictors | Outcome rate | Modeling note |
|---|---:|---:|---:|---|
| Wisconsin | 569 | 30 | 37.3% diagnosis=1 | Full dataset; numeric tumor measurements; no missing predictor values |
| Brazil | 1,742,813 full; samples vary by notebook | 39 after loader preprocessing | About 7.0% deceased=1 | Large, mixed registry features; sampled for computationally heavy methods |

## Primary modeling results

| Week / technique | Dataset | Setup / tuning choice | Primary metric | Secondary metrics | Draft interpretation | Limitation or caution |
|---|---|---|---|---|---|---|
| Week 8 KNN | Wisconsin | ROC-AUC tuning; Euclidean, k=11, distance weights | CV ROC-AUC 0.989; test ROC-AUC 0.982 | CV PR-AUC 0.988; test PR-AUC 0.979; accuracy 0.947; precision 0.974; recall 0.881; F1 0.925 | KNN performed strongly after scaling; metric choice mattered less than the clean, separable data structure. | Single held-out split; performance is not directly comparable to Brazil because datasets differ. |
| Week 8 KNN | Brazil | ROC-AUC tuning; Euclidean, k=21, uniform weights | CV ROC-AUC 0.909; test ROC-AUC 0.878 | CV PR-AUC 0.517; test PR-AUC 0.441; accuracy 0.939; precision 0.648; recall 0.252; F1 0.363 | Ranking was useful, but default classification missed many positive outcomes. | Severe class imbalance; sample size and threshold choice affect the result. |
| Week 8 KNN | Brazil | F1 tuning; Euclidean, k=3, uniform weights | CV F1 0.490; test F1 0.479 | Precision 0.576; recall 0.410; accuracy 0.938; PR-AUC 0.384 | F1 tuning improved recall and F1 relative to ROC-AUC tuning, showing the metric/decision-goal tradeoff. | Improved recall came with weaker ranking metrics; no single setting is best for every use case. |
| Week 9 gradient boosting | Wisconsin | GradientBoosting; learning rate 0.1, depth 3, 300 estimators, subsample 0.8 | CV ROC-AUC 0.993; test ROC-AUC 0.998 | CV PR-AUC 0.991; test PR-AUC 0.997; accuracy 0.965; balanced accuracy 0.953; F1 0.951 | Gradient boosting was near ceiling, consistent with Wisconsin's strong signal. | Near-ceiling results leave little room to distinguish methods; overfitting evidence still matters. |
| Week 9 gradient boosting | Brazil | HistGradientBoosting; learning rate 0.05, max leaf nodes 31, min leaf 50 | CV ROC-AUC 0.958; test ROC-AUC 0.958 | CV PR-AUC 0.680; test PR-AUC 0.675; accuracy 0.954; balanced accuracy 0.735; F1 0.592 | Boosting improved ranking and positive-class balance relative to the random-forest comparison in the notebook. | Accuracy remains inflated by the majority class; sample-based evaluation and threshold choice matter. |
| Week 10 k-means | Wisconsin | Standardized predictors; selected k=2 by silhouette | Silhouette 0.345 | Inertia 11,595.5; repeated-start ARI mean 0.993 | Two broad groups were reasonably stable and had sharply different diagnosis rates. | Silhouette is moderate rather than excellent; cluster labels are descriptive, not diagnostic predictions. |
| Week 10 k-means | Brazil | 100,000-row sample; standardized predictors; selected k=3 | Silhouette 0.195 | Inertia 3,547,194.4; repeated-start ARI mean 0.424 | Brazil's clusters were weaker and substantially less stable, suggesting representation-sensitive structure. | Unsupervised sample; low stability limits strong subgroup claims. |
| Week 11 DBSCAN | Wisconsin | Standardized predictors; eps=2.2, min_samples=10 | Non-noise silhouette 0.416 | 2 clusters; noise fraction 0.631 | DBSCAN found a small dense group plus a large noise set under the selected rule. | The 63.1% noise fraction is substantial and may make the solution unsuitable as a complete segmentation. |
| Week 11 DBSCAN | Brazil | 30,000-row sample; standardized predictors; eps=0.5, min_samples=20 | Non-noise silhouette 0.541 | 63 clusters; noise fraction 0.483 | The selected density solution had moderate non-noise separation but many small clusters and nearly half the observations labeled noise. | High cluster count and noise fraction complicate substantive interpretation. |
| Week 11 hierarchical | Wisconsin | Average linkage; selected k=2 | Silhouette 0.634 | No noise; one cluster contained 566 observations and the other 3 | Average linkage produced a higher internal score than DBSCAN and Ward linkage. | The highly unbalanced partition is not automatically a meaningful clinical grouping. |
| Week 11 hierarchical | Brazil | Average linkage; 5,000-row sample; selected k=2 | Silhouette 0.876 | No noise; one cluster contained 4,998 observations and the other 2 | The very high score reflects an almost entirely dominant cluster, not necessarily useful segmentation. | This is a key cautionary result: silhouette alone can reward a trivial, highly unbalanced partition. |

## Week 10 cluster outcome profiles

| Dataset | Cluster | n | Known outcome rate |
|---|---:|---:|---:|
| Wisconsin | 0 | 189 | 92.6% diagnosis=1 |
| Wisconsin | 1 | 380 | 9.7% diagnosis=1 |
| Brazil | 0 | 61,328 | 0.7% deceased=1 |
| Brazil | 1 | 2,924 | 16.6% deceased=1 |
| Brazil | 2 | 35,748 | 17.1% deceased=1 |

These are post-clustering descriptive associations. They should not be described as causal effects, validated risk groups, or supervised predictive performance.

## Generalization and overfitting evidence

The following values use the saved splits and selected parameters from the Week 8 and Week 9 notebooks. Train scores show fit to the training data. The Week 8 and Week 9 notebooks now report ROC-AUC and PR-AUC from cross-validation of the already-selected estimators. These reporting cells refit only the winning models and do not repeat the grid searches.

| Week / dataset / setup | Train ROC-AUC | CV ROC-AUC | Test ROC-AUC | Train PR-AUC | CV PR-AUC | Test PR-AUC | Train F1 | Test F1 | Generalization reading |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| Week 8 Wisconsin, ROC-AUC-tuned KNN | 1.0000 | 0.9892 | 0.9823 | 1.0000 | 0.9875 | 0.9794 | — | 0.9250 | Small train-to-test drop; strong but not perfect generalization. |
| Week 8 Wisconsin, F1-tuned KNN | 0.9986 | 0.9667 | 0.9735 | 0.9959 | — | 0.9656 | — | 0.9500 | Test score is close to CV; no large generalization warning. |
| Week 8 Brazil, ROC-AUC-tuned KNN | 0.9538 | 0.9094 | 0.8776 | 0.5966 | 0.5165 | 0.4408 | — | 0.3627 | Noticeable train-to-test and CV-to-test degradation, especially for PR-AUC. |
| Week 8 Brazil, F1-tuned KNN | 0.9845 | 0.4904 | 0.8039 | 0.7690 | — | 0.3841 | — | 0.4790 | The low CV F1 and higher held-out F1 show instability; this setting should not be presented as a stable win without replication. |
| Week 9 Wisconsin gradient boosting | 1.0000 | 0.9929 | 0.9977 | 1.0000 | 0.9909 | 0.9966 | 1.0000 | 0.9505 | Ranking metrics stay near ceiling, but the perfect train F1 versus lower test F1 still supports discussing overfit control. |
| Week 9 Brazil HistGradientBoosting | 0.9673 | 0.9577 | 0.9584 | 0.7401 | 0.6803 | 0.6751 | 0.6351 | 0.5917 | Moderate train/test gaps; regularization, early stopping, and held-out testing remain important. |

The clustering methods do not have train/test scores in the same supervised sense. Their corresponding safeguards are parameter sensitivity, repeated initialization stability for k-means, noise-fraction checks for DBSCAN, and cluster-balance inspection for hierarchical clustering.

## Compact paper-facing comparison table

This is the smaller table to consider for the paper body. It is intentionally less detailed than the working table above.

| Method | Wisconsin headline | Brazil headline | Paper use |
|---|---|---|---|
| KNN | Test ROC-AUC 0.982; F1 0.950 under F1 tuning | Test ROC-AUC 0.878; F1 0.479 under F1 tuning; ROC-AUC tuning recall only 0.252 | Shows why scaling, distance choices, and evaluation goals matter. |
| Gradient boosting | Test ROC-AUC 0.998; PR-AUC 0.997 | Test ROC-AUC 0.958; PR-AUC 0.675; F1 0.592 | Strong supervised benchmark, but Brazil still needs imbalance-aware metrics. |
| K-means | k=2; silhouette 0.345; stability ARI 0.993 | k=3; silhouette 0.195; stability ARI 0.424 | Supports a depth discussion of k selection, representation, and stability. |
| DBSCAN | Non-noise silhouette 0.416; 63.1% noise | Non-noise silhouette 0.541; 63 clusters; 48.3% noise | Shows that internal separation can coexist with impractical noise/cluster structure. |
| Hierarchical average linkage | k=2; silhouette 0.634; 566/3 split | k=2; silhouette 0.876; 4,998/2 split | Best cautionary example: high silhouette can reward a trivial partition. |

## Week 11 interpretation notes

- Wisconsin DBSCAN selected a solution with 63.1% noise, while hierarchical average linkage assigned nearly every observation to one cluster. Both results show why cluster count and silhouette must be interpreted with balance and substantive meaning.
- Brazil DBSCAN selected 63 clusters with 48.3% noise. This is a useful warning against presenting density clusters as simple patient subtypes without examining cluster sizes and feature profiles.
- Brazil hierarchical average linkage produced silhouette 0.876 but assigned 4,998 of 5,000 observations to one cluster. This is likely the most important unexpected result in Week 11: a very high silhouette can accompany an uninformative partition.
- The provisional depth story is therefore stronger if it emphasizes diagnostic skepticism, parameter sensitivity, and the difference between internal metrics and useful segmentation.

## Actionable table checklist

- [x] Confirm Week 10 values by rerunning the current notebook code with the documented seed. The reproduced selections are Wisconsin k=2, silhouette 0.345; Brazil k=3, silhouette 0.195.
- [x] Confirm Week 11 values by rerunning the current notebook code with the documented seeds. The reproduced selections are Wisconsin DBSCAN eps=2.2/min_samples=10, silhouette 0.416; Brazil DBSCAN eps=0.5/min_samples=20, silhouette 0.541; hierarchical average linkage k=2 for both datasets.
- [x] Lock the Week 10 Brazil sample description at 100,000 rows with random_state=42.
- [x] Lock the Week 11 Brazil descriptions at 30,000 rows for DBSCAN and 5,000 rows for hierarchical clustering, both with random_state=42.
- [x] Add the exact final Week 8 and Week 9 hyperparameters from the saved outputs.
- [x] Convert the Week 11 extreme hierarchical partitions into a specific result: Wisconsin average linkage produced a 566/3 split; Brazil produced a 4,998/2 split. Treat this as evidence that silhouette alone is insufficient, not as a substantive segmentation result.
- [x] Add train/CV/test gaps where the notebooks expose them. Week 8 and Week 9 now report selected-model ROC-AUC and PR-AUC CV means and standard deviations without repeating the grid searches.
- [x] Create the compact paper-facing comparison table above.
- [ ] Select the final 3–8 body figures after reviewing all notebook outputs.

## Next work items, in order

1. Review the actual Week 10–11 plots and decide which findings deserve figures rather than prose.
2. Populate the Week 12 summary-figures notebook from the verified rows.
