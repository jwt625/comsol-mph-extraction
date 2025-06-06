function out = model
%
% membrane_torsion.m
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

model.param.label('Model Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('th', '1[m]', 'Thickness of circular sheet');
model.param.set('Rin', '5[m]', 'Inner radius of circular sheet');
model.param.set('Rout', '12.5[m]', 'Outer radius of circular sheet');
model.param.set('theta', '0[deg]', 'Rotation');
model.param.set('rxx', '0', 'Intermediate help variable');
model.param.set('ryy', '0', 'Intermediate help variable');
model.param.set('rzz', '1', 'Intermediate help variable');
model.param.set('rx', 'rxx/sqrt(rxx^2+ryy^2+rzz^2)', 'Intermediate help variable');
model.param.set('ry', 'ryy/sqrt(rxx^2+ryy^2+rzz^2)', 'Intermediate help variable');
model.param.set('rz', 'rzz/sqrt(rxx^2+ryy^2+rzz^2)', 'Intermediate help variable');
model.param.set('ct', 'cos(theta)', 'Intermediate help variable');
model.param.set('st', 'sin(theta)', 'Intermediate help variable');
model.param.set('R11', 'ct+rx^2*(1-ct)', 'Rotation matrix, 11 component');
model.param.set('R12', 'rx*ry*(1-ct)-rz*st', 'Rotation matrix, 12 component');
model.param.set('R13', 'rx*rz*(1-ct)+ry*st', 'Rotation matrix, 13 component');
model.param.set('R21', 'rx*ry*(1-ct)+rz*st', 'Rotation matrix, 21 component');
model.param.set('R22', 'ct+ry^2*(1-ct)', 'Rotation matrix, 22 component');
model.param.set('R23', 'rz*ry*(1-ct)-rx*st', 'Rotation matrix, 23 component');
model.param.set('R31', 'rx*rz*(1-ct)-ry*st', 'Rotation matrix, 31 component');
model.param.set('R32', 'rz*ry*(1-ct)+rx*st', 'Rotation matrix, 32 component');
model.param.set('R33', 'ct+rz^2*(1-ct)', 'Rotation matrix, 33 component');
model.param.create('par2');
model.param('par2').label('Isotropic Material Properties');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('DD11_iso', '109.89[kPa]', 'Elasticity matrix, 11 element');
model.param('par2').set('DD12_iso', '32.967[kPa]', 'Elasticity matrix, 12 element');
model.param('par2').set('DD22_iso', '109.89[kPa]', 'Elasticity matrix, 22 element');
model.param('par2').set('DD33_iso', 'DD22_iso', 'Elasticity matrix, 33 element');
model.param('par2').set('DD44_iso', '38.462[kPa]', 'Elasticity matrix, 44 element');
model.param('par2').set('DD55_iso', 'DD44_iso', 'Elasticity matrix, 55 element');
model.param('par2').set('DD66_iso', 'DD44_iso', 'Elasticity matrix, 66 element');
model.param.create('par3');
model.param('par3').label('Orthotropic Material Properties');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('DD11_orth', '100.91[kPa]', 'Elasticity matrix, 11 element');
model.param('par3').set('DD12_orth', '30.272[kPa]', 'Elasticity matrix, 12 element');
model.param('par3').set('DD22_orth', '1009.1[kPa]', 'Elasticity matrix, 22 element');
model.param('par3').set('DD33_orth', 'DD22_orth', 'Elasticity matrix, 33 element');
model.param('par3').set('DD44_orth', '38.5[kPa]', 'Elasticity matrix, 44 element');
model.param('par3').set('DD55_orth', 'DD44_orth', 'Elasticity matrix, 55 element');
model.param('par3').set('DD66_orth', 'DD44_orth', 'Elasticity matrix, 66 element');

model.geom('geom1').run;

model.mesh('mesh1').label('Triangular Mesh, Pattern 1');
model.mesh('mesh1').create('imp1', 'Import');
model.mesh('mesh1').feature('imp1').set('filename', 'membrane_torsion_tria_mesh1.mphbin');
model.mesh('mesh1').feature('imp1').importData;
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').label('Triangular Mesh, Pattern 2');
model.mesh('mesh2').create('imp1', 'Import');
model.mesh('mesh2').feature('imp1').set('filename', 'membrane_torsion_tria_mesh2.mphbin');
model.mesh('mesh2').feature('imp1').importData;
model.mesh('mesh2').run;
model.mesh.create('mesh3', 'geom1');
model.mesh('mesh3').label('Quadrilateral Mesh, Pattern 1');
model.mesh('mesh3').create('imp1', 'Import');
model.mesh('mesh3').feature('imp1').set('filename', 'membrane_torsion_quad_mesh1.mphbin');
model.mesh('mesh3').feature('imp1').importData;
model.mesh('mesh3').run;
model.mesh.create('mesh4', 'geom1');
model.mesh('mesh4').label('Quadrilateral Mesh, Pattern 2');
model.mesh('mesh4').create('imp1', 'Import');
model.mesh('mesh4').feature('imp1').set('filename', 'membrane_torsion_quad_mesh2.mphbin');
model.mesh('mesh4').feature('imp1').importData;
model.mesh('mesh4').run;

model.physics('mbrn').prop('ShapeProperty').set('order_displacement', 1);
model.physics('mbrn').feature('lemm1').set('SolidModel', 'Anisotropic');
model.physics('mbrn').feature('lemm1').create('wr1', 'Wrinkling', 2);
model.physics('mbrn').feature('lemm1').feature('wr1').set('termination', 'steporresi');
model.physics('mbrn').feature('to1').set('d', 'th');
model.physics('mbrn').create('fix1', 'Fixed', 1);
model.physics('mbrn').feature('fix1').selection.set([2 3 7 11]);
model.physics('mbrn').create('disp1', 'Displacement1', 1);
model.physics('mbrn').feature('disp1').selection.set([4 5 8 10]);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 0);
model.physics('mbrn').feature('disp1').setIndex('U0', '(R11-1)*X+R12*Y+R13*Z', 0);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('mbrn').feature('disp1').setIndex('U0', 'R21*X+(R22-1)*Y+R23*Z', 1);
model.physics('mbrn').feature('disp1').setIndex('Direction', 'prescribed', 2);
model.physics('mbrn').feature('disp1').setIndex('U0', 'R31*X+R32*Y+(R33-1)*Z', 2);
model.physics('mbrn').create('spf1', 'SpringFoundation2', 2);
model.physics('mbrn').feature('spf1').selection.all;
model.physics('mbrn').feature('spf1').set('kPerArea', {'0' '0' '0' '0' '0' '0' '0' '0' '1e-3[N/m^3]'});
model.physics('mbrn').create('disc1', 'Discretization', -1);
model.physics('mbrn').feature('disc1').set('order_displacement', 2);
model.physics('mbrn').feature('disc1').label('Quadratic Discretization');

