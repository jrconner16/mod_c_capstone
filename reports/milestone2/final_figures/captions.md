# Final Milestone 2 visual captions

**Table 1. Dataset characteristics and headline supervised-model performance.** Wisconsin uses all 569 observations, while Brazil uses reproducible method-specific samples from the full registry. The table reports the strongest KNN and gradient-boosting results and emphasizes that Brazil's minority-class performance requires more than accuracy alone.

**Figure 1. Brazil gradient boosting: threshold tradeoff.** Precision, recall, and F1 are shown across the existing candidate probability thresholds. The default 0.50 cutoff and the approximately 0.325 F1-maximizing cutoff are marked; lowering the threshold improves the balance of positive-class predictions for this imbalanced outcome.

**Figure 2. Supervised generalization evidence.** Training, cross-validation, and held-out test ROC-AUC and PR-AUC are compared for the selected KNN and gradient-boosting models. CV bars are means from the already-selected estimators. Wisconsin remains consistently strong, whereas Brazil KNN shows the largest CV-to-test decline, especially for PR-AUC.

**Figure 3. K-means tuning, stability, and cluster profiles.** Silhouette and relative inertia show the k-selection process, repeated-start ARI shows assignment stability, and the final bars show known outcome rates with cluster sizes. Wisconsin is stable across starts; Brazil's lower stability limits unsupervised subgroup claims.

**Figure 4. DBSCAN and hierarchical-clustering cautions.** DBSCAN panels show how eps and min_samples change noise, non-noise silhouette, and cluster count. The hierarchical panels show linkage/silhouette comparisons and the extreme 566/3 and 4,998/2 partitions, illustrating why a high internal score can still describe an impractical segmentation.

## Production notes

- Source values: `reports/milestone2/milestone2_results_table.md`, the cited figure-ready draft, and the Week 8–11 notebooks.
- Precision and recall in Figure 1 were derived at the threshold grid from the existing Week 9 Brazil model setup because the saved threshold cell recorded F1 and balanced accuracy only.
- Week 8 and Week 9 selected-model CV values were added by cross-validating the saved winning parameter sets for ROC-AUC and average precision; none of the grid searches were repeated.
