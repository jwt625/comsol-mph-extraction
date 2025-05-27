function out = model
%
% electronic_enclosure_cooling_geom.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Power_Electronics_and_Electronic_Cooling');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransferInSolidsAndFluids', 'geom1');
model.physics('ht').model('comp1');
model.physics('ht').prop('ShapeProperty').set('order_temperature', '1');
model.physics.create('spf', 'TurbulentFlowAlgebraicYplus', 'geom1');
model.physics('spf').model('comp1');
model.physics('spf').prop('AdvancedSettingProperty').set('UsePseudoTime', '1');
model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'WeaklyCompressible');

model.multiphysics.create('nitf1', 'NonIsothermalFlow', 'geom1', 3);
model.multiphysics('nitf1').set('Fluid_physics', 'spf');
model.multiphysics('nitf1').set('Heat_physics', 'ht');

model.study.create('std1');
model.study('std1').create('wdi', 'WallDistanceInitialization');
model.study('std1').feature('wdi').set('solnum', 'auto');
model.study('std1').feature('wdi').set('notsolnum', 'auto');
model.study('std1').feature('wdi').set('outputmap', {});
model.study('std1').feature('wdi').set('ngenAUX', '1');
model.study('std1').feature('wdi').set('goalngenAUX', '1');
model.study('std1').feature('wdi').set('ngenAUX', '1');
model.study('std1').feature('wdi').set('goalngenAUX', '1');
model.study('std1').feature('wdi').setSolveFor('/physics/ht', true);
model.study('std1').feature('wdi').setSolveFor('/physics/spf', true);
model.study('std1').feature('wdi').setSolveFor('/multiphysics/nitf1', true);
model.study('std1').feature('wdi').setSolveFor('/physics/ht', false);
model.study('std1').feature('wdi').setSolveFor('/multiphysics/nitf1', false);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);
model.study('std1').feature('stat').setSolveFor('/physics/spf', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/nitf1', true);

model.geom('geom1').lengthUnit('cm');

model.param.set('OR', '0.4');
model.param.descr('OR', 'Opening ratio of the grille');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'electronic_enclosure_cooling.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').runPre('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');

model.geom('geom1').run;

model.selection('sel1').label('Air');
model.selection('sel1').set([1]);

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom(2);
model.view('view1').hideEntities('hide1').add([1 2 4 41 776]);

model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Plastic');
model.selection('sel2').set([6 7 10 11 14 20 21 22 25 26 30 37 38 41 42 45 46]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').label('Fins');
model.selection('sel3').geom(2);
model.selection('sel3').set([142 143 144 145 146 147 148 149 150 151 152 153 175 176 177 178 179 180 181 182 183 184 185 186 292 322 378 441 495 529 636 651 666 677]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').label('Enclosure Sides');
model.selection('sel4').geom(2);
model.selection('sel4').set([1 2 4 41 776]);
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Aluminum Boundaries');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel3' 'sel4'});
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').label('Transformer Shell');
model.selection('sel5').set([3 8 9 18 23 24 34 39 40]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').label('Small Transformer Coils');
model.selection('sel6').set([12 27]);
model.selection.create('sel7', 'Explicit');
model.selection('sel7').model('comp1');
model.selection('sel7').label('Large Transformer Coil');
model.selection('sel7').set([43]);
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').label('Transformer Coils');
model.selection('uni2').set('input', {'sel6' 'sel7'});
model.selection.create('sel8', 'Explicit');
model.selection('sel8').model('comp1');
model.selection('sel8').label('Inductors');
model.selection('sel8').set([5 19 33]);
model.selection.create('uni3', 'Union');
model.selection('uni3').model('comp1');
model.selection('uni3').label('Steel Parts');
model.selection('uni3').set('input', {'sel5' 'sel8'});
model.selection.create('sel9', 'Explicit');
model.selection('sel9').model('comp1');
model.selection('sel9').label('Large Capacitors');
model.selection('sel9').set([17 48]);
model.selection.create('sel10', 'Explicit');
model.selection('sel10').model('comp1');
model.selection('sel10').label('Medium Capacitors');
model.selection('sel10').set([4 15 29 35 44 50]);
model.selection.create('sel11', 'Explicit');
model.selection('sel11').model('comp1');
model.selection('sel11').label('Small Capacitors');
model.selection('sel11').set([2 13 31 36]);
model.selection.create('uni4', 'Union');
model.selection('uni4').model('comp1');
model.selection('uni4').label('Capacitors');
model.selection('uni4').set('input', {'sel9' 'sel10' 'sel11'});
model.selection.create('sel12', 'Explicit');
model.selection('sel12').model('comp1');
model.selection('sel12').label('Transistors Silicon Cores');
model.selection('sel12').set([16 28 32 47 49]);
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Copper Layers');
model.selection('adj1').set('input', {'sel8'});
model.selection.create('sel13', 'Explicit');
model.selection('sel13').model('comp1');
model.selection('sel13').label('Grille');
model.selection('sel13').geom(2);
model.selection('sel13').set([777]);
model.selection.create('sel14', 'Explicit');
model.selection('sel14').model('comp1');
model.selection('sel14').label('Fan');
model.selection('sel14').geom(2);
model.selection('sel14').set([87]);
model.selection.create('sel15', 'Explicit');
model.selection('sel15').model('comp1');
model.selection('sel15').label('Circuit Board');
model.selection('sel15').geom(2);
model.selection('sel15').set([3]);
model.selection('sel15').set('groupcontang', true);
model.selection.create('uni5', 'Union');
model.selection('uni5').model('comp1');
model.selection('uni5').label('Conductive Layers');
model.selection('uni5').set('entitydim', 2);
model.selection('uni5').set('input', {'uni1' 'adj1' 'sel15'});
model.selection.create('sel16', 'Explicit');
model.selection('sel16').model('comp1');
model.selection('sel16').label('Wire Group Surface');
model.selection('sel16').geom(2);
model.selection('sel16').set([538 539 556 557 763 764 765 766 767 768 769 770 771 772 773 774]);
model.selection.create('sel17', 'Explicit');
model.selection('sel17').model('comp1');
model.selection('sel17').label('Small Wire Surface');
model.selection('sel17').geom(2);
model.selection('sel17').set([82 83 84 85]);
model.selection.create('adj2', 'Adjacent');
model.selection('adj2').model('comp1');
model.selection('adj2').label('Component Boundaries');
model.selection('adj2').set('input', {'sel2' 'uni2' 'uni3' 'uni4' 'sel12'});
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Heat Exchange Surface');
model.selection('dif1').set('entitydim', 2);
model.selection('dif1').set('add', {'sel3' 'adj2'});
model.selection('dif1').set('subtract', {'sel15'});
model.selection.create('sel18', 'Explicit');
model.selection('sel18').model('comp1');
model.selection('sel18').label('Curved Area');
model.selection('sel18').geom(2);
model.selection('sel18').set([5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 86 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135]);
model.selection.create('uni6', 'Union');
model.selection('uni6').model('comp1');
model.selection('uni6').label('Walls');
model.selection('uni6').set('entitydim', 2);
model.selection('uni6').set('input', {'uni5' 'sel16' 'sel17' 'dif1' 'sel18'});

model.title('Parameterized Electronic Enclosure Geometry');

model.description('This is a template MPH-file containing the physics interfaces and the parameterized geometry for the model Forced Convection Cooling of an Enclosure with Fan and Grille.');

model.label('electronic_enclosure_cooling_geom.mph');

model.modelNode.label('Components');

out = model;