model.material.create('sw1', 'Switch', 'comp1');
model.material('sw1').feature.create('mat1', 'Common', 'comp1');
model.material('sw1').feature('mat1').label('Isotropic Material');
model.material('sw1').feature('mat1').propertyGroup.create('Anisotropic', 'Anisotropic');
model.material('sw1').feature('mat1').propertyGroup('Anisotropic').set('D', {'DD11_iso' 'DD12_iso' 'DD22_iso' '0' '0' 'DD33_iso' '0' '0' '0' 'DD44_iso'  ...
'0' '0' '0' '0' 'DD55_iso' '0' '0' '0' '0' '0'  ...
'DD66_iso'});
model.material('sw1').feature('mat1').propertyGroup('def').set('density', {'0'});
model.material('sw1').feature.create('mat2', 'Common', 'comp1');
model.material('sw1').feature('mat2').label('Orthotropic Material');
model.material('sw1').feature('mat2').propertyGroup.create('Anisotropic', 'Anisotropic');
model.material('sw1').feature('mat2').propertyGroup('Anisotropic').set('D', {'DD11_orth' 'DD12_orth' 'DD22_orth' '0' '0' 'DD33_orth' '0' '0' '0' 'DD44_orth'  ...
'0' '0' '0' '0' 'DD55_orth' '0' '0' '0' '0' '0'  ...
'DD66_orth'});
model.material('sw1').feature('mat2').propertyGroup('def').set('density', {'0'});

