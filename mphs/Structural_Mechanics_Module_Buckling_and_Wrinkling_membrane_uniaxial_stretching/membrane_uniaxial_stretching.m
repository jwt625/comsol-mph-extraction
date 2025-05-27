function out = model
%
% membrane_uniaxial_stretching.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Buckling_and_Wrinkling');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mbrn', 'StructuralMembrane', 'geom1');
model.physics('mbrn').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mbrn', true);

model.param.label('Geometric Parameters');
model.param.set('th', '1[mm]');
model.param.descr('th', 'Thickness of rectangular sheet');
model.param.set('L', '1[m]');
model.param.descr('L', 'Length of rectangular sheet');
model.param.set('W', '0.5[m]');
model.param.descr('W', 'Width of rectangular sheet');
model.param.create('par2');
model.param('par2').label('Isotropic Material Properties');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('E_iso', '100[kPa]', 'Young''s modulus');
model.param('par2').set('nu_iso', '0.3', 'Poisson''s ratio');
model.param.create('par3');
model.param('par3').label('Orthotropic Material Properties');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('E1_orth', '100[kPa]', 'Young''s modulus, 1 component');
model.param('par3').set('E2_orth', '20[kPa]', 'Young''s modulus, 2 component');
model.param('par3').set('E3_orth', '20[kPa]', 'Young''s modulus, 3 component');
model.param('par3').set('nu12_orth', '0.3', 'Poisson''s ratio, 12 component');
model.param('par3').set('nu23_orth', '0', 'Poisson''s ratio, 23 component');
model.param('par3').set('nu13_orth', '0', 'Poisson''s ratio, 13 component');
model.param('par3').set('G12_orth', '38.5[kPa]', 'Shear modulus, 12 component');
model.param('par3').set('G23_orth', 'G12_orth', 'Shear modulus, 23 component');
model.param('par3').set('G13_orth', 'G12_orth', 'Shear modulus, 13 component');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Beta_ana', 'max(-(mbrn.D12*mbrn.eel11+mbrn.D22*mbrn.eel22+mbrn.D23*mbrn.eel33)/mbrn.D22,0)');
model.variable('var1').descr('Beta_ana', 'Wrinkling measure, analytical');
model.variable('var1').set('iswrinkled_ana', 'Beta_ana>0');
model.variable('var1').descr('iswrinkled_ana', 'Is wrinkled, analytical');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L' 'W'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').run;

model.physics('mbrn').feature('lemm1').set('SolidModel', 'Orthotropic');
model.physics('mbrn').feature('lemm1').create('wr1', 'Wrinkling', 2);
model.physics('mbrn').feature('to1').set('d', 'th');
model.physics('mbrn').create('fix1', 'Fixed', 1);
model.physics('mbrn').feature('fix1').selection.set([1]);
model.physics('mbrn').create('disp1', 'Displacement1', 1);
model.physics('mbrn').feature('disp1').selection.set([4]);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('mbrn').feature('disp1').setIndex('U0', '1[mm]', 0);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('mbrn').create('spf1', 'SpringFoundation2', 2);
model.physics('mbrn').feature('spf1').selection.all;
model.physics('mbrn').feature('spf1').set('kPerArea', {'0' '0' '0' '0' '0' '0' '0' '0' '1e-3[N/m^3]'});

