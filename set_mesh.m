function Mesh = set_mesh(s1, s2, segment, nodes_count)
% s1 --- dimensionless poisition of of solute-1 shrinking core boundary
% s2 --- dimensionless poisition of of solute-2 shrinking core boundary
%% overall grid
Mesh.mesh = linspace(0, segment, nodes_count); % coordinates of mesh points in z
Mesh.s1_idx = round(nodes_count*s1); % INDEX of boundary 1 position in mesh
Mesh.s2_idx = round(nodes_count*s2); % INDEX of boundary 2 position in mesh
Mesh.s1 = Mesh.mesh(Mesh.s1_idx); % reassign boundary 1 position
Mesh.s2 = Mesh.mesh(Mesh.s2_idx); % reassign boundary 2 position
Mesh.z1_idx = 1:Mesh.s1_idx; % indices within the transport zone 1
Mesh.z2_idx = 1:Mesh.s2_idx; % indices within the transport zone 2
Mesh.nodes_count = nodes_count; % overall mesh nodes count
Mesh.segment = segment; % mesh is on the interva [0; segment]
end