model.study('std1').label('Study: Three Noded Triangular (Pattern 1)');
model.study('std1').setGenPlots(false);
model.study('std1').create('matsw', 'MaterialSweep');
model.study('std1').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std1').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std1').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std1').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std1').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std1').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'ct', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'ct', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'theta', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(0,0.5,10)', 0);
model.study('std1').feature('stat').setIndex('punit', 'deg', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_mbrn_u1n').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbrn_u2n').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbrn_u1n').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_mbrn_u2n').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*35.35533905932738');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
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

model.sol('sol1').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('stabacc', 'aacc');
model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('pm1').feature('so1').set('psol', 'sol2');
model.batch('pm1').run('compute');

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mbrn', true);
model.study('std2').label('Study: Three Noded Triangular (Pattern 2)');
model.study('std2').setGenPlots(false);
model.study('std2').create('matsw', 'MaterialSweep');
model.study('std2').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std2').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std2').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std2').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std2').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std2').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std2').feature('stat').setEntry('mesh', 'geom1', 'mesh2');
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 'ct', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'ct', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', '', 0);
model.study('std2').feature('stat').setIndex('pname', 'theta', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(0,0.5,10)', 0);
model.study('std2').feature('stat').setIndex('punit', 'deg', 0);

model.sol.create('sol5');
model.sol('sol5').study('std2');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std2');
model.sol('sol5').feature('st1').set('studystep', 'stat');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_mbrn_u1n').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_mbrn_u2n').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_mbrn_u1n').set('scaleval', '1e-3');
model.sol('sol5').feature('v1').feature('comp1_mbrn_u2n').set('scaleval', '1e-3');
model.sol('sol5').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol5').feature('v1').feature('comp1_u').set('scaleval', '1e-2*35.35533905932738');
model.sol('sol5').feature('v1').set('control', 'stat');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').create('p1', 'Parametric');
model.sol('sol5').feature('s1').feature.remove('pDef');
model.sol('sol5').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol5').feature('s1').set('control', 'stat');
model.sol('sol5').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol5').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').attach('std2');

model.batch.create('pm2', 'MaterialSweep');
model.batch('pm2').study('std2');
model.batch('pm2').create('so1', 'Solutionseq');
model.batch('pm2').feature('so1').set('seq', 'sol5');
model.batch('pm2').feature('so1').set('store', 'on');
model.batch('pm2').feature('so1').set('clear', 'on');
model.batch('pm2').feature('so1').set('psol', 'none');
model.batch('pm2').set('pname', {'matsw.comp1.sw1'});
model.batch('pm2').set('plistarr', {'range(1,1,2)'});
model.batch('pm2').set('sweeptype', 'filled');
model.batch('pm2').set('probesel', 'all');
model.batch('pm2').set('probes', {});
model.batch('pm2').set('plot', 'off');
model.batch('pm2').set('err', 'on');
model.batch('pm2').attach('std2');
model.batch('pm2').set('control', 'matsw');

model.sol('sol5').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol5').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol5').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol5').feature('s1').feature('fc1').set('stabacc', 'aacc');
model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').label('Parametric Solutions 2');

model.batch('pm2').feature('so1').set('psol', 'sol6');
model.batch('pm2').run('compute');

model.study.create('std3');
model.study('std3').create('stat', 'Stationary');
model.study('std3').feature('stat').setSolveFor('/physics/mbrn', true);
model.study('std3').label('Study: Four Noded Quadrilateral (Pattern 3)');
model.study('std3').setGenPlots(false);
model.study('std3').create('matsw', 'MaterialSweep');
model.study('std3').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std3').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std3').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std3').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std3').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std3').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std3').feature('stat').setEntry('mesh', 'geom1', 'mesh3');
model.study('std3').feature('stat').set('useparam', true);
model.study('std3').feature('stat').setIndex('pname', 'ct', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', '', 0);
model.study('std3').feature('stat').setIndex('pname', 'ct', 0);
model.study('std3').feature('stat').setIndex('plistarr', '', 0);
model.study('std3').feature('stat').setIndex('punit', '', 0);
model.study('std3').feature('stat').setIndex('pname', 'theta', 0);
model.study('std3').feature('stat').setIndex('plistarr', 'range(0,0.5,10)', 0);
model.study('std3').feature('stat').setIndex('punit', 'deg', 0);

model.sol.create('sol9');
model.sol('sol9').study('std3');
model.sol('sol9').create('st1', 'StudyStep');
model.sol('sol9').feature('st1').set('study', 'std3');
model.sol('sol9').feature('st1').set('studystep', 'stat');
model.sol('sol9').create('v1', 'Variables');
model.sol('sol9').feature('v1').feature('comp1_mbrn_u1n').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_mbrn_u2n').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol9').feature('v1').feature('comp1_mbrn_u1n').set('scaleval', '1e-3');
model.sol('sol9').feature('v1').feature('comp1_mbrn_u2n').set('scaleval', '1e-3');
model.sol('sol9').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol9').feature('v1').feature('comp1_u').set('scaleval', '1e-2*35.35533905932738');
model.sol('sol9').feature('v1').set('control', 'stat');
model.sol('sol9').create('s1', 'Stationary');
model.sol('sol9').feature('s1').create('p1', 'Parametric');
model.sol('sol9').feature('s1').feature.remove('pDef');
model.sol('sol9').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol9').feature('s1').set('control', 'stat');
model.sol('sol9').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol9').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol9').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol9').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol9').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol9').feature('s1').feature.remove('fcDef');
model.sol('sol9').attach('std3');

