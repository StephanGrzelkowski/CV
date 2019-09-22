% In this script we compute a few different gabor filters to visualize the
% effects of changing the parameters theta, sigma and gamma

%create defaults and list of terators
default_theta = 0;
vec_theta = [-45, 0, 45];

default_sigma = 10;
vec_sigma = [1, 10, 100];

default_gamma = 1;
vec_gamma = [0.1, 1, 10];

%other parameter values
psi = 0;
lambda = 10;
%settings for figure annotations
x_offset = -0.1;
y_offset = 0.14;
fnt_size = 15;

figure;
for it = 1 : length(vec_theta)
    %create gabor for each set of parameters
    f_theta= createGabor(default_sigma, vec_theta(it), lambda, psi, default_gamma);
    f_sigma= createGabor(vec_sigma(it), default_theta, lambda, psi, default_gamma);
    f_gamma= createGabor(default_sigma, default_theta, lambda, psi, vec_gamma(it));
    
    %show the filter
    axa = subplot(3,3,it);
    imagesc(f_theta(:,:,1))
    title(sprintf('\\theta: %.0f; \\sigma: %.2f; \\gamma: %.1f ', vec_theta(it), default_sigma, default_gamma))
    
    axb = subplot(3,3,it + 3);
    imagesc(f_sigma(:,:,1))
    title(sprintf('\\theta: %.0f; \\sigma: %.2f; \\gamma: %.1f ', default_theta, vec_sigma(it), default_gamma))
    
    axc = subplot(3,3,it + 6);
    imagesc(f_gamma(:,:,1))
    title(sprintf('\\theta: %.0f; \\sigma: %.2f; \\gamma: %.1f ', default_theta, default_sigma, vec_gamma(it)))
    
    %create some annotations for the report
    if it == 1
        annotation('textbox', 'Position', [axa.Position(1) + x_offset, axa.Position(2) + y_offset, 0.1, 0.1], ...
            'String', 'A', 'Fontsize', fnt_size, 'LineStyle', 'none')
        
        annotation('textbox', 'Position', [axb.Position(1) + x_offset, axb.Position(2) + y_offset, 0.1, 0.1], ...
            'String', 'B', 'Fontsize', fnt_size, 'LineStyle', 'none')
        
        annotation('textbox', 'Position', [axc.Position(1) + x_offset, axc.Position(2) + y_offset, 0.1, 0.1], ...
            'String', 'C', 'Fontsize', fnt_size, 'LineStyle', 'none' )
    end
end