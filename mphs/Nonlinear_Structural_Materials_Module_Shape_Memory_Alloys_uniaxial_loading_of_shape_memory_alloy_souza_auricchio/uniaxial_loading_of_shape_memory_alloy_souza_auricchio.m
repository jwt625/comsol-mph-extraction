function out = model
%
% uniaxial_loading_of_shape_memory_alloy_souza_auricchio.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Shape_Memory_Alloys');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/solid', true);

model.param.set('T', '298[K]');
model.param.descr('T', 'Applied temperature');
model.param.set('para', '0');
model.param.descr('para', 'Continuation parameter');

model.geom('geom1').lengthUnit('cm');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [6 20]);
model.geom('geom1').run;

model.physics('solid').create('sma1', 'ShapeMemoryAlloy', 2);
model.physics('solid').feature('sma1').selection.all;
model.physics('solid').feature('sma1').set('minput_temperature_src', 'userdef');
model.physics('solid').feature('sma1').set('minput_temperature', 'T');
model.physics('solid').feature('sma1').set('ShapeMemoryAlloyModel', 'SouzaAuricchio');
model.physics('solid').feature('sma1').set('TransformationParametersAuricchio', 'temperature');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2]);
model.physics('solid').create('bndl1', 'BoundaryLoad', 1);

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').label('Load');
model.func('int1').set('funcname', 'load');
model.func('int1').setIndex('table', 0, 0, 0);
model.func('int1').setIndex('table', 0, 0, 1);
model.func('int1').setIndex('table', 1, 1, 0);
model.func('int1').setIndex('table', 1, 1, 1);
model.func('int1').setIndex('table', 2, 2, 0);
model.func('int1').setIndex('table', 0, 2, 1);