model.material.create('sw1', 'Switch', 'comp1');
model.material('sw1').feature.create('mat1', 'Common', 'comp1');
model.material('sw1').feature('mat1').label('Isotropic Material');
model.material('sw1').feature('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('sw1').feature('mat1').propertyGroup('Enu').set('E', {'E_iso'});
model.material('sw1').feature('mat1').propertyGroup('Enu').set('nu', {'nu_iso'});
model.material('sw1').feature('mat1').propertyGroup('def').set('density', {'0'});
model.material('sw1').feature.create('mat2', 'Common', 'comp1');
model.material('sw1').feature('mat2').label('Orthotropic Material');
model.material('sw1').feature('mat2').propertyGroup.create('Orthotropic', 'Orthotropic');
model.material('sw1').feature('mat2').propertyGroup('Orthotropic').set('Evector', {'E1_orth' 'E2_orth' 'E3_orth'});
model.material('sw1').feature('mat2').propertyGroup('Orthotropic').set('nuvector', {'nu12_orth' 'nu23_orth' 'nu13_orth'});
model.material('sw1').feature('mat2').propertyGroup('Orthotropic').set('Gvector', {'G12_orth' 'G23_orth' 'G13_orth'});
model.material('sw1').feature('mat2').propertyGroup('def').set('density', {'0'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('conv1').set('splitmethod', 'center');
model.mesh('mesh1').run;

model.study('std1').create('matsw', 'MaterialSweep');
model.study('std1').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std1').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std1').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std1').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std1').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std1').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*1.118033988749895');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('pm1', 'MaterialSweep');
model.batch('pm1').study('std1');
model.batch('pm1').create('so1', 'Solutionseq');
model.batch('pm1').feature('so1').set('seq', 'sol1');
model.batch('pm1').feature('so1').set('store', 'on');
model.batch('pm1').feature('so1').set('clear', 'on');
model.batch('pm1').feature('so1').set('psol', 'none');
model.batch('pm1').set('pname', {'matsw.comp1.sw1'});
model.batch('pm1').set('plistarr', {'range(1,1,2)'});
model.batch('pm1').set('sweeptype', 'filled');
model.batch('pm1').set('probesel', 'all');
model.batch('pm1').set('probes', {});
model.batch('pm1').set('plot', 'off');
model.batch('pm1').set('err', 'on');
model.batch('pm1').attach('std1');
model.batch('pm1').set('control', 'matsw');

model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'both');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);

model.study('std1').setGenPlots(false);

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('pm1').feature('so1').set('psol', 'sol2');
model.batch('pm1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Wrinkled Region');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('plotarrayenable', true);
model.result('pg1').set('arrayaxis', 'y');
model.result('pg1').set('relpadding', 0.5);
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('arraydim', '1');
model.result('pg1').feature('surf1').set('expr', 'mbrn.iswrinkled');
model.result('pg1').feature('surf1').set('descr', 'Is wrinkled');
model.result('pg1').feature('surf1').set('smooth', 'none');
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').feature('surf2').set('arraydim', '1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('expr', 'iswrinkled_ana');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').feature('surf2').set('titletype', 'none');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('ann1', 'Annotation');
model.result('pg1').feature('ann1').set('arraydim', '1');
model.result('pg1').feature('ann1').set('text', 'Computed');
model.result('pg1').feature('ann1').set('posxexpr', 'L/2');
model.result('pg1').feature('ann1').set('showpoint', false);
model.result('pg1').feature('ann1').set('manualindexing', true);
model.result('pg1').run;
model.result('pg1').create('ann2', 'Annotation');
model.result('pg1').feature('ann2').set('arraydim', '1');
model.result('pg1').feature('ann2').set('text', 'Analytical');
model.result('pg1').feature('ann2').set('posxexpr', 'L/2');
model.result('pg1').feature('ann2').set('posyexpr', 'W');
model.result('pg1').feature('ann2').set('showpoint', false);
model.result('pg1').feature('ann2').set('anchorpoint', 'lowerright');
model.result('pg1').feature('ann2').set('manualindexing', true);
model.result('pg1').feature('ann2').set('arrayindex', 1);
model.result('pg1').run;
model.result('pg1').set('view', 'new');
model.result('pg1').run;

model.view('view3').set('showgrid', false);