model.batch.create('pm3', 'MaterialSweep');
model.batch('pm3').study('std3');
model.batch('pm3').create('so1', 'Solutionseq');
model.batch('pm3').feature('so1').set('seq', 'sol9');
model.batch('pm3').feature('so1').set('store', 'on');
model.batch('pm3').feature('so1').set('clear', 'on');
model.batch('pm3').feature('so1').set('psol', 'none');
model.batch('pm3').set('pname', {'matsw.comp1.sw1'});
model.batch('pm3').set('plistarr', {'range(1,1,2)'});
model.batch('pm3').set('sweeptype', 'filled');
model.batch('pm3').set('probesel', 'all');
model.batch('pm3').set('probes', {});
model.batch('pm3').set('plot', 'off');
model.batch('pm3').set('err', 'on');
model.batch('pm3').attach('std3');
model.batch('pm3').set('control', 'matsw');

model.sol('sol9').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol9').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol9').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol9').feature('s1').feature('fc1').set('stabacc', 'aacc');
model.sol.create('sol10');
model.sol('sol10').study('std3');
model.sol('sol10').label('Parametric Solutions 3');

model.batch('pm3').feature('so1').set('psol', 'sol10');
model.batch('pm3').run('compute');

model.study.create('std4');
model.study('std4').create('stat', 'Stationary');
model.study('std4').feature('stat').setSolveFor('/physics/mbrn', true);
model.study('std4').label('Study: Nine Noded Quadrilateral (Pattern 4)');
model.study('std4').setGenPlots(false);
model.study('std4').create('matsw', 'MaterialSweep');
model.study('std4').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std4').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std4').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std4').feature('matsw').setIndex('pname', 'matsw.comp1.sw1', 0);
model.study('std4').feature('matsw').setIndex('pcase', 'all', 0);
model.study('std4').feature('matsw').setIndex('plistarr', 'range(1,1,2)', 0);
model.study('std4').feature('stat').set('useadvanceddisable', true);
model.study('std4').feature('stat').setEntry('discretization', 'mbrn', 'disc1');
model.study('std4').feature('stat').setEntry('mesh', 'geom1', 'mesh4');
model.study('std4').feature('stat').set('useparam', true);
model.study('std4').feature('stat').setIndex('pname', 'ct', 0);
model.study('std4').feature('stat').setIndex('plistarr', '', 0);
model.study('std4').feature('stat').setIndex('punit', '', 0);
model.study('std4').feature('stat').setIndex('pname', 'ct', 0);
model.study('std4').feature('stat').setIndex('plistarr', '', 0);
model.study('std4').feature('stat').setIndex('punit', '', 0);
model.study('std4').feature('stat').setIndex('pname', 'theta', 0);
model.study('std4').feature('stat').setIndex('plistarr', 'range(0,0.5,10)', 0);
model.study('std4').feature('stat').setIndex('punit', 'deg', 0);

