function out = model
%
% gregory_maksutov_telescope.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Lenses_Cameras_and_Telescopes');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('gop', 'GeometricalOptics', 'geom1');
model.physics('gop').model('comp1');

model.study.create('std1');
model.study('std1').create('rtrac', 'RayTracing');
model.study('std1').feature('rtrac').setSolveFor('/physics/gop', true);

model.param.label('Parameters 1: Lens Prescription');
model.param.create('par2');
model.param('par2').label('Parameters 2: General');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('lam1', '486.0[nm]', 'Wavelength 1');
model.param('par2').set('lam2', '546.0[nm]', 'Wavelength 2');
model.param('par2').set('lam3', '656.0[nm]', 'Wavelength 3');
model.param('par2').set('lam_mean', '(lam1+lam2+lam3)/3', 'Mean wavelength');
model.param('par2').set('theta_x1', '0.000[deg]', 'Field angle 1, x-component');
model.param('par2').set('theta_y1', '0.000[deg]', 'Field angle 1, y-component');
model.param('par2').set('theta_x2', '0.000[deg]', 'Field angle 2, x-component');
model.param('par2').set('theta_y2', '0.125[deg]', 'Field angle 2, y-component');
model.param('par2').set('theta_x3', '0.000[deg]', 'Field angle 3, x-component');
model.param('par2').set('theta_y3', '0.250[deg]', 'Field angle 3, y-component');
model.param('par2').set('N_ring', '12', 'Number of hexapolar rings');
model.param('par2').set('P_nom', '200.0[mm]', 'Nominal entrance pupil diameter');
model.param('par2').set('F_nom', '10.0', 'Nominal focal ratio');
model.param('par2').set('f_nom', 'F_nom*P_nom', 'Nominal focal length');
model.param('par2').set('theta_Airy', '1.22*lam_mean/P_nom', 'Airy disc angular radius');
model.param('par2').set('r_Airy', 'f_nom*theta_Airy', 'Airy disc radius');
model.param('par2').set('vz', '-1', 'Ray direction vector, z-component');
model.param('par2').set('vx1', 'tan(theta_x1)', 'Ray direction vector, x-component');
model.param('par2').set('vy1', 'tan(theta_y1)', 'Ray direction vector, y-component');
model.param('par2').set('vx2', 'tan(theta_x2)', 'Ray direction vector, x-component');
model.param('par2').set('vy2', 'tan(theta_y2)', 'Ray direction vector, y-component');
model.param('par2').set('vx3', 'tan(theta_x3)', 'Ray direction vector, x-component');
model.param('par2').set('vy3', 'tan(theta_y3)', 'Ray direction vector, y-component');
model.param('par2').set('dz', '50[mm]', 'Ray launch z-coordinate');
model.param('par2').set('dx1', '-dz*tan(theta_x1)', 'Ray launch, field 1, x-coordinate');
model.param('par2').set('dy1', '-dz*tan(theta_y1)', 'Ray launch, field 1, y-coordinate');
model.param('par2').set('dx2', '-dz*tan(theta_x2)', 'Ray launch, field 2, x-coordinate');
model.param('par2').set('dy2', '-dz*tan(theta_y2)', 'Ray launch, field 2, y-coordinate');
model.param('par2').set('dx3', '-dz*tan(theta_x3)', 'Ray launch, field 3, x-coordinate');
model.param('par2').set('dy3', '-dz*tan(theta_y3)', 'Ray launch, field 3, y-coordinate');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').label('Gregory-Maksutov Telescope');
model.geom('geom1').insertFile('gregory_maksutov_telescope_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('DispersionModelSellmeierStandard', 'Sellmeier');
model.material('mat1').propertyGroup.create('ThermoOpticDispersionModelSchott', 'Schott thermo-optic');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('InternalTransmittance10', ['Internal transmittance, 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat1').propertyGroup('InternalTransmittance10').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('InternalTransmittance25', ['Internal transmittance, 25' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'mm sample thickness']);
model.material('mat1').propertyGroup('InternalTransmittance25').func.create('int1', 'Interpolation');
model.material('mat1').label('Schott N-BK7 Glass');
model.material('mat1').propertyGroup('def').set('density', '2.51[g/cm^3]');
model.material('mat1').propertyGroup('def').set('heatcapacity', '0.858[J/(g*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'1.114[W/(m*K)]' '0' '0' '0' '1.114[W/(m*K)]' '0' '0' '0' '1.114[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'7.1E-6[1/K]' '0' '0' '0' '7.1E-6[1/K]' '0' '0' '0' '7.1E-6[1/K]'});
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('ODsma', {'1.03961212E+00' '2.31792344E-01' '1.01046945E+00' '6.00069867E-03' '2.00179144E-02' '1.03560653E+02'});
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Trefsma', '22[degC]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').set('Prefsma', '1[atm]');
model.material('mat1').propertyGroup('DispersionModelSellmeierStandard').addInput('frequency');
model.material('mat1').propertyGroup('ThermoOpticDispersionModelSchott').set('TOsco', {'1.86E-6' '1.31E-8' '-1.37E-11' '4.34E-7' '6.27E-10' '0.17'});
model.material('mat1').propertyGroup('ThermoOpticDispersionModelSchott').set('Trefsco', '20[degC]');
model.material('mat1').propertyGroup('Enu').set('E', '82.0[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.206');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('funcname', 'taui10');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('table', {'2500' '0.665';  ...
'2325' '0.793';  ...
'1970' '0.933';  ...
'1530' '0.992';  ...
'1060' '0.999';  ...
'700' '0.998';  ...
'660' '0.998';  ...
'620' '0.998';  ...
'580' '0.998';  ...
'546' '0.998';  ...
'500' '0.998';  ...
'460' '0.997';  ...
'436' '0.997';  ...
'420' '0.997';  ...
'405' '0.997';  ...
'400' '0.997';  ...
'390' '0.996';  ...
'380' '0.993';  ...
'370' '0.991';  ...
'365' '0.988';  ...
'350' '0.967';  ...
'334' '0.905';  ...
'320' '0.77';  ...
'310' '0.574';  ...
'300' '0.292';  ...
'290' '0.063'});
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('extrap', 'none');
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('InternalTransmittance10').func('int1').set('argunit', {'nm'});
model.material('mat1').propertyGroup('InternalTransmittance10').set('taui10', 'taui10(c_const/freq)');
model.material('mat1').propertyGroup('InternalTransmittance10').addInput('frequency');
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('funcname', 'taui25');
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('table', {'2500' '0.36';  ...
'2325' '0.56';  ...
'1970' '0.84';  ...
'1530' '0.98';  ...
'1060' '0.997';  ...
'700' '0.996';  ...
'660' '0.994';  ...
'620' '0.994';  ...
'580' '0.995';  ...
'546' '0.996';  ...
'500' '0.994';  ...
'460' '0.993';  ...
'436' '0.992';  ...
'420' '0.993';  ...
'405' '0.993';  ...
'400' '0.992';  ...
'390' '0.989';  ...
'380' '0.983';  ...
'370' '0.977';  ...
'365' '0.971';  ...
'350' '0.92';  ...
'334' '0.78';  ...
'320' '0.52';  ...
'310' '0.25';  ...
'300' '0.05'});
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('extrap', 'none');
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('InternalTransmittance25').func('int1').set('argunit', {'nm'});
model.material('mat1').propertyGroup('InternalTransmittance25').set('taui25', 'taui25(c_const/freq)');
model.material('mat1').propertyGroup('InternalTransmittance25').addInput('frequency');
model.material('mat1').selection.named('geom1_pi1_sel1');

model.physics('gop').selection.set([2]);
model.physics('gop').prop('WavelengthDistribution').setIndex('WavelengthDistribution', 'PolychromaticWavelength', 0);
model.physics('gop').prop('MaximumSecondary').setIndex('MaximumSecondary', 0, 0);
model.physics('gop').feature('mp1').set('RefractiveIndexDomains', 'GetDispersionModelFromMaterial');
model.physics('gop').feature('matd1').set('ReleaseReflectedRays', 'Never');
model.physics('gop').create('mir1', 'Mirror', 2);
model.physics('gop').feature('mir1').label('Mirrors');
model.physics('gop').feature('mir1').selection.named('geom1_csel2_bnd');
model.physics('gop').create('wall1', 'Wall', 2);
model.physics('gop').feature('wall1').label('Obstructions');
model.physics('gop').feature('wall1').selection.named('geom1_csel1_bnd');
model.physics('gop').feature('wall1').set('WallCondition', 'Disappear');
model.physics('gop').create('wall2', 'Wall', 2);
model.physics('gop').feature('wall2').label('Image');
model.physics('gop').feature('wall2').selection.named('geom1_pi3_sel1');
model.physics('gop').create('relg1', 'ReleaseGrid', -1);
model.physics('gop').feature('relg1').set('GridType', 'Hexapolar');
model.physics('gop').feature('relg1').set('qcc', {'dx1' 'dy1' 'dz'});
model.physics('gop').feature('relg1').set('rcc', [0 0 1]);
model.physics('gop').feature('relg1').set('Rc', 'P_nom/2');
model.physics('gop').feature('relg1').setIndex('Ncr', 'N_ring', 0);
model.physics('gop').feature('relg1').set('L0', {'vx1' 'vy1' 'vz'});
model.physics('gop').feature('relg1').set('LDistributionFunction', 'ListOfValues');
model.physics('gop').feature('relg1').setIndex('lambda0vals', 'lam1 lam2 lam3', 0);
model.physics('gop').feature.duplicate('relg2', 'relg1');
model.physics('gop').feature('relg2').set('qcc', {'dx2' 'dy2' 'dz'});
model.physics('gop').feature('relg2').set('L0', {'vx2' 'vy2' 'vz'});
model.physics('gop').feature.duplicate('relg3', 'relg2');
model.physics('gop').feature('relg3').set('qcc', {'dx3' 'dy3' 'dz'});
model.physics('gop').feature('relg3').set('L0', {'vx3' 'vy3' 'vz'});

model.mesh('mesh1').autoMeshSize(3);
model.mesh('mesh1').run;

model.study('std1').feature('rtrac').set('timestepspec', 'specifylength');
model.study('std1').feature('rtrac').set('lunit', 'mm');
model.study('std1').feature('rtrac').set('llist', '0 1750');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'rtrac');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'rtrac');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.01,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-5);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', false);
model.sol('sol1').feature('t1').set('storeudot', false);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('control', 'rtrac');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').create('ja1', 'Jacobi');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('t1').feature('fc1').set('ntolfact', 0.1);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.dataset.create('ray1', 'Ray');
model.result.dataset('ray1').set('solution', 'sol1');
model.result.dataset('ray1').set('posdof', {'comp1.qx' 'comp1.qy' 'comp1.qz'});
model.result.dataset('ray1').set('geom', 'geom1');
model.result.dataset('ray1').set('rgeom', 'pgeom_gop');
model.result.dataset('ray1').set('rgeomspec', 'fromphysics');
model.result.dataset('ray1').set('physicsinterface', 'gop');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'ray1');
model.result('pg1').setIndex('looplevel', 2, 0);
model.result('pg1').label('Ray Trajectories (gop)');
model.result('pg1').create('rtrj1', 'RayTrajectories');
model.result('pg1').feature('rtrj1').set('linetype', 'line');
model.result('pg1').feature('rtrj1').create('col1', 'Color');
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 't');
model.result('pg1').feature('rtrj1').create('filt1', 'RayTrajectoriesFilter');
model.result('pg1').run;
model.result('pg1').label('Ray Diagram');
model.result('pg1').set('showlegendsunit', true);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('col1').set('expr', 'at(''last'',gop.rrel)');
model.result('pg1').feature('rtrj1').feature('col1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg1').run;
model.result('pg1').feature('rtrj1').feature('filt1').set('type', 'logical');
model.result('pg1').feature('rtrj1').feature('filt1').set('logicalexpr', 'at(0,atan2(qy,qx)>-pi/2)');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('coloring', 'uniform');
model.result('pg1').feature('surf1').set('color', 'custom');
model.result('pg1').feature('surf1').set('customcolor', [0.21176470816135406 0.5490196347236633 0.7960784435272217]);
model.result('pg1').feature('surf1').create('sel1', 'Selection');
model.result('pg1').feature('surf1').feature('sel1').selection.named('geom1_pi1_sel2');
model.result('pg1').feature('surf1').feature('sel1').selection.set([5 6 7 8 9 11 18 19 22 24]);
model.result('pg1').run;
model.result('pg1').feature('surf1').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').create('surf2', 'Surface');
model.result('pg1').feature('surf2').set('coloring', 'uniform');
model.result('pg1').feature('surf2').set('color', 'gray');
model.result('pg1').feature('surf2').create('sel1', 'Selection');
model.result('pg1').feature('surf2').feature('sel1').selection.named('geom1_csel2_bnd');
model.result('pg1').run;
model.result('pg1').create('surf3', 'Surface');
model.result('pg1').feature('surf3').set('coloring', 'uniform');
model.result('pg1').feature('surf3').set('color', 'custom');
model.result('pg1').feature('surf3').set('customcolor', [0.4117647111415863 0.4117647111415863 0.4117647111415863]);
model.result('pg1').feature('surf3').create('sel1', 'Selection');
model.result('pg1').feature('surf3').feature('sel1').selection.named('geom1_csel1_bnd');
model.result('pg1').run;
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').run;
model.result('pg2').label('Spot Diagram');
model.result('pg2').set('showlegendsunit', true);
model.result('pg2').create('spot1', 'SpotDiagram');
model.result('pg2').feature('spot1').set('origin', 'area');
model.result('pg2').feature('spot1').set('circleactive', true);
model.result('pg2').feature('spot1').set('circleradiusexpr', 'r_Airy');
model.result('pg2').feature('spot1').create('col1', 'Color');
model.result('pg2').run;
model.result('pg2').feature('spot1').feature('col1').set('expr', 'gop.lambda0');
model.result('pg2').feature('spot1').feature('col1').set('unit', 'nm');
model.result('pg2').feature('spot1').feature('col1').set('rangecoloractive', true);
model.result('pg2').feature('spot1').feature('col1').set('rangecolormin', 425);
model.result('pg2').feature('spot1').feature('col1').set('rangecolormax', 675);
model.result('pg2').feature('spot1').feature('col1').set('colortable', 'Spectrum');
model.result('pg2').run;

model.title(['Gregory' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Maksutov Telescope']);

model.description(['The Gregory' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Maksutov telescope is a simple catadioptric telescope comprising a spherical corrector lens and a spherical primary mirror. In this example the corrector lens and mirror are formed using the ' native2unicode(hex2dec({'20' '18'}), 'unicode') 'Spherical Lens 3D' native2unicode(hex2dec({'20' '19'}), 'unicode') ' and ' native2unicode(hex2dec({'20' '18'}), 'unicode') 'Spherical Mirror 3D' native2unicode(hex2dec({'20' '19'}), 'unicode') ' parts respectively from the Ray Optics Module Part Library.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('gregory_maksutov_telescope.mph');

model.modelNode.label('Components');

out = model;