model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Wrinkling Measure');
model.result('pg2').feature('surf1').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'mbrn.lemm1.wr1.Beta');
model.result('pg2').feature('surf1').set('descr', 'Wrinkling measure, material frame');
model.result('pg2').feature('surf1').set('smooth', 'material');
model.result('pg2').feature('surf2').set('arraydim', '1');
model.result('pg2').run;
model.result('pg2').feature('surf2').set('expr', 'Beta_ana');
model.result('pg2').feature('surf2').set('smooth', 'material');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('First Principal Stress');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'mbrn.sp1Gp');
model.result('pg3').feature('surf1').set('descr', 'First principal stress');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').run;
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'mbrn.lemm1.wr1.tnx' 'mbrn.lemm1.wr1.tny' 'mbrn.lemm1.wr1.tnz'});
model.result('pg3').feature('arws1').set('descr', 'Tension field direction, spatial frame');
model.result('pg3').run;
model.result.duplicate('pg4', 'pg3');
model.result('pg4').run;
model.result('pg4').label('Second Principal Stress');
model.result('pg4').run;
model.result('pg4').feature('surf1').set('expr', 'mbrn.sp2Gp');
model.result('pg4').feature('surf1').set('descr', 'Second principal stress');
model.result('pg4').run;
model.result('pg4').feature('arws1').set('expr', {'mbrn.lemm1.wr1.wnx' 'mbrn.lemm1.wr1.wny' 'mbrn.lemm1.wr1.wnz'});
model.result('pg4').feature('arws1').set('descr', 'Wrinkling direction, spatial frame');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg1').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').add('plotgroup', 'pg4');
model.nodeGroup('grp1').label('Isotropic Material');
model.nodeGroup.duplicate('grp2', 'grp1');
model.nodeGroup('grp2').label('Orthotropic Material');

model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 2, 0);
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 2, 0);
model.result('pg6').feature('surf1').set('arraydim', '1');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('rangecoloractive', true);
model.result('pg6').feature('surf1').set('rangecolormax', 1.2E-5);
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').setIndex('looplevel', 2, 0);
model.result('pg7').run;
model.result('pg8').run;
model.result('pg8').setIndex('looplevel', 2, 0);
model.result('pg8').run;
model.result('pg1').run;
model.result.duplicate('pg9', 'pg1');

model.nodeGroup('grp1').add('plotgroup', 'pg9');

model.result('pg9').run;
model.result('pg9').set('edges', false);
model.result('pg9').set('plotarrayenable', false);
model.result('pg9').run;
model.result('pg9').feature.remove('surf2');
model.result('pg9').feature.remove('ann1');
model.result('pg9').feature.remove('ann2');
model.result('pg9').run;
model.result('pg9').feature('surf1').create('def1', 'Deform');
model.result('pg9').run;
model.result('pg9').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg9').feature('surf1').feature('def1').set('scale', 500);
model.result('pg9').run;
model.result('pg9').create('arwl1', 'ArrowLine');
model.result('pg9').feature('arwl1').set('expr', {'1' '0' '0'});
model.result('pg9').feature('arwl1').set('arrowcount', 5);
model.result('pg9').feature('arwl1').set('scaleactive', true);
model.result('pg9').feature('arwl1').set('scale', 0.1);
model.result('pg9').feature('arwl1').set('inheritplot', 'surf1');
model.result('pg9').feature('arwl1').set('inheritrange', false);
model.result('pg9').feature('arwl1').set('inheritcolor', false);
model.result('pg9').feature('arwl1').set('inheritarrowscale', false);
model.result('pg9').feature('arwl1').create('sel1', 'Selection');
model.result('pg9').feature('arwl1').feature('sel1').selection.set([4]);
model.result('pg9').run;
model.result('pg9').feature('arwl1').create('def1', 'Deform');
model.result('pg9').run;
model.result('pg9').run;
model.result('pg9').feature.duplicate('arwl2', 'arwl1');
model.result('pg9').run;
model.result('pg9').feature('arwl2').set('expr', {'-1' '0' '0'});
model.result('pg9').run;
model.result('pg9').feature('arwl2').feature('sel1').selection.set([1]);
model.result('pg9').run;
model.result('pg9').run;
model.result.remove('pg9');
model.result('pg4').run;
model.result('pg5').run;

model.title('Uniaxial Stretching of a Rectangular Membrane');

model.description('This example demonstrates the wrinkling phenomenon in a thin sheet stretched uniaxially. The modified membrane theory, which incorporates the wrinkling model, ensures noncompressive principal stresses in the wrinkled region. The analytical results are compared to the numerical results.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('membrane_uniaxial_stretching.mph');

model.modelNode.label('Components');

out = model;