model.physics('solid').feature('bndl1').selection.set([3]);
model.physics('solid').feature('bndl1').set('FperArea', {'0' '0' '850[MPa]*load(para)'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('NiTi Alloy');
model.material('mat1').propertyGroup('def').set('poissonsratio', {'0.33'});
model.material('mat1').propertyGroup.create('ShapeMemoryAlloyAustenite', 'Austenite_phase');
model.material('mat1').propertyGroup('ShapeMemoryAlloyAustenite').set('E_A', {'55[GPa]'});
model.material('mat1').propertyGroup.create('ShapeMemoryAlloyMartensite', 'Martensite_phase');
model.material('mat1').propertyGroup('ShapeMemoryAlloyMartensite').set('E_M', {'46[GPa]'});
model.material('mat1').propertyGroup.create('SouzaAuricchioModel', 'Souza-Auricchio_model');
model.material('mat1').propertyGroup('SouzaAuricchioModel').set('beta', {'7.4[MPa/K]'});
model.material('mat1').propertyGroup('SouzaAuricchioModel').set('etrmaxAuricchio', {'0.056'});
model.material('mat1').propertyGroup('SouzaAuricchioModel').set('TMs_SA', {'245[K]'});
model.material('mat1').propertyGroup('SouzaAuricchioModel').set('TMf_SA', {'230[K]'});
model.material('mat1').propertyGroup('SouzaAuricchioModel').set('TAf_SA', {'280[K]'});
model.material('mat1').propertyGroup('def').set('density', {'6500'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('hauto', 7);
model.mesh('mesh1').run;

model.study('std1').label('Study: Pseudoelasticity, Single Loading Cycle');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('pname', 'T', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('param').setIndex('plistarr', '328 308 276 260', 0);
model.study('std1').feature('param').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'T', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'K', 0);
model.study('std1').feature('stat').setIndex('pname', 'para', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.01,2)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'T'});
model.batch('p1').set('plistarr', {'328 308 276 260'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol('sol1').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol1').feature('s1').feature('p1').set('pminstep', '0.0001');

model.study('std1').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').run;
model.result('pg1').label('Stress vs. Strain');
model.result('pg1').set('data', 'dset2');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg1').feature('ptgr1').set('linewidth', 'preference');
model.result('pg1').feature('ptgr1').selection.set([1]);
model.result('pg1').feature('ptgr1').set('expr', 'solid.sGpzz');
model.result('pg1').feature('ptgr1').set('descr', 'Stress tensor, zz-component');
model.result('pg1').feature('ptgr1').set('unit', 'MPa');
model.result('pg1').feature('ptgr1').set('xdataexpr', 'solid.eZZ');
model.result('pg1').feature('ptgr1').set('xdatadescr', 'Strain tensor, ZZ-component');
model.result('pg1').feature('ptgr1').set('autopoint', false);
model.result('pg1').feature('ptgr1').set('legend', true);
model.result('pg1').run;
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('xlabel', 'Axial strain');
model.result('pg1').set('ylabel', 'Axial stress (MPa)');
model.result('pg1').set('legendpos', 'upperleft');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Martensite Volume Fraction');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').selection.set([1]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.xiGp_M');
model.result('pg2').feature('ptgr1').set('descr', 'Martensite volume fraction');
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('autopoint', false);
model.result('pg2').run;
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('defaultPlotID', 'smaPhaseDiagramsma1');
model.result('pg3').label('Shape Memory Alloy Phase Diagram (solid)');
model.result('pg3').label('Shape Memory Alloy Phase Diagram (Shape Memory Alloy 1)');
model.result('pg3').create('lnsg1', 'LineSegments');
model.result('pg3').feature('lnsg1').set('xexpr', {'atent0(dset2_solid_sma1_pt,solid.TStar-solid.sig0_SA/solid.beta)' 'dset2_solid_sma1_Tmax'});
model.result('pg3').feature('lnsg1').set('yexpr', {'0[Pa]' 'atent0(dset2_solid_sma1_pt,solid.beta*(dset2_solid_sma1_Tmax-solid.TStar)+solid.sig0_SA)'});
model.result('pg3').feature('lnsg1').set('linestyle', 'dashed');
model.result('pg3').feature('lnsg1').set('linecolor', 'blue');
model.result('pg3').create('lnsg2', 'LineSegments');
model.result('pg3').feature('lnsg2').set('xexpr', {'atent0(dset2_solid_sma1_pt,solid.TStar+solid.sig0_SA/solid.beta-solid.Hk*solid.etrmax/solid.beta)' 'dset2_solid_sma1_Tmax'});
model.result('pg3').feature('lnsg2').set('yexpr', {'0[Pa]' 'atent0(dset2_solid_sma1_pt,solid.beta*(dset2_solid_sma1_Tmax-solid.TStar)-solid.sig0_SA+solid.Hk*solid.etrmax)'});
model.result('pg3').feature('lnsg2').set('linestyle', 'dashed');
model.result('pg3').feature('lnsg2').set('linecolor', 'red');
model.result('pg3').create('lnsg3', 'LineSegments');
model.result('pg3').feature('lnsg3').set('xexpr', {'atent0(dset2_solid_sma1_pt,solid.TStar-solid.sig0_SA/solid.beta-solid.Hk*solid.etrmax/solid.beta)' 'dset2_solid_sma1_Tmax'});
model.result('pg3').feature('lnsg3').set('yexpr', {'0[Pa]' 'atent0(dset2_solid_sma1_pt,solid.beta*(dset2_solid_sma1_Tmax-solid.TStar)+solid.sig0_SA+solid.Hk*solid.etrmax)'});
model.result('pg3').feature('lnsg3').set('linestyle', 'solid');
model.result('pg3').feature('lnsg3').set('linecolor', 'blue');
model.result('pg3').create('lnsg4', 'LineSegments');
model.result('pg3').feature('lnsg4').set('xexpr', {'atent0(dset2_solid_sma1_pt,solid.TStar+solid.sig0_SA/solid.beta)' 'dset2_solid_sma1_Tmax'});
model.result('pg3').feature('lnsg4').set('yexpr', {'0[Pa]' 'atent0(dset2_solid_sma1_pt,solid.beta*(dset2_solid_sma1_Tmax-solid.TStar)-solid.sig0_SA)'});
model.result('pg3').feature('lnsg4').set('linestyle', 'solid');
model.result('pg3').feature('lnsg4').set('linecolor', 'red');
model.result('pg3').create('ptgr1', 'PointGraph');
model.result('pg3').feature('ptgr1').set('titletype', 'manual');
model.result('pg3').feature('ptgr1').set('title', 'Stress vs. temperature');
model.result('pg3').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('ptgr1').selection.set([1]);
model.result('pg3').feature('ptgr1').set('expr', 'solid.misesGp');
model.result('pg3').feature('ptgr1').set('xdata', 'expr');
model.result('pg3').feature('ptgr1').set('xdataexpr', {'solid.T'});
model.result('pg3').feature('ptgr1').set('linewidth', 2);
model.result('pg3').feature('ptgr1').create('col1', 'Color');
model.result('pg3').feature('ptgr1').feature('col1').set('expr', {'solid.xiGp_M'});
model.result('pg3').feature('ptgr1').feature('col1').set('colortable', 'Cividis');
model.result('pg3').feature('ptgr1').feature('col1').set('colorscalemode', 'linear');
model.result('pg3').feature('ptgr1').feature('col1').set('colortabletrans', 'reverse');
model.result('pg3').feature('ptgr1').feature('col1').set('rangecoloractive', true);
model.result('pg3').feature('ptgr1').feature('col1').set('rangecolormin', 0);
model.result('pg3').feature('ptgr1').feature('col1').set('rangecolormax', 1);
model.result('pg3').feature('ptgr1').feature('col1').set('titletype', 'auto');
model.result('pg3').label('Shape Memory Alloy Phase Diagram (Shape Memory Alloy 1)');
model.result('pg3').run;
model.result('pg3').setIndex('looplevelinput', 'manual', 0);
model.result('pg3').setIndex('looplevel', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101], 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', [101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201], 0);
model.result('pg3').run;
model.result('pg3').setIndex('looplevelinput', 'all', 0);

model.func.create('int2', 'Interpolation');
model.func('int2').model('comp1');
model.func('int2').label('Displacement');
model.func('int2').set('funcname', 'disp');
model.func('int2').setIndex('table', 0, 0, 0);
model.func('int2').setIndex('table', 0, 0, 1);
model.func('int2').setIndex('table', 1, 1, 0);
model.func('int2').setIndex('table', 1, 1, 1);
model.func('int2').setIndex('table', 2, 2, 0);
model.func('int2').setIndex('table', 0.4, 2, 1);
model.func('int2').setIndex('table', 3, 3, 0);
model.func('int2').setIndex('table', 0.8, 3, 1);
model.func('int2').setIndex('table', 4, 4, 0);
model.func('int2').setIndex('table', 0, 4, 1);

model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([3]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('solid').feature('disp1').setIndex('U0', '20[cm]*0.07*disp(para)', 2);

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/solid', true);
model.study('std2').label('Study: Pseudoelasticity, Multiple Loading Cycles');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'T', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'T', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 'K', 0);
model.study('std2').feature('stat').setIndex('pname', 'para', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.02,4)', 0);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'solid/bndl1'});
model.study('std2').setGenPlots(false);

model.sol.create('sol7');
model.sol('sol7').study('std2');
model.sol('sol7').create('st1', 'StudyStep');
model.sol('sol7').feature('st1').set('study', 'std2');
model.sol('sol7').feature('st1').set('studystep', 'stat');
model.sol('sol7').create('v1', 'Variables');
model.sol('sol7').feature('v1').set('control', 'stat');
model.sol('sol7').create('s1', 'Stationary');
model.sol('sol7').feature('s1').create('p1', 'Parametric');
model.sol('sol7').feature('s1').feature.remove('pDef');
model.sol('sol7').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol7').feature('s1').set('control', 'stat');
model.sol('sol7').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol7').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol7').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol7').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol7').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol7').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol7').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol7').feature('s1').feature.remove('fcDef');
model.sol('sol7').attach('std2');
model.sol('sol7').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol7').feature('s1').feature('p1').set('pminstep', '0.0001');
model.sol('sol7').runAll;

model.result('pg1').run;
model.result.duplicate('pg4', 'pg1');
model.result.duplicate('pg5', 'pg2');
model.result('pg4').run;
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('showlegends', false);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').set('data', 'dset3');
model.result('pg5').set('showlegends', false);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset3');
model.result('pg6').set('defaultPlotID', 'smaPhaseDiagramsma1');
model.result('pg6').label('Shape Memory Alloy Phase Diagram (solid)');
model.result('pg6').label('Shape Memory Alloy Phase Diagram (Shape Memory Alloy 1) 1');
model.result('pg6').create('lnsg1', 'LineSegments');
model.result('pg6').feature('lnsg1').set('xexpr', {'atent0(dset3_solid_sma1_pt,solid.TStar-solid.sig0_SA/solid.beta)' 'dset3_solid_sma1_Tmax'});
model.result('pg6').feature('lnsg1').set('yexpr', {'0[Pa]' 'atent0(dset3_solid_sma1_pt,solid.beta*(dset3_solid_sma1_Tmax-solid.TStar)+solid.sig0_SA)'});
model.result('pg6').feature('lnsg1').set('linestyle', 'dashed');
model.result('pg6').feature('lnsg1').set('linecolor', 'blue');
model.result('pg6').create('lnsg2', 'LineSegments');
model.result('pg6').feature('lnsg2').set('xexpr', {'atent0(dset3_solid_sma1_pt,solid.TStar+solid.sig0_SA/solid.beta-solid.Hk*solid.etrmax/solid.beta)' 'dset3_solid_sma1_Tmax'});
model.result('pg6').feature('lnsg2').set('yexpr', {'0[Pa]' 'atent0(dset3_solid_sma1_pt,solid.beta*(dset3_solid_sma1_Tmax-solid.TStar)-solid.sig0_SA+solid.Hk*solid.etrmax)'});
model.result('pg6').feature('lnsg2').set('linestyle', 'dashed');
model.result('pg6').feature('lnsg2').set('linecolor', 'red');
model.result('pg6').create('lnsg3', 'LineSegments');
model.result('pg6').feature('lnsg3').set('xexpr', {'atent0(dset3_solid_sma1_pt,solid.TStar-solid.sig0_SA/solid.beta-solid.Hk*solid.etrmax/solid.beta)' 'dset3_solid_sma1_Tmax'});
model.result('pg6').feature('lnsg3').set('yexpr', {'0[Pa]' 'atent0(dset3_solid_sma1_pt,solid.beta*(dset3_solid_sma1_Tmax-solid.TStar)+solid.sig0_SA+solid.Hk*solid.etrmax)'});
model.result('pg6').feature('lnsg3').set('linestyle', 'solid');
model.result('pg6').feature('lnsg3').set('linecolor', 'blue');
model.result('pg6').create('lnsg4', 'LineSegments');
model.result('pg6').feature('lnsg4').set('xexpr', {'atent0(dset3_solid_sma1_pt,solid.TStar+solid.sig0_SA/solid.beta)' 'dset3_solid_sma1_Tmax'});
model.result('pg6').feature('lnsg4').set('yexpr', {'0[Pa]' 'atent0(dset3_solid_sma1_pt,solid.beta*(dset3_solid_sma1_Tmax-solid.TStar)-solid.sig0_SA)'});
model.result('pg6').feature('lnsg4').set('linestyle', 'solid');
model.result('pg6').feature('lnsg4').set('linecolor', 'red');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').set('titletype', 'manual');
model.result('pg6').feature('ptgr1').set('title', 'Stress vs. temperature');
model.result('pg6').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg6').feature('ptgr1').selection.set([1]);
model.result('pg6').feature('ptgr1').set('expr', 'solid.misesGp');
model.result('pg6').feature('ptgr1').set('xdata', 'expr');
model.result('pg6').feature('ptgr1').set('xdataexpr', {'solid.T'});
model.result('pg6').feature('ptgr1').set('linewidth', 2);
model.result('pg6').feature('ptgr1').create('col1', 'Color');
model.result('pg6').feature('ptgr1').feature('col1').set('expr', {'solid.xiGp_M'});
model.result('pg6').feature('ptgr1').feature('col1').set('colortable', 'Cividis');
model.result('pg6').feature('ptgr1').feature('col1').set('colorscalemode', 'linear');
model.result('pg6').feature('ptgr1').feature('col1').set('colortabletrans', 'reverse');
model.result('pg6').feature('ptgr1').feature('col1').set('rangecoloractive', true);
model.result('pg6').feature('ptgr1').feature('col1').set('rangecolormin', 0);
model.result('pg6').feature('ptgr1').feature('col1').set('rangecolormax', 1);
model.result('pg6').feature('ptgr1').feature('col1').set('titletype', 'auto');
model.result('pg6').label('Shape Memory Alloy Phase Diagram (Shape Memory Alloy 1) 1');
model.result('pg6').run;
model.result('pg6').setIndex('looplevelinput', 'manual', 0);
model.result('pg6').setIndex('looplevel', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51], 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', [51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101], 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', [101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151], 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', [151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201], 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevelinput', 'all', 0);

