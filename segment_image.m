function segmented_image = segment_image(segmenting_image)
image_double = segmenting_image;
gaussian_mask = fspecial("gaussian",[12,12],2);
id_r = image_double(:,:,1);
id_r = conv2(id_r, gaussian_mask, "same");
id_g = image_double(:,:,2);
id_g = conv2(id_g, gaussian_mask, "same");
id_b = image_double(:,:,3);
id_b = conv2(id_b, gaussian_mask, "same");
% phase 0
gabor_mask0_0 = gabor2(3, 0.1, 0, 0.75, 0);
gabor_mask0_15 = gabor2(3, 0.1, 15, 0.75, 0);
gabor_mask0_30 = gabor2(3, 0.1, 30, 0.75, 0);
gabor_mask0_45 = gabor2(3, 0.1, 45, 0.75, 0);
gabor_mask0_60 = gabor2(3, 0.1, 60, 0.75, 0);
gabor_mask0_75 = gabor2(3, 0.1, 75, 0.75, 0);
gabor_mask0_90 = gabor2(3, 0.1, 90, 0.75, 0);
gabor_mask0_105 = gabor2(3, 0.1, 105, 0.75, 0);
gabor_mask0_120 = gabor2(3, 0.1, 120, 0.75, 0);
gabor_mask0_135 = gabor2(3, 0.1, 135, 0.75, 0);
gabor_mask0_150 = gabor2(3, 0.1, 150, 0.75, 0);
gabor_mask0_165 = gabor2(3, 0.1, 165, 0.75, 0);
% phase 90
gabor_mask90_0 = gabor2(3, 0.1, 0, 0.75, 90);
gabor_mask90_15 = gabor2(3, 0.1, 15, 0.75, 90);
gabor_mask90_30 = gabor2(3, 0.1, 30, 0.75, 90);
gabor_mask90_45 = gabor2(3, 0.1, 45, 0.75, 90);
gabor_mask90_60 = gabor2(3, 0.1, 60, 0.75, 90);
gabor_mask90_75 = gabor2(3, 0.1, 75, 0.75, 90);
gabor_mask90_90 = gabor2(3, 0.1, 90, 0.75, 90);
gabor_mask90_105 = gabor2(3, 0.1, 105, 0.75, 90);
gabor_mask90_120 = gabor2(3, 0.1, 120, 0.75, 90);
gabor_mask90_135 = gabor2(3, 0.1, 135, 0.75, 90);
gabor_mask90_150 = gabor2(3, 0.1, 150, 0.75, 90);
gabor_mask90_165 = gabor2(3, 0.1, 165, 0.75, 90);


complex_gabor_r = zeros(size(id_r));
for i=1:12
    mask = ['gabor_mask90_',num2str(i*15-15)];
    mask2 = ['gabor_mask0_',num2str(i*15-15)];
    I_gabor = conv2(id_r,eval(mask),"same");
    I_gabor2 = conv2(id_r, eval(mask2), "same");
    complex_gabor_r = complex_gabor_r + I_gabor.^2 + I_gabor2.^2;
end
complex_gabor_r = sqrt(complex_gabor_r);


complex_gabor_g = zeros(size(id_g));
for i=1:12
    mask = ['gabor_mask90_',num2str(i*15-15)];
    mask2 = ['gabor_mask0_',num2str(i*15-15)];
    I_gabor = conv2(id_g,eval(mask),"same");
    I_gabor2 = conv2(id_g, eval(mask2), "same");
    complex_gabor_g = complex_gabor_g + I_gabor.^2 + I_gabor2.^2;
end
complex_gabor_g = sqrt(complex_gabor_g);


complex_gabor_b = zeros(size(id_b));
for i=1:12
    mask = ['gabor_mask90_',num2str(i*15-15)];
    mask2 = ['gabor_mask0_',num2str(i*15-15)];
    I_gabor = conv2(id_r,eval(mask),"same");
    I_gabor2 = conv2(id_r, eval(mask2), "same");
    complex_gabor_b = complex_gabor_b + I_gabor.^2 + I_gabor2.^2;
end
complex_gabor_b = sqrt(complex_gabor_b);


complex_gabor_r = imerode(complex_gabor_r, ones(3));
edge_r = edge(complex_gabor_r,"canny", 0.25);

complex_gabor_g = imerode(complex_gabor_g, ones(3));
edge_g = edge(complex_gabor_g,"canny", 0.25);

complex_gabor_b = imerode(complex_gabor_b, ones(3));
edge_b = edge(complex_gabor_b,"canny", 0.25);

edge_complex = edge_r + edge_g + edge_b;
edge_complex(edge_complex==1) = 0;
edge_complex(edge_complex>1) = 1;
edge_complex(:,1:5) = 0;
edge_complex(:,end-5:end) = 0;
edge_complex(1:5,:) = 0;
edge_complex(end-5:end,:) = 0;

segmented_image = edge_complex;


end