model.sol.create('sol13');
model.sol('sol13').study('std4');
model.sol('sol13').create('st1', 'StudyStep');
model.sol('sol13').feature('st1').set('study', 'std4');
model.sol('sol13').feature('st1').set('studystep', 'stat');
model.sol('sol13').create('v1', 'Variables');
model.sol('sol13').feature('v1').feature('comp1_mbrn_u1n').set('scalemethod', 'manual');
model.sol('sol13').feature('v1').feature('comp1_mbrn_u2n').set('scalemethod', 'manual');
model.sol('sol13').feature('v1').feature('comp1_mbrn_unn').set('scalemethod', 'manual');
model.sol('sol13').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol13').feature('v1').feature('comp1_mbrn_u1n').set('scaleval', '1e-3');
model.sol('sol13').feature('v1').feature('comp1_mbrn_u2n').set('scaleval', '1e-3');
model.sol('sol13').feature('v1').feature('comp1_mbrn_unn').set('scaleval', '1e-3');
model.sol('sol13').feature('v1').feature('comp1_u').set('scaleval', '1e-2*35.35533905932738');
model.sol('sol13').feature('v1').set('control', 'stat');
model.sol('sol13').create('s1', 'Stationary');
model.sol('sol13').feature('s1').create('p1', 'Parametric');
model.sol('sol13').feature('s1').feature.remove('pDef');
model.sol('sol13').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol13').feature('s1').set('control', 'stat');
model.sol('sol13').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol13').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol13').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol13').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol13').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol13').feature('s1').feature.remove('fcDef');
model.sol('sol13').attach('std4');

model.batch.create('pm4', 'MaterialSweep');
model.batch('pm4').study('std4');
model.batch('pm4').create('so1', 'Solutionseq');
model.batch('pm4').feature('so1').set('seq', 'sol13');
model.batch('pm4').feature('so1').set('store', 'on');
model.batch('pm4').feature('so1').set('clear', 'on');
model.batch('pm4').feature('so1').set('psol', 'none');
model.batch('pm4').set('pname', {'matsw.comp1.sw1'});
model.batch('pm4').set('plistarr', {'range(1,1,2)'});
model.batch('pm4').set('sweeptype', 'filled');
model.batch('pm4').set('probesel', 'all');
model.batch('pm4').set('probes', {});
model.batch('pm4').set('plot', 'off');
model.batch('pm4').set('err', 'on');
model.batch('pm4').attach('std4');
model.batch('pm4').set('control', 'matsw');

model.sol('sol13').feature('s1').feature('p1').set('porder', 'linear');
model.sol('sol13').feature('s1').feature('fc1').set('dtech', 'const');
model.sol('sol13').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol13').feature('s1').feature('fc1').set('stabacc', 'aacc');
model.sol.create('sol14');
model.sol('sol14').study('std4');
model.sol('sol14').label('Parametric Solutions 4');

model.batch('pm4').feature('so1').set('psol', 'sol14');
model.batch('pm4').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Wrinkled Region');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').set('edges', false);
model.result('pg1').set('plotarrayenable', true);
model.result('pg1').set('arrayshape', 'square');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('arraydim', '2');
model.result('pg1').feature('surf1').set('expr', 'mbrn.iswrinkled');
model.result('pg1').feature('surf1').set('descr', 'Is wrinkled');
model.result('pg1').feature('surf1').set('resolution', 'norefine');
model.result('pg1').feature('surf1').set('smooth', 'none');
model.result('pg1').feature('surf1').set('manualindexing', true);
model.result('pg1').feature('surf1').set('rowindex', 1);
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').feature('surf2').set('arraydim', '2');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('data', 'dset4');
model.result('pg1').feature('surf2').setIndex('looplevel', 1, 1);
model.result('pg1').feature('surf2').set('titletype', 'none');
model.result('pg1').feature('surf2').set('inheritplot', 'surf1');
model.result('pg1').feature('surf2').set('rowindex', 0);
model.result('pg1').feature.duplicate('surf3', 'surf2');
model.result('pg1').feature('surf3').set('arraydim', '2');
model.result('pg1').run;
model.result('pg1').feature('surf3').set('data', 'dset6');
model.result('pg1').feature('surf3').set('rowindex', 1);
model.result('pg1').feature('surf3').set('colindex', 1);
model.result('pg1').feature.duplicate('surf4', 'surf3');
model.result('pg1').feature('surf4').set('arraydim', '2');
model.result('pg1').run;
model.result('pg1').feature('surf4').set('data', 'dset8');
model.result('pg1').feature('surf4').set('rowindex', 0);
model.result('pg1').run;
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('titleparamindicator', false);