model.func.create('int3', 'Interpolation');
model.func('int3').model('comp1');
model.func('int3').label('Temperature');
model.func('int3').set('funcname', 'temperature');
model.func('int3').setIndex('table', 2, 0, 0);
model.func('int3').setIndex('table', 260, 0, 1);
model.func('int3').setIndex('table', 3, 1, 0);
model.func('int3').setIndex('table', 300, 1, 1);
model.func('int3').setIndex('fununit', 'K', 0);
model.func('int3').setIndex('argunit', 1, 0);

model.physics('solid').feature.duplicate('sma2', 'sma1');
model.physics('solid').feature('sma2').set('minput_temperature', 'temperature(para)');
model.physics('solid').create('bndl2', 'BoundaryLoad', 1);
model.physics('solid').feature('bndl2').selection.set([3]);
model.physics('solid').feature('bndl2').set('FperArea', {'0' '0' '300[MPa]*load(para)'});

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/solid', true);
model.study('std3').label('Study: Shape Memory Effect');
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'T', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'K', 0);
model.study('std3').feature('stat').setIndex('pname', 'T', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', 'K', 0);
model.study('std3').feature('stat').setIndex('pname', 'para', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'range(0,0.02,2) range(2.05,0.05,3)', 0);
model.study('std3').feature('stat').set('useadvanceddisable', true);
model.study('std3').feature('stat').set('disabledphysics', {'solid/bndl1' 'solid/disp1'});
model.study('std3').setGenPlots(false);

model.sol.create('sol8');
model.sol('sol8').study('std3');
model.sol('sol8').create('st1', 'StudyStep');
model.sol('sol8').feature('st1').set('study', 'std3');
model.sol('sol8').feature('st1').set('studystep', 'stat');
model.sol('sol8').create('v1', 'Variables');
model.sol('sol8').feature('v1').set('control', 'stat');
model.sol('sol8').create('s1', 'Stationary');
model.sol('sol8').feature('s1').create('p1', 'Parametric');
model.sol('sol8').feature('s1').feature.remove('pDef');
model.sol('sol8').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol8').feature('s1').set('control', 'stat');
model.sol('sol8').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol8').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol8').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol8').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol8').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol8').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol8').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol8').feature('s1').feature.remove('fcDef');
model.sol('sol8').attach('std3');
model.sol('sol8').feature('s1').feature('p1').set('paramtuning', true);
model.sol('sol8').feature('s1').feature('p1').set('pminstep', '0.0001');
model.sol('sol8').runAll;

