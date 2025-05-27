function out = model
%
% step_thrust_bearing_topology_optimization.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('hdb', 'HydrodynamicBearing', 'geom1');
model.physics('hdb').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/hdb', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Ro', '0.1[m]', 'Outer radius of the pad');
model.param.set('Ri', '0.05[m]', 'Inner radius of the pad');
model.param.set('gAng', '15', 'Groove angle (deg)');
model.param.set('hg', '1e-4[m]', 'Groove depth');
model.param.set('hf', '1e-4[m]', 'Film thickness');
model.param.set('speed', '1000[rad/s]', 'Angular speed of the shaft');
model.param.set('mu_f', '0.072[Pa*s]', 'Viscosity of the lubricant');
model.param.set('rho_c', '866[kg/m^3]', 'Density at cavitation pressure');
model.param.set('N', '3.0', 'Number of pads');
model.param.set('initUniform', '1.0', 'Uniform initialization');
model.param.set('volfrac', '0', 'Volume fraction');
model.param.set('meshsz', '2[mm]', 'Mesh size');
model.param.set('beta', '1', 'Projection slope');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'Ro');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('c2', 'c1');
model.geom('geom1').feature('wp1').geom.feature('c2').set('r', 'Ri');
model.geom('geom1').feature('wp1').geom.run('c2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex1').set('dif1', 1);
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex2').set('dif1', 8);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('par1', 'Partition');
model.geom('geom1').feature('wp1').geom.feature('par1').selection('input').set({'dif1'});
model.geom('geom1').feature('wp1').geom.feature('par1').selection('tool').set({'ls1'});
model.geom('geom1').feature('wp1').geom.run('par1');
model.geom('geom1').feature('wp1').set('selresult', true);
model.geom('geom1').run('wp1');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').set('entitydim', 2);
model.geom('geom1').feature('adjsel1').set('input', {'wp1'});
model.geom('geom1').feature('adjsel1').set('outputdim', 1);
model.geom('geom1').feature('adjsel1').set('interior', true);
model.geom('geom1').feature('adjsel1').set('exterior', false);
model.geom('geom1').feature('adjsel1').label('Interior Edges');
model.geom('geom1').run('adjsel1');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Circumferential Edges');
model.geom('geom1').feature('comsel1').set('entitydim', 1);
model.geom('geom1').feature('comsel1').set('input', {'adjsel1'});
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');

model.physics('hdb').prop('EquationType').set('EquationType', 'ReynoldsEquationWithCavitation');

model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu_f'});

model.common.create('dtopo1', 'DensityTopology', 'comp1');
model.common('dtopo1').selection.all;
model.common('dtopo1').selection.geom('geom1', 2);
model.common('dtopo1').selection.all;
model.common('dtopo1').set('projectionType', 'TanhProjection');
model.common('dtopo1').set('beta', 'beta');
model.common('dtopo1').set('interpolationType', 'Linear_interp');
model.common('dtopo1').set('discretization', 'constant');
model.common('dtopo1').set('theta_0', 'if(initUniform,volfrac,0.5+0.5*sin(N*atan2(Yg,Xg)))');

model.physics('hdb').create('htb1', 'HydrodynamicThrustBearing', 2);
model.physics('hdb').feature('htb1').selection.all;
model.physics('hdb').feature('htb1').set('RefNormal', 'InverseOrientation');
model.physics('hdb').feature('htb1').set('BearingType', 'UserDef');
model.physics('hdb').feature('htb1').set('hB1', 'hg+hf*dtopo1.theta_p');
model.physics('hdb').feature('htb1').set('BearingCenterType', 'fromGeom');
model.physics('hdb').feature('htb1').set('Ow', 'speed');
model.physics('hdb').feature('htb1').set('rho_c', 'rho_c');
model.physics('hdb').feature('bax1').set('bearingAxis', 'zAxis');
model.physics('hdb').feature('bax1').set('e_aux', [1 0 0]);

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'meshsz');
model.mesh('mesh1').feature('size').set('hmin', 'meshsz/2');
model.mesh('mesh1').run;

