# Milestone 2 Roadmap: From Completed Notebooks to a Strong Rough Draft

## Goal

Turn the Week 8–11 notebooks into an 8–10 page Milestone 2 summary that is clearly organized, evidence-supported, and safely above the level of the Milestone 2 rubric. The immediate target is a strong rough draft, not final formatting or a final selection of paper figures.

The paper should make one central argument:

> The two cancer datasets require different modeling and evaluation choices. Wisconsin is small, clean, and comparatively separable; Brazil is much larger, heterogeneous, and strongly imbalanced. Model behavior, metric choice, scaling, sampling, and clustering assumptions must therefore be interpreted in relation to dataset structure rather than treated as universal facts.

## Current State

### Status update

The Week 10 and Week 11 notebooks have now been run and reviewed. The main results table has been started and now includes verified modeling results, generalization evidence where available, a compact paper-facing comparison table, and an actionable checklist.

Current key results:

- Wisconsin k-means selected k=2 with silhouette 0.345 and repeated-start ARI about 0.993.
- Brazil k-means selected k=3 with silhouette 0.195 and repeated-start ARI about 0.424.
- Wisconsin DBSCAN selected eps=2.2 and min_samples=10, with non-noise silhouette 0.416 but 63.1% noise.
- Brazil DBSCAN selected eps=0.5 and min_samples=20, with non-noise silhouette 0.541, 63 clusters, and 48.3% noise.
- Hierarchical average linkage produced a 566/3 split for Wisconsin and a 4,998/2 split for Brazil. These results demonstrate why silhouette alone is not enough to establish useful segmentation.
- Week 8 train/CV/test evidence has been extracted for the overfitting discussion.
- Week 9 train/test evidence has been extracted using the saved best parameters; the saved notebook does not expose the selected grid-search CV score in its result table.

Working results file:

- `reports/milestone2/milestone2_results_table.md`

### Completed or substantially developed

- Week 8 KNN notebook exists and covers both datasets, distance metrics, tuning, and cross-dataset comparison.
- Week 9 gradient boosting notebook exists and covers both datasets, tuning, metrics, threshold behavior, and feature interpretation.
- Week 10 k-means notebook has been built as a notebook-only analysis for both datasets.
- Week 10 includes k tuning, inertia, silhouette scores, stability checks, PCA visualization, outcome profiles, and feature/scaling sensitivity.
- Week 11 DBSCAN/hierarchical notebook has been built as a notebook-only analysis for both datasets.
- Week 11 includes DBSCAN parameter sensitivity, noise analysis, PCA visualization, outcome profiles, and hierarchical linkage/k comparisons.
- The Milestone 2 rubric and clarifier are available in the project root.

### Still needed

- Run and inspect the Week 10 and Week 11 notebooks locally, confirming that all outputs are populated and interpretable.
- Check Week 8 and Week 9 notebooks for consistent terminology, dataset descriptions, sample sizes, random seeds, and metrics.
- Complete Week 12 summary figures notebook after the final results are known.
- Build a consolidated results table for all four Milestone 2 topics.
- Choose and explicitly label one or two depth topics.
- Write the rough draft in the required 8–10 page structure.
- Add citations, the AI appendix, notebook appendix/repository link, and final formatting.

## Rubric Strategy

Breadth and depth are worth 60 points together, so the paper should prioritize the modeling discussion over a long introduction or generic background section.

### Breadth

Cover all four Milestone 2 topics:

1. Week 8: KNN and distance metrics.
2. Week 9: Gradient boosting.
3. Week 10: K-means and silhouette score.
4. Week 11: DBSCAN and hierarchical agglomerative clustering.

For every topic, state:

- what was applied to Wisconsin and Brazil;
- why the setup was reasonable;
- what was tuned;
- which metrics were used;
- the strongest numerical result;
- what the result means;
- the main limitation or overfitting concern.