model.result('pg4').run;
model.result.duplicate('pg7', 'pg4');
model.result('pg7').run;
model.result('pg7').set('data', 'dset4');
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset4');
model.result('pg8').set('defaultPlotID', 'smaPhaseDiagramsma2');
model.result('pg8').label('Shape Memory Alloy Phase Diagram (solid)');
model.result('pg8').label('Shape Memory Alloy Phase Diagram (Shape Memory Alloy 2)');
model.result('pg8').create('lnsg1', 'LineSegments');
model.result('pg8').feature('lnsg1').set('xexpr', {'atent0(dset4_solid_sma2_pt,solid.TStar-solid.sig0_SA/solid.beta)' 'dset4_solid_sma2_Tmax'});
model.result('pg8').feature('lnsg1').set('yexpr', {'0[Pa]' 'atent0(dset4_solid_sma2_pt,solid.beta*(dset4_solid_sma2_Tmax-solid.TStar)+solid.sig0_SA)'});
model.result('pg8').feature('lnsg1').set('linestyle', 'dashed');
model.result('pg8').feature('lnsg1').set('linecolor', 'blue');
model.result('pg8').create('lnsg2', 'LineSegments');
model.result('pg8').feature('lnsg2').set('xexpr', {'atent0(dset4_solid_sma2_pt,solid.TStar+solid.sig0_SA/solid.beta-solid.Hk*solid.etrmax/solid.beta)' 'dset4_solid_sma2_Tmax'});
model.result('pg8').feature('lnsg2').set('yexpr', {'0[Pa]' 'atent0(dset4_solid_sma2_pt,solid.beta*(dset4_solid_sma2_Tmax-solid.TStar)-solid.sig0_SA+solid.Hk*solid.etrmax)'});
model.result('pg8').feature('lnsg2').set('linestyle', 'dashed');
model.result('pg8').feature('lnsg2').set('linecolor', 'red');
model.result('pg8').create('lnsg3', 'LineSegments');
model.result('pg8').feature('lnsg3').set('xexpr', {'atent0(dset4_solid_sma2_pt,solid.TStar-solid.sig0_SA/solid.beta-solid.Hk*solid.etrmax/solid.beta)' 'dset4_solid_sma2_Tmax'});
model.result('pg8').feature('lnsg3').set('yexpr', {'0[Pa]' 'atent0(dset4_solid_sma2_pt,solid.beta*(dset4_solid_sma2_Tmax-solid.TStar)+solid.sig0_SA+solid.Hk*solid.etrmax)'});
model.result('pg8').feature('lnsg3').set('linestyle', 'solid');
model.result('pg8').feature('lnsg3').set('linecolor', 'blue');
model.result('pg8').create('lnsg4', 'LineSegments');
model.result('pg8').feature('lnsg4').set('xexpr', {'atent0(dset4_solid_sma2_pt,solid.TStar+solid.sig0_SA/solid.beta)' 'dset4_solid_sma2_Tmax'});
model.result('pg8').feature('lnsg4').set('yexpr', {'0[Pa]' 'atent0(dset4_solid_sma2_pt,solid.beta*(dset4_solid_sma2_Tmax-solid.TStar)-solid.sig0_SA)'});
model.result('pg8').feature('lnsg4').set('linestyle', 'solid');
model.result('pg8').feature('lnsg4').set('linecolor', 'red');
model.result('pg8').create('ptgr1', 'PointGraph');
model.result('pg8').feature('ptgr1').set('titletype', 'manual');
model.result('pg8').feature('ptgr1').set('title', 'Stress vs. temperature');
model.result('pg8').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg8').feature('ptgr1').selection.set([1]);
model.result('pg8').feature('ptgr1').set('expr', 'solid.misesGp');
model.result('pg8').feature('ptgr1').set('xdata', 'expr');
model.result('pg8').feature('ptgr1').set('xdataexpr', {'solid.T'});
model.result('pg8').feature('ptgr1').set('linewidth', 2);
model.result('pg8').feature('ptgr1').create('col1', 'Color');
model.result('pg8').feature('ptgr1').feature('col1').set('expr', {'solid.xiGp_M'});
model.result('pg8').feature('ptgr1').feature('col1').set('colortable', 'Cividis');
model.result('pg8').feature('ptgr1').feature('col1').set('colorscalemode', 'linear');
model.result('pg8').feature('ptgr1').feature('col1').set('colortabletrans', 'reverse');
model.result('pg8').feature('ptgr1').feature('col1').set('rangecoloractive', true);
model.result('pg8').feature('ptgr1').feature('col1').set('rangecolormin', 0);
model.result('pg8').feature('ptgr1').feature('col1').set('rangecolormax', 1);
model.result('pg8').feature('ptgr1').feature('col1').set('titletype', 'auto');
model.result('pg8').label('Shape Memory Alloy Phase Diagram (Shape Memory Alloy 2)');
model.result('pg8').run;
model.result.param.set('dset4_solid_sma2_Tmax', '310[K]');
model.result('pg8').run;
model.result('pg8').setIndex('looplevelinput', 'manual', 0);
model.result('pg8').setIndex('looplevel', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51], 0);
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', [51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121], 0);
model.result('pg8').run;
model.result('pg1').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').label('Pseudoelasticity, Single Loading Cycle');