model.study('std1').create('topo', 'TopologyOptimization');
model.study('std1').label('Study: Sweep Initial Condition');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'Ro', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'Ro', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'm', 0);
model.study('std1').feature('param').setIndex('pname', 'Ri', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'Ri', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', 'm', 1);
model.study('std1').feature('param').setIndex('pname', 'N', 0);
model.study('std1').feature('param').setIndex('plistarr', '3 3 4 5', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'initUniform', 1);
model.study('std1').feature('param').setIndex('plistarr', '1 0 0 0', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('topo').set('optobj', {'comp1.hdb.htb1.Fcz'});
model.study('std1').feature('topo').set('descr', {'Fluid load on collar, z-component'});
model.study('std1').feature('topo').set('objectivescaling', 'init');
model.study('std1').feature('topo').set('objectivetype', 'maximization');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scaleval', '1000000');
model.sol('sol1').feature('v1').feature('comp1_dtopo1_theta_f').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('o1', 'Optimization');
model.sol('sol1').feature('o1').set('control', 'topo');
model.sol('sol1').feature('o1').create('s1', 'StationaryAttrib');
model.sol('sol1').feature('o1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('o1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_dtopo1_theta_c' 'comp1_dtopo1_theta_f'});
model.sol('sol1').feature('o1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('o1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('o1').feature('s1').feature('i1').label('Suggested Iterative Solver (GMRES with AMG) (opt)');
model.sol('sol1').feature('o1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('o1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss1').label('Optimization');
model.sol('sol1').feature('o1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_pfilm' 'comp1_dtopo1_theta_c'});
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('o1').feature('s1').feature('se1').feature('ss2').label('Hydrodynamic Bearing');
model.sol('sol1').feature('o1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'N' 'initUniform'});
model.batch('p1').set('plistarr', {'3 3 4 5' '1 0 0 0'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').getInitialValue;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Fluid Pressure (hdb)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').set('defaultPlotID', 'fluidPressure');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('smooth', 'internal');
model.result('pg1').feature('con1').set('inherittubescale', false);
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').label('Topology Optimization');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg1');
model.nodeGroup.move('grp1', 1);

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Output material volume factor');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Threshold');

model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');

model.result.dataset.create('filt1', 'Filter');
model.result.dataset('filt1').label('Filter');
model.result.dataset('filt1').set('data', 'dset2');
model.result.dataset('filt1').set('expr', 'dtopo1.theta');
model.result.dataset('filt1').set('lowerexpr', '0.5');
model.result.dataset('filt1').set('smooth', 'none');
model.result.dataset('filt1').set('useder', false);
model.result.dataset('filt1').set('level', 'surface');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg2').feature('surf1').set('rangecoloractive', true);
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('rangecolormin', 0);
model.result('pg2').feature('surf1').set('rangecolormax', 1);
model.result.dataset('dset2').selection.geom('geom1', 2);
model.result.dataset('dset2').selection.set([1 2]);
model.result('pg3').set('data', 'filt1');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('color', 'gray');
model.result('pg3').feature('surf1').set('titletype', 'none');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('data', 'dset1');

model.study('std1').feature('topo').set('plot', true);
model.study('std1').feature('topo').set('plotgroup', 'pg2');

model.sol('sol1').feature('o1').feature('s1').feature('se1').feature.move('ss2', 0);

model.batch('p1').run('compute');

model.result('pg1').run;

model.study('std1').feature('topo').set('probewindow', '');

model.result('pg1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('colortabletrans', 'reverse');
model.result('pg2').run;
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 3, 0);
model.result('pg2').run;
model.result('pg2').set('data', 'dset1');
model.result('pg3').run;
model.result('pg4').run;
model.result('pg4').label('Bearing Capacity vs Number of Pads');
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevelinput', 'manual', 0);
model.result('pg4').setIndex('looplevel', [2 3 4], 0);
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'hdb.htb1.Fcz'});
model.result('pg4').feature('glob1').set('descr', {'Fluid load on collar, z-component'});
model.result('pg4').feature('glob1').set('unit', {'N'});
model.result('pg4').feature('glob1').setIndex('expr', 'hdb.htb1.Fcz', 0);
model.result('pg4').feature('glob1').setIndex('unit', 'kN', 0);
model.result('pg4').feature('glob1').setIndex('descr', 'Fluid load on collar, z-component', 0);
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'N');
model.result('pg4').feature('glob1').set('linewidth', 3);
model.result('pg4').run;
model.result('pg4').set('showlegends', false);
model.result.dataset('filt1').feature.create('mip1', 'MeshImportParameters');
model.result.dataset('filt1').feature('mip1').setIndex('looplevel', 3, 0);
model.result.dataset('filt1').createMeshPart('mcomp1', 'mgeom1', 'mpart1', 'imp1');

model.mesh('mpart1').feature('imp1').set('facepartition', 'minimal');
model.mesh('mpart1').feature('imp1').importData;

model.modelNode.create('comp2', true);

model.geom.create('geom2', 3);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('imp1', 'Import');
model.geom('geom2').feature('imp1').set('type', 'sequence');
model.geom('geom2').feature('imp1').set('sequence', 'geom1');
model.geom('geom2').feature.duplicate('imp2', 'imp1');
model.geom('geom2').feature('imp2').label('Grooves');
model.geom('geom2').feature('imp2').set('type', 'mesh');
model.geom('geom2').feature('imp2').set('mesh', 'mpart1');
model.geom('geom2').feature('imp2').set('simplifymesh', false);
model.geom('geom2').feature('imp2').set('formsolid', false);
model.geom('geom2').feature('imp2').set('selresult', true);
model.geom('geom2').feature('imp2').set('selresultshow', 'bnd');
model.geom('geom2').feature('fin').set('repairtoltype', 'relative');
model.geom('geom2').feature('fin').set('repairtol', 1.0E-4);
model.geom('geom2').run('fin');
model.geom('geom2').create('comsel1', 'ComplementSelection');
model.geom('geom2').feature('comsel1').label('Pads');
model.geom('geom2').feature('comsel1').set('entitydim', 2);
model.geom('geom2').feature('comsel1').set('input', {'imp2'});

model.variable.create('var1');
model.variable('var1').model('comp2');

model.geom('geom2').run;

model.variable('var1').label('Groove Variables');
model.variable('var1').selection.geom('geom2', 2);
model.variable('var1').selection.named('geom2_imp2_bnd');
model.variable('var1').set('hfilm', 'hg+hf');
model.variable('var1').descr('hfilm', 'Film thickness');
model.variable.duplicate('var2', 'var1');
model.variable('var2').label('Pad Variables');
model.variable('var2').selection.named('geom2_comsel1');
model.variable('var2').set('hfilm', 'hg+hf', 'Film thickness');
model.variable('var2').set('hfilm', 'hf');
model.variable('var2').descr('hfilm', 'Film thickness');

model.material.copy('mat2', 'mat1', 'comp2');

model.physics.copy('hdb2', 'hdb', 'comp2');
model.physics('hdb2').feature('htb1').set('hB1', 'hfilm');
model.physics('hdb2').feature('init1').set('pfilm', '100000[Pa]*hdb2.max(hdb2.hB1)/(0.1*hdb2.max(hdb2.hB1)+hdb2.hB1)');

model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').feature('ftri1').selection.remaining;
model.mesh('mesh2').feature('size').set('hmax', 'meshsz');
model.mesh('mesh2').feature('size').set('hmin', 'meshsz/2');
model.mesh('mesh2').feature('size').set('hcurve', 10);
model.mesh('mesh2').run;

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/hdb', true);
model.study('std2').feature('stat').setSolveFor('/physics/hdb2', true);
model.study('std2').feature('stat').setEntry('activate', 'hdb', false);
model.study('std2').feature('stat').setEntry('activate', 'hdb2', true);
model.study('std2').feature('stat').setEntry('activate', 'comp1:topopt', false);
model.study('std1').feature('stat').setEntry('activate', 'hdb', true);
model.study('std1').feature('stat').setEntry('activate', 'hdb2', false);
model.study('std1').feature('stat').setEntry('activate', 'comp1:topopt', true);
model.study('std2').label('Verification');

model.sol.create('sol7');
model.sol('sol7').study('std2');
model.sol('sol7').create('st1', 'StudyStep');
model.sol('sol7').feature('st1').set('study', 'std2');
model.sol('sol7').feature('st1').set('studystep', 'stat');
model.sol('sol7').create('v1', 'Variables');
model.sol('sol7').feature('v1').feature('comp2_pfilm').set('scalemethod', 'manual');
model.sol('sol7').feature('v1').feature('comp2_pfilm').set('resscalemethod', 'parent');
model.sol('sol7').feature('v1').feature('comp2_pfilm').set('scaleval', '1000000');
model.sol('sol7').feature('v1').set('control', 'stat');
model.sol('sol7').create('s1', 'Stationary');
model.sol('sol7').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol7').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol7').feature('s1').feature.remove('fcDef');
model.sol('sol7').attach('std2');
model.sol('sol7').runAll;

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').label('Fluid Pressure (hdb2)');
model.result('pg5').set('data', 'dset4');
model.result('pg5').set('defaultPlotID', 'fluidPressure');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg5').feature.create('con1', 'Contour');
model.result('pg5').feature('con1').set('levelrounding', false);
model.result('pg5').feature('con1').set('colorlegend', false);
model.result('pg5').feature('con1').set('smooth', 'internal');
model.result('pg5').feature('con1').set('inherittubescale', false);
model.result('pg5').feature('con1').set('data', 'parent');
model.result('pg5').feature('con1').set('inheritplot', 'surf1');

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').label('Topology Optimization 1');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg5');
model.nodeGroup.move('grp2', 2);

