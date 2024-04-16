% Load in data
load('ICAdata.mat')

% Calculate and plot reconstructed ICA and timeseries for maximum displacement pixel
ICA_Recon = figure(1); clf
Dates = datenum(Dates,'yyyymmdd'); 


% Load in structural data
S1           = shaperead('QGIS/Corbetti_Cones.shp');
S2           = shaperead('QGIS/Corbetti_Structures.shp');

Awassa_Caldera(:,1)         = S2(1).X; Awassa_Caldera(:,2)          = S2(1).Y-0.003;
Corbetti_Caldera(:,1)       = S2(2).X; Corbetti_Caldera(:,2)        = S2(2).Y;
Dambly_Fault(:,1)           = S2(3).X; Dambly_Fault(:,2)            = S2(3).Y;
Lloyd_Fault(:,1)            = S2(5).X; Lloyd_Fault(:,2)             = S2(5).Y;

Corbetti_Cones(1,1)          = S1(1).X; Corbetti_Cones(1,2)           = S1(1).Y;
Corbetti_Cones(2,1)          = S1(2).X; Corbetti_Cones(2,2)           = S1(2).Y;

% Iterate between IC
for k = 1:4
    T           = ICA_TC(:,k);                                             % extract individual ICA time course
    S           = reshape(ICA_sources(k,:,:),1,numel(Mask));               % extract individual ICA soucres
    
    % Calculate reconstructed IC 
    ICA      = permute(reshape(T*S,size(ICA_TC,1),size(ICA_sources,2),size(ICA_sources,3)),[2 3 1]);

    % Reconstructs independent component and adding back in mean to first component 
    if k == 1
            ICA      = permute(reshape((T*S) + Unw_phase' ,size(ICA_TC,1),size(ICA_sources,2),size(ICA_sources,3)),[2 3 1]);
    end
    ICA      = cumsum(ICA,3);
    
    % Identify location on maximum displacement in ICA 
    ICA_v1_last = ICA(:,:,size(ICA_TC,1));
    [y,x]       = find(ICA_v1_last ==max(ICA_v1_last(:)));

    % Plot figure
    subplot(4,2,k*2)
    plot(Dates, permute(ICA(y,x,:),[3 1 2]),'k-','LineWidth',1)
    xlim([Dates(1) Dates(numel(Dates))])
    datetick('x','mm/yy','keeplimits')
       
    subplot(4,2,(k*2)-1)
    imagesc(lons(1,:) , lats(:,1), ICA(:,:,223),'AlphaData',~Mask); axis image; hold on; 
    set(gca,'YDir','normal'); 
    colormap(gca, flipud(cbrewer2('RdYlBu', 256))); colorbar
    
    % Add structures    
    plot(Lloyd_Fault(:,1), Lloyd_Fault(:,2),'k','LineWidth',2,'HandleVisibility','off','DisplayName','Structure (Lloyd et al., 2018)');
    plot(Dambly_Fault(:,1), Dambly_Fault(:,2),'k--','LineWidth',2,'HandleVisibility','off','DisplayName','Structure (Dambly et al., 2023)');
    plot(Awassa_Caldera(:,1), Awassa_Caldera(:,2),'k','Color','#808080','LineWidth',2,'HandleVisibility','off','DisplayName','Awassa Caldera Caldera');
    plot(Corbetti_Caldera(:,1), Corbetti_Caldera(:,2),'k','LineWidth',2,'HandleVisibility','off','DisplayName','Corbetti Caldera');
    plot(Corbetti_Cones(:,1), Corbetti_Cones(:,2),'w^','MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',10,'HandleVisibility','off','DisplayName','Volcanic Cones');


    xlim([lons(1,1) lons(numel(lons))])
    ylim(sort([lats(1,1), lats(numel(lats))]))
end

% Figure layout
set(gcf,'color','w')
fontsize(ICA_Recon, 12, 'pixels');

% if combining noise components (IC3 + IC4), we plotted [200,75] for
% the reconstructed timeseries. 