Breadth sections should be concise but complete. Avoid turning them into notebook transcripts.

### Provisional depth recommendation

The strongest current depth pairing is likely:

- **Week 10: K-means and silhouette score**, because it supports a full walkthrough of k selection, scaling, feature representation, stability, PCA visualization, and outcome profiles.
- **Week 11: DBSCAN and hierarchical clustering**, because it creates a meaningful contrast between density-based grouping, noise labeling, and forced hierarchical partitions.

This pairing should be confirmed after inspecting the actual Week 10 and Week 11 outputs. If one week produces weak or unstable evidence, use only the stronger week for depth and keep the other at breadth level. Do not force two depth sections merely to fill space.

## Notebook Completion Checklist

### Week 8: KNN

File: `notebooks/milestone2/08_week8_knn_distance_metrics.ipynb`

- Confirm both datasets are represented.
- Confirm scaling is inside the modeling pipeline.
- Confirm Euclidean and Manhattan distance are compared.
- Confirm `k` and distance metric tuning are visible.
- Report ROC-AUC and F1 tuning separately where appropriate.
- Explain why accuracy is not sufficient for Brazil.
- Record the Brazil sample size and random seed.
- Preserve one compact comparison table for the paper.

### Week 9: Gradient Boosting

File: `notebooks/milestone2/09_week9_gradient_boosting.ipynb`

- Confirm both datasets are represented.
- Confirm the model choice is explained: regular gradient boosting for Wisconsin and an efficient histogram-based approach for Brazil if that remains the final setup.
- Record tuned learning rate, depth, number of estimators/iterations, and any early-stopping decision.
- Report train-versus-validation/test evidence where available.
- Use ROC-AUC and average precision/PR-AUC for Brazil, not accuracy alone.
- Keep one model-comparison table and one interpretation paragraph.

### Week 10: K-means

File: `notebooks/milestone2/10_week10_kmeans_silhouette.ipynb`

- Run all cells locally and confirm outputs are saved/populated.
- Record selected k and silhouette score for each dataset.
- Record inertia/elbow behavior.
- Record repeated-start stability results.
- Record scaled/unscaled and feature-representation sensitivity.
- Explain that outcome rates are post-clustering descriptive associations, not prediction or causation.
- Decide whether the evidence is strong enough for depth.

### Week 11: DBSCAN and hierarchical clustering

File: `notebooks/milestone2/11_week11_dbscan_hierarchical.ipynb`

- Run all cells locally and confirm outputs are saved/populated.
- Record DBSCAN `eps`, `min_samples`, number of clusters, and noise fraction for each dataset.
- Explain the tradeoff between silhouette and excessive noise.
- Record hierarchical linkage, selected k, and silhouette score.
- Keep the Brazil sample sizes explicit for both methods.
- Compare whether DBSCAN and hierarchical clustering tell a consistent story.
- Decide whether Week 11 is depth-worthy or should remain a breadth section.

## Results Extraction Before Writing

Create one working table outside the prose with these columns:

| Week | Dataset | Method/setup | Main tuning choice | Primary metric | Secondary metric | Main interpretation | Limitation |
|---|---|---|---|---|---|---|---|

Populate it from notebook outputs only. This table is for drafting and may not appear in the final paper.

Also create a short dataset facts table:

- Wisconsin rows, predictors, outcome definition, outcome balance.
- Brazil full rows, analysis sample size, predictors, outcome definition, outcome prevalence, missingness treatment.
- Which methods used sampling and why.

This prevents inconsistent numbers from appearing in different sections of the paper.

## Rough-Draft Paper Structure

### 1. Problem Statement and Project Description

Target length: approximately 0.5 page.

Include:

- the project goal;
- the Wisconsin and Brazil datasets;
- the distinction between diagnosis classification and deceased-outcome modeling;
- why reliable evaluation matters;
- the potential impact of identifying useful patterns without overstating clinical conclusions.