model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').label('Output material volume factor 1');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').label('Threshold 1');

model.nodeGroup('grp2').add('plotgroup', 'pg6');
model.nodeGroup('grp2').add('plotgroup', 'pg7');

model.result.dataset.create('filt2', 'Filter');
model.result.dataset('filt2').label('Filter 1');
model.result.dataset('filt2').set('data', 'dset3');
model.result.dataset('filt2').set('expr', 'dtopo1.theta');
model.result.dataset('filt2').set('lowerexpr', '0.5');
model.result.dataset('filt2').set('smooth', 'none');
model.result.dataset('filt2').set('useder', false);
model.result.dataset('filt2').set('level', 'surface');
model.result('pg6').set('data', 'dset3');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'dtopo1.theta');
model.result('pg6').feature('surf1').set('rangecoloractive', true);
model.result('pg6').feature('surf1').set('colortabletrans', 'none');
model.result('pg6').feature('surf1').set('rangecolormin', 0);
model.result('pg6').feature('surf1').set('rangecolormax', 1);
model.result.dataset('dset3').selection.geom('geom1', 2);
model.result.dataset('dset3').selection.set([1 2]);
model.result('pg7').set('data', 'filt2');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', '1');
model.result('pg7').feature('surf1').set('coloring', 'uniform');
model.result('pg7').feature('surf1').set('color', 'gray');
model.result('pg7').feature('surf1').set('titletype', 'none');
model.result('pg5').run;