model.result('pg4').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('plotgroup', 'pg4');
model.nodeGroup('grp2').add('plotgroup', 'pg5');
model.nodeGroup('grp2').add('plotgroup', 'pg6');
model.nodeGroup('grp2').label('Pseudoelasticity, Multiple Loading Cycles');

model.result('pg7').run;

model.nodeGroup.create('grp3', 'Results');
model.nodeGroup('grp3').set('type', 'plotgroup');
model.nodeGroup.move('grp3', 2);
model.nodeGroup('grp3').add('plotgroup', 'pg7');
model.nodeGroup('grp3').add('plotgroup', 'pg8');
model.nodeGroup('grp3').label('Shape Memory Effect');

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'solid/disp1' 'solid/sma2' 'solid/bndl2'});
model.study('std2').feature('stat').set('disabledphysics', {'solid/bndl1' 'solid/sma2' 'solid/bndl2'});

model.result('pg8').run;
model.result('pg8').set('ylabelactive', true);
model.result('pg8').run;
model.result('pg8').set('ylabelactive', false);
model.result('pg8').run;

model.title(['Uniaxial Loading of a Shape Memory Alloy Using the Souza' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Auricchio Model']);

model.description(['Three studies are performed to show the properties of a NiTi alloy block subjected to uniaxial tension' native2unicode(hex2dec({'20' '13'}), 'unicode') 'compression loading, using the Souza' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Auricchio model.' newline  newline 'The first parametric study displays the pseudoelasticity effect at different temperatures. In the second study a partial loading' native2unicode(hex2dec({'20' '13'}), 'unicode') 'unloading cycle is added. Finally, a third study shows the shape memory effect in a low-temperature loading cycle followed by a temperature increase.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;

model.label('uniaxial_loading_of_shape_memory_alloy_souza_auricchio.mph');

model.modelNode.label('Components');

out = model;