### 2. Data Preparation and Evaluation Strategy

Target length: approximately 0.75 page.

Include:

- loader and preprocessing choices;
- scaling rationale;
- missing-value handling;
- Brazil sampling and reproducibility;
- target leakage prevention;
- why different metrics are needed across datasets.

### 3. Modeling Techniques: Breadth

Target length: approximately 2.5–3 pages.

Use four labeled subsections:

- Week 8: KNN and distance metrics.
- Week 9: Gradient boosting.
- Week 10: K-means and silhouette score.
- Week 11: DBSCAN and hierarchical clustering.

Each subsection should answer the breadth checklist in one or two focused paragraphs, supported by a table or figure when useful.

### 4. Depth Analysis

Target length: approximately 2.5–3 pages.

Explicitly label the selected depth topics. For the provisional Week 10/11 pairing:

#### Depth Week 10: K-means

- Explain the Euclidean-distance objective.
- Walk through k=2 through k=8.
- Explain why inertia alone is insufficient.
- Interpret silhouette differences between Wisconsin and Brazil.
- Discuss standardization and feature-representation sensitivity.
- Discuss repeated-start stability as a safeguard against unstable local optima.
- Interpret cluster outcome profiles cautiously.

#### Depth Week 11: DBSCAN and hierarchical clustering

- Explain eps and min_samples geometrically.
- Show how parameter changes affect noise and cluster count.
- Explain the selected noise tradeoff.
- Contrast DBSCAN's ability to label noise with hierarchical clustering's forced partition.
- Discuss linkage and k tuning.
- Explain whether the two approaches agree or disagree and why that matters.

### 5. Overfitting, Metrics, and Hyperparameter Tuning

Target length: approximately 0.75–1 page.

This can be a dedicated section or integrated into breadth/depth, but it must be easy to find.

Discuss:

- train/test separation and cross-validation for supervised models;
- scaling pipelines and regularization where relevant;
- Brazil's class imbalance and why accuracy is insufficient;
- KNN neighbor count and distance metric;
- gradient boosting learning rate, depth, iteration count, and early stopping if used;
- k-means k, initialization count, and stability;
- DBSCAN eps and min_samples;
- hierarchical linkage and k.

For each, explain what the parameter controls, why it was tuned, and what the result showed.

### 6. Expected and Unexpected Results

Target length: approximately 0.5 page.

Likely themes:

- Wisconsin is easier because it is clean and comparatively separable.
- Brazil's high accuracy can coexist with weak positive-class recall.
- Scaling and representation may matter more than the nominal algorithm on distance-based methods.
- Density clustering may produce substantial noise or weak separation in Brazil.
- Hierarchical clustering may create visually neat partitions even when silhouette evidence is modest.

Only include claims supported by the actual final outputs.

### 7. EDA Connection

Target length: approximately 0.25–0.5 page.

Keep this modeling-focused:

- feature ranges and correlation informed scaling and distance methods;
- missingness and coded registry variables affected Brazil clustering;
- class imbalance motivated PR-AUC, recall, F1, and threshold analysis;
- EDA was useful for anticipating difficulty, but it did not guarantee meaningful clusters.

### 8. Conclusions

Target length: approximately 0.75 page.

Answer:

- What has the modeling shown so far?
- Which conclusions are quantitatively supported?
- Which dataset/model combinations are most trustworthy?
- What can be responsibly claimed?
- What remains uncertain and should be addressed in the integrated capstone?

The conclusion should synthesize across methods rather than repeat every metric.

## Figure and Table Plan

Do not finalize this selection until the notebooks have been run and reviewed. The final body should contain 3–8 total figures/tables, with readable captions.

Strong candidates:

1. Dataset and outcome summary table.
2. A compact Week 8/9 supervised-model comparison table or figure.
3. Week 10 k-means inertia/silhouette comparison.
4. Week 10 cluster visualization or outcome-profile figure.
5. Week 11 DBSCAN parameter/noise sensitivity figure.
6. Week 11 DBSCAN versus hierarchical silhouette comparison.
7. One final cross-method comparison table if it clarifies the overall argument.

The paper should not include every notebook plot. The summary-figures notebook should regenerate only the final selected visuals with consistent fonts, labels, colors, captions, and dataset names.

### Recommended final body set

Based on the completed results, the strongest rough-draft set is six body items:

1. **Dataset and outcome summary table.** Include rows, predictors, outcome prevalence, missingness, and Brazil sample sizes.
2. **Supervised-model comparison figure.** Use two panels for test ROC-AUC and PR-AUC or F1, comparing the strongest KNN and gradient-boosting results across datasets.
3. **Brazil threshold-tuning figure.** Show precision, recall, and F1 across thresholds for gradient boosting.
4. **K-means tuning figure.** Use inertia/elbow and silhouette curves across k for both datasets.
5. **K-means stability and cluster-profile figure.** Combine repeated-start ARI with known outcome rates by final cluster.
6. **DBSCAN/hierarchical caution figure.** Combine DBSCAN noise/silhouette sensitivity with hierarchical silhouette and cluster-size imbalance.

The central figure story is not simply that Wisconsin is clean and Brazil is messy. It is more specific: supervised metrics require different decision criteria; k-means results depend on stability and representation; and density/hierarchical internal scores can be misleading when noise or cluster imbalance is ignored.

Do not prioritize PCA maps, raw confusion matrices, or every KNN distance plot for the paper body. Keep them in the notebooks unless the drafting process shows that one directly supports a claim better than the recommended set.

## Citations and AI Appendix

Before final submission:

- cite both datasets;
- cite documentation or external educational sources used for KNN, gradient boosting, k-means, silhouette score, DBSCAN, and hierarchical clustering;
- use one consistent citation style;
- include the full repository/notebook link if available;
- include an AI appendix describing what AI helped with, what prompts were used or summarized, and what outputs were independently checked.

## Execution Order

1. ~~Run Week 10 and Week 11 locally; save the key outputs and note any errors or weak results.~~ **Completed.**
2. ~~Review Week 8 and Week 9 for consistency and extract their strongest results.~~ **Completed for the current draft table.**
3. ~~Build the consolidated results table and dataset facts table.~~ **Started and substantially completed.**
4. ~~Decide whether Week 10, Week 11, or both receive depth treatment.~~ **Provisional decision: use Weeks 10 and 11 as the depth pairing, subject to figure review.**
5. **Populate Week 12 summary figures from the verified results.**
6. **Draft the paper sections in rubric order.**
7. **Insert the strongest 3–8 figures/tables and write captions immediately.**
8. **Add citations, AI appendix, notebook appendix/repository link, and limitations.**
9. **Perform a rubric audit and formatting audit.**
10. **Revise for clarity, transitions, and consistency rather than adding unsupported complexity.**

## Final Submission Audit

- [ ] 8–10 pages, double spaced, 12-point Times New Roman, 1-inch margins.
- [ ] Clear project statement and potential impact.
- [ ] All four Week 8–11 topics covered in breadth.
- [ ] One or two depth topics explicitly labeled.
- [ ] Overfitting/stability discussion includes methods, rationale, and results.
- [ ] Metrics and hyperparameter tuning are explained in context.
- [ ] Expected and unexpected results are discussed.
- [ ] EDA is connected to modeling decisions.
- [ ] Quantitative conclusions are supported by notebook results.
- [ ] Only 3–8 readable figures/tables appear in the body.
- [ ] Captions are at least 12-point Times New Roman.
- [ ] Notebook appendix or repository link is included.
- [ ] AI appendix is included.
- [ ] Dataset and technical citations are included.
- [ ] Wisconsin/Brazil sample sizes and metric definitions are consistent throughout.