model.nodeGroup.remove('grp2');

model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Objective Comparison');
model.result.evaluationGroup('eg1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('eg1').feature('gev1').set('expr', {'hdb.htb1.Fcz'});
model.result.evaluationGroup('eg1').feature('gev1').set('descr', {'Fluid load on collar, z-component'});
model.result.evaluationGroup('eg1').feature.duplicate('gev2', 'gev1');
model.result.evaluationGroup('eg1').feature('gev2').set('data', 'dset4');
model.result.evaluationGroup('eg1').feature('gev2').set('expr', {'hdb2.htb1.Fcz'});
model.result.evaluationGroup('eg1').feature('gev2').set('descr', {'Fluid load on collar, z-component'});
model.result.evaluationGroup('eg1').feature('gev2').set('unit', {'N'});
model.result.evaluationGroup('eg1').run;
model.result('pg2').run;

model.title('Topology Optimization of a Step Thrust Bearing');

model.description(['In this tutorial model, a step thrust bearing is topology optimized to maximize the bearing capacity. A step thrust bearing consists of a stepped bearing surface on which the end of the shaft rotates. The entire assembly is submerged in a lubricant. The shaft collar is assumed to be spinning without any axial motion in the bearing.' newline  newline 'The model shows that initializing the optimization with a nonuniform design, can result in local minima with a specific number of steps.']);

model.mesh('mesh1').clearMesh;
model.mesh('mpart1').clearMesh;
model.mesh('mesh2').clearMesh;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;

model.label('step_thrust_bearing_topology_optimization.mph');

model.modelNode.label('Components');

out = model;