model.view('view1').set('showgrid', false);
model.view('view1').set('showaxisorientation', false);

model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('First Principal Stress');
model.result('pg2').set('legendpos', 'rightdouble');
model.result('pg2').feature('surf1').set('arraydim', '2');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'mbrn.sp1');
model.result('pg2').feature('surf1').set('unit', 'kPa');
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').feature('surf2').set('arraydim', '2');
model.result('pg2').run;
model.result('pg2').feature('surf2').set('expr', 'mbrn.sp1');
model.result('pg2').feature('surf2').set('unit', 'kPa');
model.result('pg2').feature('surf2').set('inheritplot', 'none');
model.result('pg2').feature('surf2').set('colortable', 'Prism');
model.result('pg2').feature('surf3').set('arraydim', '2');
model.result('pg2').run;
model.result('pg2').feature('surf3').set('expr', 'mbrn.sp1');
model.result('pg2').feature('surf3').set('unit', 'kPa');
model.result('pg2').feature('surf3').set('inheritplot', 'none');
model.result('pg2').feature('surf3').set('colortable', 'Prism');
model.result('pg2').feature('surf4').set('arraydim', '2');
model.result('pg2').run;
model.result('pg2').feature('surf4').set('expr', 'mbrn.sp1');
model.result('pg2').feature('surf4').set('unit', 'kPa');
model.result('pg2').feature('surf4').set('inheritplot', 'none');
model.result('pg2').feature('surf4').set('colortable', 'Prism');
model.result('pg2').run;
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').run;
model.result.duplicate('pg3', 'pg2');
model.result('pg3').run;
model.result('pg3').label('Second Principal Stress');
model.result('pg3').feature('surf1').set('arraydim', '2');
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'mbrn.sp2');
model.result('pg3').feature('surf2').set('arraydim', '2');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('expr', 'mbrn.sp2');
model.result('pg3').feature('surf3').set('arraydim', '2');
model.result('pg3').run;
model.result('pg3').feature('surf3').set('expr', 'mbrn.sp2');
model.result('pg3').feature('surf4').set('arraydim', '2');
model.result('pg3').run;
model.result('pg3').feature('surf4').set('expr', 'mbrn.sp2');
model.result('pg3').run;
model.result('pg3').run;
model.result.evaluationGroup.create('eg1', 'EvaluationGroup');
model.result.evaluationGroup('eg1').label('Maximum Wrinkling Measure (Isotropic)');
model.result.evaluationGroup('eg1').set('data', 'dset2');
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'first', 1);
model.result.evaluationGroup('eg1').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').create('max1', 'MaxSurface');
model.result.evaluationGroup('eg1').feature('max1').selection.all;
model.result.evaluationGroup('eg1').feature('max1').set('expr', {'mbrn.lemm1.wr1.Beta'});
model.result.evaluationGroup('eg1').feature('max1').set('descr', {'Wrinkling measure, material frame'});
model.result.evaluationGroup('eg1').feature('max1').set('unit', {'1'});
model.result.evaluationGroup('eg1').feature.duplicate('max2', 'max1');
model.result.evaluationGroup('eg1').feature('max2').set('data', 'dset4');
model.result.evaluationGroup('eg1').feature('max2').setIndex('looplevelinput', 'first', 1);
model.result.evaluationGroup('eg1').feature('max2').setIndex('looplevelinput', 'last', 0);
model.result.evaluationGroup('eg1').feature.duplicate('max3', 'max2');
model.result.evaluationGroup('eg1').feature('max3').set('data', 'dset6');
model.result.evaluationGroup('eg1').feature.duplicate('max4', 'max3');
model.result.evaluationGroup('eg1').feature('max4').set('data', 'dset8');
model.result.evaluationGroup('eg1').set('transpose', true);
model.result.evaluationGroup('eg1').run;
model.result('pg1').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg3');
model.nodeGroup('grp1').label('Isotropic Material');
model.nodeGroup.duplicate('grp2', 'grp1');
model.nodeGroup('grp2').label('Orthotropic Material');

