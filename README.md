# M3C2-LOG
Shoujun Jia, Lotte de Vugt, Andreas Mayr, Chun Liu, Martin Rutzinger,(2024), Location and orientation united graph comparison for topographic point cloud change estimation, ISPRS Journal of Photogrammetry and Remote Sensing. 

We proposes a graph comparison-based method to estimate 3D topographic change from point clouds. First, a graph with both location and orientation representation is designed to aggregate local neighbors of topographic point clouds against the disordered and unstructured data nature. Second, the corresponding graphs between two topographic point clouds are identified and compared to quantify the differences and associated uncertainties in both location and orientation features. Particularly, the proposed method unites the significant changes derived from both features (i.e., location and orientation) and captures the location difference (i.e., distance) and the orientation difference (i.e., rotation) for each point with significance. 

![location uncertainty comparison](https://github.com/user-attachments/assets/026676fc-2903-4a58-8642-14f83e27a678)

This repository is to release the codes and show more details excluded in our paper for readers. Please do not hesitate to tell us if you have any questions with our works. We further show more comparison results with other published methods(M3C2 [1], CP M3C2 [2], M3C2 EP [3]) on other datasets.
![CP M3C2](https://github.com/user-attachments/assets/74597036-ab35-43f4-9fe9-997d530a2d3a)

![M3C2 EP](https://github.com/user-attachments/assets/6eb8b0f5-822b-46b8-8ed4-4d2cd12985ad)

[1] Lague, D., Brodu, N., Leroux, J., Accurate 3D comparison of complex topography with terrestrial laser scanner: Application to the Rangitikei canyon (N-Z), ISPRS Journal of Photogrammetry and Remote Sensing, 82(2013), pp. 10-26, https://doi.org/10.1016/j.isprsjprs.2013.04.009

[2] Zahs, V., Winiwarter, L., Anders, K., Williams, J. G., Rutzinger, M., Höfle, B., Correspondence-driven plane-based M3C2 for lower uncertainty in 3D topographic change quantification, ISPRS Journal of Photogrammetry and Remote Sensing, 183(2022), pp. 541-559, https://doi.org/10.1016/j.isprsjprs.2021.11.018

[3] Winiwarter, L., Anders, K., Höfle, B., M3C2-EP: Pushing the limits of 3D topographic point cloud change detection by error propagation, ISPRS Journal of Photogrammetry and Remote Sensing, 178(2021), pp. 240-258, https://doi.org/10.1016/j.isprsjprs.2021.06.011
