function out = model
%
% turbocharger_transient_analysis.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Rotordynamics_Module/Automotive_and_Aerospace');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rotbm', 'BeamRotor', 'geom1');
model.physics('rotbm').model('comp1');
model.physics.create('hdb', 'HydrodynamicBearing', 'geom1');
model.physics('hdb').model('comp1');

model.multiphysics.create('brbc1', 'BeamRotorBearingCoupling', 'geom1', 2);
model.multiphysics('brbc1').set('BeamRotor_physics', 'rotbm');
model.multiphysics('brbc1').set('Bearing_physics', 'hdb');
model.multiphysics('brbc1').selection.all;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/rotbm', true);
model.study('std1').feature('time').setSolveFor('/physics/hdb', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/brbc1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Ow', '8000[rpm]', 'Rotor angular speed');
model.param.set('Er', '205[GPa]', 'Young''s modulus of rotor');
model.param.set('nur', '0.3', 'Poisson''s ratio of rotor');
model.param.set('rhor', '7800', 'Rotor density');
model.param.set('L', '0.15[m]', 'Length of the rotor');
model.param.set('x1', '0[m]', 'Left-end coordinate of the shaft');
model.param.set('x2', '0.1*L', 'Coordinate of the turbine');
model.param.set('x3', '0.3*L', 'Coordinate of the left bearing');
model.param.set('x4', '0.7*L', 'Coordinate of the right bearing');
model.param.set('x5', '0.9*L', 'Coordinate of the compressor');
model.param.set('x6', 'L', 'Right-end coordinate of the rotor');
model.param.set('m_t', '1.4[kg]', 'Turbine mass');
model.param.set('Id_t', '6.3e-4[kg*m^2]', 'Diametral moment of inertia of turbine');
model.param.set('Ip_t', '1.26e-5[kg*m^2]', 'Polar moment of inertia of turbine');
model.param.set('m_c', '1.0[kg]', 'Compressor mass');
model.param.set('Id_c', '4.5e-4[kg*m^2]', 'Diametral moment of inertia of compressor');
model.param.set('Ip_c', '9e-4[kg*m^2]', 'Polar moment of inertia of compressor');
model.param.create('par2');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('m_r', '0.02[kg]', 'Ring mass');
model.param('par2').set('R_o', '9e-3[m]', 'Ring outer radius');
model.param('par2').set('R_i', '6e-3[m]', 'Ring inner radius');
model.param('par2').set('Ip_r', '0.5*m_r*(R_o^2+R_i^2)', 'Polar moment of inertia of the ring');
model.param('par2').set('Id_r', '0.5*Ip_r+m_r*Lb^2/12', 'Diametral moment of inertia of the ring');
model.param('par2').set('C_o', '8e-5[m]', 'Outer film clearance');
model.param('par2').set('C_i', '2e-5[m]', 'Inner film clearance');
model.param('par2').set('mu0', '0.06[Pa*s]', 'Lubricant viscosity');
model.param('par2').set('Lb', '0.01[m]', 'Bearing length');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', 'x1 x2 x3 L/2');
model.geom('geom1').feature('pol1').set('y', 0);
model.geom('geom1').feature('pol1').set('z', 0);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Rotor');
model.geom('geom1').feature('pol1').set('contributeto', 'csel1');
model.geom('geom1').run('pol1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('type', 'surface');
model.geom('geom1').feature('cyl1').set('r', 'R_o');
model.geom('geom1').feature('cyl1').set('h', 'Lb');
model.geom('geom1').feature('cyl1').set('pos', {'x3-Lb/2' '0' '0'});
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Bearing Surface');
model.geom('geom1').feature('cyl1').set('contributeto', 'csel2');
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('r', 'R_i');
model.geom('geom1').feature.duplicate('cyl3', 'cyl1');
model.geom('geom1').feature('cyl3').set('h', '0.3*Lb');
model.geom('geom1').feature('cyl3').set('pos', {'x3-0.15*Lb' '0' '0'});
model.geom('geom1').feature.duplicate('cyl4', 'cyl3');
model.geom('geom1').feature('cyl4').set('r', 'R_i');
model.geom('geom1').run('cyl4');
model.geom('geom1').create('cyl5', 'Cylinder');
model.geom('geom1').feature('cyl5').set('r', '0.1*R_o');
model.geom('geom1').feature('cyl5').set('h', '2.5*(R_o-R_i)');
model.geom('geom1').feature('cyl5').set('pos', {'x3' '0' '0.5*R_i'});
model.geom('geom1').feature('cyl5').set('contributeto', 'csel2');
model.geom('geom1').run('cyl5');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cyl5'});
model.geom('geom1').feature('rot1').set('rot', 'range(0,60,300)');
model.geom('geom1').feature('rot1').set('axistype', 'x');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Auxiliary cylinders');
model.geom('geom1').feature('rot1').set('contributeto', 'csel3');
model.geom('geom1').run('rot1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('csel2');
model.geom('geom1').feature('uni1').set('keep', true);
model.geom('geom1').run('uni1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').named('csel3');
model.geom('geom1').run('del1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'cyl1' 'cyl2' 'cyl3' 'cyl4' 'del1' 'pol1'});
model.geom('geom1').feature('mir1').set('pos', {'L/2' '0' '0'});
model.geom('geom1').feature('mir1').set('axis', [1 0 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').runPre('mir1');
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').geom(2);
model.selection('sel1').set([4]);
model.selection('sel1').set('groupcontang', true);
model.selection('sel1').label('Inner film, bearing 1');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Outer film, bearing 1');
model.selection('sel2').geom(2);
model.selection('sel2').set([2]);
model.selection('sel2').set('groupcontang', true);
model.selection.duplicate('sel3', 'sel1');
model.selection('sel3').label('Inner film, bearing 2');
model.selection('sel3').remove([3 4 6 7 11 12 14 15 19 20 23 24 25 26 29 30 35 36 38 39]);
model.selection('sel3').add([43 44 46 47 51 52 54 55 59 60 63 64 65 66 69 70 75 76 78 79]);
model.selection.duplicate('sel4', 'sel2');
model.selection('sel4').label('Outer film, bearing 2');
model.selection('sel4').remove([1 2 5 8 9 10 13 16 17 18 21 22 27 28 31 32 33 34 37 40]);
model.selection('sel4').add([41 42 45 48 49 50 53 56 57 58 61 62 67 68 71 72 73 74 77 80]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel1' 'sel2'});
model.selection('uni1').label('Bearing 1');
model.selection.duplicate('uni2', 'uni1');
model.selection('uni2').label('Bearing 2');
model.selection('uni2').set('input', {'sel3' 'sel4'});
model.selection.create('uni3', 'Union');
model.selection('uni3').model('comp1');
model.selection('uni3').set('entitydim', 2);
model.selection('uni3').set('input', {'sel1' 'sel3'});
model.selection('uni3').label('Inner film');
model.selection.duplicate('uni4', 'uni3');
model.selection('uni4').label('Outer film');
model.selection('uni4').set('input', {'sel2' 'sel4'});
model.selection.create('cyl1', 'Cylinder');
model.selection('cyl1').model('comp1');
model.selection('cyl1').set('entitydim', 2);
model.selection('cyl1').set('axistype', 'x');
model.selection('cyl1').set('r', '0.5*(R_i+R_o)');
model.selection('cyl1').set('rin', '0.5*R_i');
model.selection('cyl1').set('top', '0.11*R_o');
model.selection('cyl1').set('bottom', '-0.11*R_o');
model.selection('cyl1').set('pos', {'x3' '0' '0'});
model.selection('cyl1').set('condition', 'inside');
model.selection('cyl1').label('Channel, inner film, bearing 1');
model.selection.duplicate('cyl2', 'cyl1');
model.selection('cyl2').set('r', '1.1*R_o');
model.selection('cyl2').set('rin', '0.5*(R_i+R_o)');
model.selection('cyl2').label('Channel, outer film, bearing 1');
model.selection.duplicate('cyl3', 'cyl1');
model.selection.duplicate('cyl4', 'cyl2');
model.selection('cyl3').set('pos', {'x4' '0' '0'});
model.selection('cyl3').label('Channel, inner film, bearing 2');
model.selection('cyl4').label('Channel, outer film, bearing 2');
model.selection('cyl4').set('pos', {'x4' '0' '0'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').selection.geom('geom1', 1);
model.material('mat1').selection.named('geom1_csel1_edg');
model.material('mat1').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat1').propertyGroup('Enu').set('E', {'Er'});
model.material('mat1').propertyGroup('Enu').set('nu', {'nur'});
model.material('mat1').propertyGroup('def').set('density', {'rhor'});

model.physics('rotbm').selection.named('geom1_csel1_edg');
model.physics('rotbm').prop('RotorProperties').set('rpt', 'Ow');
model.physics('rotbm').prop('Results').set('createUndefGeom', false);
model.physics('rotbm').feature('rcs1').set('do_circ', '2*R_i');
model.physics('rotbm').create('disk1', 'Disk', 0);
model.physics('rotbm').feature('disk1').label('Disk: Turbine');
model.physics('rotbm').feature('disk1').set('COM', 'Relative');
model.physics('rotbm').feature('disk1').set('zr', '1e-4*R_i');
model.physics('rotbm').feature('disk1').set('mass', 'm_t');
model.physics('rotbm').feature('disk1').set('Ip', 'Ip_t');
model.physics('rotbm').feature('disk1').set('Id', 'Id_t');
model.physics('rotbm').feature('disk1').selection.set([2]);
model.physics('rotbm').feature.duplicate('disk2', 'disk1');
model.physics('rotbm').feature('disk2').label('Disk: Compressor');
model.physics('rotbm').feature('disk2').selection.set([166]);
model.physics('rotbm').feature('disk2').set('mass', 'm_c');
model.physics('rotbm').feature('disk2').set('Ip', 'Ip_c');
model.physics('rotbm').feature('disk2').set('Id', 'Id_c');
model.physics('rotbm').create('gr1', 'Gravity', 1);
model.physics('hdb').create('frb1', 'FloatingRingBearing', 2);
model.physics('hdb').feature('frb1').selection.named('uni1');
model.physics('hdb').feature('frb1').set('mr', 'm_r');
model.physics('hdb').feature('frb1').set('Ir', {'Ip_r' '0' '0' '0' 'Id_r' '0' '0' '0' 'Id_r'});
model.physics('hdb').feature('frb1').set('BearingCenterType', 'fromGeom');
model.physics('hdb').feature('frb1').set('mure_mat', 'userdef');
model.physics('hdb').feature('frb1').set('mure', 'mu0');
model.physics('hdb').feature('frb1').set('rho_mat', 'userdef');
model.physics('hdb').feature('frb1').feature('if1').selection.named('sel1');
model.physics('hdb').feature('frb1').feature('if1').set('C', 'C_i');
model.physics('hdb').feature('frb1').feature('of1').selection.named('sel2');
model.physics('hdb').feature('frb1').feature('of1').set('C', 'C_o');
model.physics('hdb').feature('frb1').create('fc1', 'InnerOuterFilmConnection', -1);
model.physics('hdb').feature('frb1').feature('fc1').selection('ChannelInner').named('cyl1');
model.physics('hdb').feature('frb1').feature('fc1').selection('ChannelOuter').named('cyl2');
model.physics('hdb').feature.duplicate('frb2', 'frb1');
model.physics('hdb').feature('frb2').selection.named('uni2');
model.physics('hdb').feature('frb2').feature('if1').selection.named('sel3');
model.physics('hdb').feature('frb2').feature('of1').selection.named('sel4');
model.physics('hdb').feature('frb2').feature('fc1').selection('ChannelInner').named('cyl3');
model.physics('hdb').feature('frb2').feature('fc1').selection('ChannelOuter').named('cyl4');

model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').geom(1);
model.selection('sel5').label('Bearing Outer Edges');
model.selection('sel5').set([3 4 6 7 9 11 13 15 108 109 110 111 112 113 114 115 117 118 120 121 123 125 127 129 222 223 224 225 226 227 228 229]);

model.multiphysics('brbc1').selection.named('sel1');
model.multiphysics.duplicate('brbc2', 'brbc1');
model.multiphysics('brbc2').selection.named('sel3');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('geom1_csel1_edg');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').selection.set([1 230]);
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').feature('edg1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis2').selection.set([2 75 116 189]);
model.mesh('mesh1').feature('edg1').feature('dis2').set('numelem', 20);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([1 2 3 4 5 6 7 8 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 73 74 75 76 77 78 79 80]);
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([3 4 6 7 9 11 13 15 108 109 110 111 112 113 114 115 116 117 118 120 121 123 125 127 129 222 223 224 225 226 227 228 229]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 15);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.set([14 16 103 105 131 132 220 221]);
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 2);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').run;
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.remaining;
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5e-4,0.1)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_rotbm_phi').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scaleval', '1000000');
model.sol('sol1').feature('v1').feature('comp1_rotbm_phi').set('scaleval', '1e-2');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.1521446679972716');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5e-4,0.1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'intermediate');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('rhoinf', 0.75);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('timemethod', 'bdf');
model.sol('sol1').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-5');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 201, 0);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'rotbm.mises'});
model.result('pg1').feature('line1').set('threshold', 'manual');
model.result('pg1').feature('line1').set('thresholdvalue', 0.2);
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('colortabletrans', 'none');
model.result('pg1').feature('line1').set('colorscalemode', 'linear');
model.result('pg1').label('Stress (rotbm)');
model.result('pg1').feature('line1').set('colortable', 'Rainbow');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', 'rotbm.re');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('tuberadiusscale', 1);
model.result('pg1').feature('line1').set('tubeendcaps', false);
model.result('pg1').feature('line1').create('def', 'Deform');
model.result('pg1').feature('line1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('line1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Fluid Pressure (hdb)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 201, 0);
model.result('pg2').set('defaultPlotID', 'fluidPressure');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'pfilm');
model.result('pg2').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('expr', 'pfilm');
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').set('smooth', 'internal');
model.result('pg2').feature('con1').set('inherittubescale', false);
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature.copy('line1', 'pg1/line1');
model.result('pg2').run;
model.result('pg2').feature('line1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg2').feature('line1').set('tuberadiusscale', 0.4);
model.result('pg2').run;
model.result('pg2').feature('line1').feature('def').set('scaleactive', true);
model.result('pg2').feature('line1').feature('def').set('scale', 50);
model.result.setOnlyPlotWhenRequested(true);
model.result('pg2').feature('surf1').create('def1', 'Deform');
model.result('pg2').feature('surf1').feature('def1').set('expr', {'hdb.uRax' 'hdb.uRay' 'w'});
model.result('pg2').feature('surf1').feature('def1').setIndex('expr', 'hdb.uRaz', 2);
model.result('pg2').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg2').feature('con1').feature.copy('def1', 'pg2/surf1/def1');
model.result('pg2').set('legendpos', 'rightdouble');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').setIndex('expr', 'hdb.frb1.Omegar', 0);
model.result('pg3').feature('glob1').setIndex('unit', 'rad/s', 0);
model.result('pg3').feature('glob1').setIndex('descr', 'Ring speed, Bearing 1', 0);
model.result('pg3').feature('glob1').setIndex('expr', 'hdb.frb2.Omegar', 1);
model.result('pg3').feature('glob1').setIndex('unit', 'rad/s', 1);
model.result('pg3').feature('glob1').setIndex('descr', 'Ring speed, Bearing 2', 1);
model.result('pg3').run;
model.result('pg3').label('Ring Speed');
model.result('pg3').set('legendpos', 'upperleft');
model.result('pg3').set('titletype', 'label');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').label('Ring Torque');
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Torque (N*m)');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'hdb.frb2.Mr_inx'});
model.result('pg4').feature('glob1').set('descr', {'Fluid moment on ring, inner film, x-component'});
model.result('pg4').feature('glob1').set('unit', {'N*m'});
model.result('pg4').feature('glob1').set('expr', {'hdb.frb2.Mr_inx' 'hdb.frb2.Mr_outx'});
model.result('pg4').feature('glob1').set('descr', {'Fluid moment on ring, inner film, x-component' 'Fluid moment on ring, outer film, x-component'});
model.result('pg4').feature('glob1').setIndex('expr', 'hdb.frb2.Mrx', 2);
model.result('pg4').feature('glob1').setIndex('unit', 'N*m', 2);
model.result('pg4').feature('glob1').setIndex('descr', 'Moment on ring, x-component', 2);
model.result('pg4').run;
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').label('Rotor Orbit in Ring');
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Scaled y displacement');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Scaled z displacement');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'hdb.frb1.uJRz_rel'});
model.result('pg5').feature('glob1').set('descr', {'Journal displacement relative to ring (scaled), z-component'});
model.result('pg5').feature('glob1').set('unit', {'1'});
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'hdb.frb1.uJRy_rel');
model.result('pg5').feature('glob1').set('xdatadescr', 'Journal displacement relative to ring (scaled), y-component');
model.result('pg5').feature('glob1').set('legendmethod', 'manual');
model.result('pg5').feature('glob1').setIndex('legends', 'Bearing 1', 0);
model.result('pg5').feature.duplicate('glob2', 'glob1');
model.result('pg5').feature('glob2').set('expr', {'hdb.frb2.uJRz_rel'});
model.result('pg5').feature('glob2').set('descr', {'Journal displacement relative to ring (scaled), z-component'});
model.result('pg5').feature('glob2').set('unit', {'1'});
model.result('pg5').feature('glob2').set('xdataexpr', 'hdb.frb2.uJRy_rel');
model.result('pg5').feature('glob2').set('xdatadescr', 'Journal displacement relative to ring (scaled), y-component');
model.result('pg5').feature('glob2').setIndex('legends', 'Bearing 2', 0);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').label('Ring Orbit');
model.result('pg6').set('titletype', 'label');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Scaled y displacement');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Scaled z displacement');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('expr', {'hdb.frb1.uRBz_rel'});
model.result('pg6').feature('glob1').set('descr', {'Ring displacement relative to bearing (scaled), z-component'});
model.result('pg6').feature('glob1').set('unit', {'1'});
model.result('pg6').feature('glob1').set('xdataexpr', 'hdb.frb1.uRBy_rel');
model.result('pg6').feature('glob1').set('xdatadescr', 'Ring displacement relative to bearing (scaled), y-component');
model.result('pg6').feature('glob1').set('xdatadescractive', true);
model.result('pg6').feature('glob1').set('legendmethod', 'manual');
model.result('pg6').feature('glob1').setIndex('legends', 'Bearing 1', 0);
model.result('pg6').feature.duplicate('glob2', 'glob1');
model.result('pg6').feature('glob2').set('expr', {'hdb.frb2.uRBz_rel'});
model.result('pg6').feature('glob2').set('descr', {'Ring displacement relative to bearing (scaled), z-component'});
model.result('pg6').feature('glob2').set('unit', {'1'});
model.result('pg6').feature('glob2').set('xdataexpr', 'hdb.frb2.uRBy_rel');
model.result('pg6').feature('glob2').setIndex('legends', 'Bearing 2', 0);
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Flow rate through channel 1');
model.result('pg7').label('Flow rate in Channel');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Flow Rate in Channel (kg/s)');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('markerpos', 'datapoints');
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg7').feature('glob1').setIndex('expr', 'hdb.frb1.Qi1', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'kg/s', 0);
model.result('pg7').feature('glob1').setIndex('descr', 'Bearing 1', 0);
model.result('pg7').feature('glob1').setIndex('expr', 'hdb.frb2.Qi1', 1);
model.result('pg7').feature('glob1').setIndex('unit', 'kg/s', 1);
model.result('pg7').feature('glob1').setIndex('descr', 'Bearing 2', 1);
model.result('pg7').feature('glob1').set('linewidth', 3);
model.result('pg7').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').set('plotgroup', 'pg2');
model.result.export('anim1').set('maxframes', 100);
model.result.export('anim1').run;
model.result('pg2').run;

model.title('Turbocharger Supported on Floating Ring Bearings');

model.description(['In this model, a turbocharger supported on two floating ring bearings is studied. The film forces on the ring cause it to rotate axially within the bearing. In steady state, the ring rotates at a constant angular speed, and the torque on the ring due to the inner and outer films are balanced.' newline  newline 'The Beam Rotor interface is used to model the turbocharger rotor, which is coupled with the floating ring bearing through multiphysics coupling features. The inner and outer films in the floating ring bearings are connected through six channels in the ring. The results include stress in the rotor, pressure distribution in the bearing, speed variation of the ring, total moment on the ring, and flow rate through ring channels.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('turbocharger_transient_analysis.mph');

model.modelNode.label('Components');

out = model;