model.result('pg4').run;
model.result('pg4').setIndex('looplevel', 2, 1);
model.result('pg4').feature('surf2').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('surf2').setIndex('looplevel', 2, 1);
model.result('pg4').feature('surf3').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('surf3').setIndex('looplevel', 2, 1);
model.result('pg4').feature('surf4').set('arraydim', '2');
model.result('pg4').run;
model.result('pg4').feature('surf4').setIndex('looplevel', 2, 1);
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').setIndex('looplevel', 2, 1);
model.result('pg5').feature('surf2').set('arraydim', '2');
model.result('pg5').run;
model.result('pg5').feature('surf2').setIndex('looplevel', 2, 1);
model.result('pg5').feature('surf3').set('arraydim', '2');
model.result('pg5').run;
model.result('pg5').feature('surf3').setIndex('looplevel', 2, 1);
model.result('pg5').feature('surf4').set('arraydim', '2');
model.result('pg5').run;
model.result('pg5').feature('surf4').setIndex('looplevel', 2, 1);
model.result('pg5').run;
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 2, 1);
model.result('pg6').feature('surf2').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf2').setIndex('looplevel', 2, 1);
model.result('pg6').feature('surf3').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf3').setIndex('looplevel', 2, 1);
model.result('pg6').feature('surf4').set('arraydim', '2');
model.result('pg6').run;
model.result('pg6').feature('surf4').setIndex('looplevel', 2, 1);
model.result('pg6').run;
model.result.evaluationGroup.duplicate('eg2', 'eg1');
model.result.evaluationGroup('eg2').label('Maximum Wrinkling Measure (Orthotropic)');
model.result.evaluationGroup('eg2').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('eg2').feature('max2').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('eg2').feature('max3').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('eg2').feature('max4').setIndex('looplevelinput', 'last', 1);
model.result.evaluationGroup('eg2').run;
model.result('pg4').run;
model.result.duplicate('pg7', 'pg4');

model.nodeGroup('grp2').add('plotgroup', 'pg7');

model.result('pg7').run;
model.result('pg7').feature('surf2').set('arraydim', '2');
model.result('pg7').run;
model.result('pg7').feature('surf2').active(false);
model.result('pg7').feature('surf3').active(false);
model.result('pg7').feature('surf4').active(false);
model.result('pg7').feature('surf1').set('arraydim', '2');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('smooth', 'material');
model.result('pg7').run;
model.result('pg7').create('arwl1', 'ArrowLine');
model.result('pg7').feature('arwl1').set('arraydim', '2');
model.result('pg7').feature('arwl1').set('titletype', 'none');
model.result('pg7').feature('arwl1').set('expr', {'(R11-1)*X+R12*Y+R13*Z' 'v' 'w'});
model.result('pg7').feature('arwl1').setIndex('expr', 'R21*X+(R22-1)*Y+R23*Z', 1);
model.result('pg7').feature('arwl1').setIndex('expr', 'R31*X+R32*Y+(R33-1)*Z', 2);
model.result('pg7').feature('arwl1').set('arrowcount', 20);
model.result('pg7').feature('arwl1').set('scaleactive', true);
model.result('pg7').feature('arwl1').set('scale', 4);
model.result('pg7').feature('arwl1').create('sel1', 'Selection');
model.result('pg7').feature('arwl1').feature('sel1').selection.set([4 5 8 10]);
model.result('pg7').run;
model.result('pg7').set('data', 'dset8');
model.result('pg7').setIndex('looplevel', 1, 1);
model.result('pg7').set('plotarrayenable', false);
model.result('pg7').run;
model.result.remove('pg7');
model.result('pg6').run;
model.result('pg1').run;

model.title('Torsion of a Circular Membrane');

model.description(['In this example, torque is applied to the inner edge of a circular annulus-shaped membrane while the outer edge is fixed, resulting in wrinkling of the membrane. The wrinkling membrane model avoids the equilibrium instability that would be produced by the compressive stresses.' newline  newline 'The effect of the mesh pattern and discretization order on the wrinkling and the stress distribution is studied in this example.']);

model.mesh('mesh2').clearMesh;
model.mesh('mesh3').clearMesh;
model.mesh('mesh4').clearMesh;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;
model.sol('sol10').clearSolutionData;
model.sol('sol11').clearSolutionData;
model.sol('sol12').clearSolutionData;
model.sol('sol13').clearSolutionData;
model.sol('sol14').clearSolutionData;
model.sol('sol15').clearSolutionData;
model.sol('sol16').clearSolutionData;

model.label('membrane_torsion.mph');

model.modelNode.label('Components');

out = model;
