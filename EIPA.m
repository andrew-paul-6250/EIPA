nx = 50;
ny = 50;

G = sparse(nx*ny,nx*ny);
V = zeros(1,nx*ny);

for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
         nxm = j + (i-2)*ny;
         nxp = j + (i)*ny;
         nym = j-1 + (i-1)*ny;
         nyp = j+1 + (i-1)*ny;
        if i == 1
            G(n,:) = 0;
            G(n,n) = 1;
            V(n) = 1;
        elseif i == nx
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j == 1
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j == ny
            G(n,:) = 0;
            G(n,n) = 1;
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(nym,n) = 1;
            G(nyp,n) = 1;         
        end
        
        if (i > 10 && i < 20 && j > 10 && j < 20)
            G(n,n) = -2;
        end
        
    end
end

[E,D] = eigs(G,9,'SM');

for k = 1:9
    for i = 1:nx
        for j = 1:ny
            n = j + (i-1)*ny;
            map(k,i,j) = E(n,k);        
        end
    end
end

figure(1)
spy(G)

figure(2)
for k = 1:9
    subplot(3,3,k)
    t = squeeze(map(k,:,:));
    surf(t)
end
