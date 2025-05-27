function out = model
%
% fda_benchmark_blood_pump_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/Verification_Examples');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Sf', '1/10', 'Scale factor');
model.param.set('z_os_rd', '0.0035', 'Vertical offset for rotating domain');
model.param.set('r_rd', '0.056/2', 'Radius of rotating domain');
model.param.set('r_rd_h', '0.010/2', 'Radius of rotating domain, hub enclosure');
model.param.set('z_wp5', '0.16', 'Vertical offset for the work plane5');
model.param.set('x_wp6', '0.02', 'Normal offset for the work plane6');
model.param.set('x_in', '0.1', 'Inlet pipe length x-direction');
model.param.set('r_h', '0.004', 'Radius of the hub');

model.geom('geom1').geomRep('cadps');
model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'fda_benchmark_blood_pump_rotor_cad_geometry.stp');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run('imp1');
model.geom('geom1').create('sca1', 'Scale');
model.geom('geom1').feature('sca1').selection('input').set({'imp1'});
model.geom('geom1').feature('sca1').set('isotropic', 'Sf');
model.geom('geom1').run('sca1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('sca1', 16);
model.geom('geom1').feature('wp1').set('offset', 'z_os_rd');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'r_rd');
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('specify', 'vertices');
model.geom('geom1').feature('ext1').selection('vertex').set('sca1', 81);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('ext1', 4);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'r_rd_h');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature('ext2').set('specify', 'vertices');
model.geom('geom1').feature('ext2').selection('vertex').set('sca1', 68);
model.geom('geom1').run('ext2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('planetype', 'edgeparallel');
model.geom('geom1').feature('wp3').selection('planaredge').set('sca1', 224);
model.geom('geom1').feature('wp3').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature('c1').set('r', 'r_rd_h');
model.geom('geom1').feature('wp3').geom.feature('c1').set('angle', 90);
model.geom('geom1').feature('wp3').geom.feature('c1').set('pos', {'0' 'r_h'});
model.geom('geom1').feature('wp3').geom.run('c1');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('axistype', '3d');
model.geom('geom1').feature('rev1').set('axis3', [0 0 1]);
model.geom('geom1').run('rev1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'ext1' 'ext2' 'rev1'});
model.geom('geom1').feature('uni1').set('intbnd', false);
model.geom('geom1').run('uni1');
model.geom('geom1').create('imp2', 'Import');
model.geom('geom1').feature('imp2').set('type', 'cad');
model.geom('geom1').feature('imp2').set('repair', false);
model.geom('geom1').feature('imp2').set('importtol', 1.0E-8);
model.geom('geom1').feature('imp2').set('filename', 'fda_benchmark_blood_pump_housing_cad_geometry.stp');
model.geom('geom1').feature('imp2').importData;
model.geom('geom1').defeaturing('Fillets').selection('input').init;
model.geom('geom1').defeaturing('Fillets').selection('input').set({'imp2'});
model.geom('geom1').defeaturing('Fillets').find;
model.geom('geom1').defeaturing('Fillets').set('entsize', 0.1);
model.geom('geom1').defeaturing('Fillets').find;
model.geom('geom1').defeaturing('Fillets').detail.setGroup([1]);
model.geom('geom1').defeaturing('Fillets').delete('dfi1');
model.geom('geom1').create('sca2', 'Scale');
model.geom('geom1').feature('sca2').selection('input').set({'dfi1'});
model.geom('geom1').feature('sca2').set('isotropic', 'Sf');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('fil1', 'Fillet3D');
model.geom('geom1').feature('fil1').set('radius', '0.00004');
model.geom('geom1').feature('fil1').selection('edge').set('sca2', [17 19]);
model.geom('geom1').run('fil1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'fil1' 'uni1'});
model.geom('geom1').feature('dif1').selection('input2').set({'sca1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('planetype', 'edgeparallel');
model.geom('geom1').feature('wp4').selection('planaredge').set('dif1', 129);
model.geom('geom1').run('wp4');
model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('dif1', [1 2]);
model.geom('geom1').run('pard1');
model.geom('geom1').create('wp5', 'WorkPlane');
model.geom('geom1').feature('wp5').set('unite', true);
model.geom('geom1').feature('wp5').set('planetype', 'edgeparallel');
model.geom('geom1').feature('wp5').selection('planaredge').set('pard1', 129);
model.geom('geom1').feature('wp5').set('offset', 'z_wp5');
model.geom('geom1').feature('wp5').set('reverse', true);
model.geom('geom1').run('wp5');
model.geom('geom1').create('pard2', 'PartitionDomains');
model.geom('geom1').feature('pard2').selection('domain').set('pard1', [1 2]);
model.geom('geom1').run('pard2');
model.geom('geom1').create('wp6', 'WorkPlane');
model.geom('geom1').feature('wp6').set('unite', true);
model.geom('geom1').feature('wp6').set('planetype', 'edgeparallel');
model.geom('geom1').feature('wp6').selection('planaredge').set('pard2', 485);
model.geom('geom1').feature('wp6').set('offset', 'x_wp6');
model.geom('geom1').run('wp6');
model.geom('geom1').create('pard3', 'PartitionDomains');
model.geom('geom1').feature('pard3').selection('domain').set('pard2', [1 2]);
model.geom('geom1').run('pard3');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('ext3').set('extrudefrom', 'faces');
model.geom('geom1').feature('ext3').selection('inputface').set('pard3', 213);
model.geom('geom1').feature('ext3').setIndex('distance', 'x_in', 0);
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [18 20 22 23 26 27 28 29 43 48 50 51 54 55 58 59]);
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmf2', 'CompositeFaces');
model.geom('geom1').feature('cmf2').selection('input').set('cmf1', [40 41 42 43 48 49]);
model.geom('geom1').run('cmf2');
model.geom('geom1').create('cmf3', 'CompositeFaces');
model.geom('geom1').feature('cmf3').selection('input').set('cmf2', [68 72 78 95 96 97 102 104 121 129 144 147]);
model.geom('geom1').run('cmf3');
model.geom('geom1').create('cmf4', 'CompositeFaces');
model.geom('geom1').feature('cmf4').selection('input').set('cmf3', [80 87 90 119 123 134]);
model.geom('geom1').run('cmf4');
model.geom('geom1').create('cmf5', 'CompositeFaces');
model.geom('geom1').feature('cmf5').selection('input').set('cmf4', [143 146 148 149 151 155 156 159 160 162 164 165 166 167 168 169]);
model.geom('geom1').run('cmf5');
model.geom('geom1').create('cmf6', 'CompositeFaces');
model.geom('geom1').feature('cmf6').selection('input').set('cmf5', [149 151 152 153 154 155]);
model.geom('geom1').run('cmf6');
model.geom('geom1').create('cmf7', 'CompositeFaces');
model.geom('geom1').feature('cmf7').selection('input').set('cmf6', [70 72 82 83 89 94 95 97 98 99 117 118 122 126 131 137 138 139]);
model.geom('geom1').run('cmf7');
model.geom('geom1').create('cmf8', 'CompositeFaces');
model.geom('geom1').feature('cmf8').selection('input').set('cmf7', [83 86 88 114 116 123]);
model.geom('geom1').run('cmf8');
model.geom('geom1').create('cmf9', 'CompositeFaces');
model.geom('geom1').feature('cmf9').selection('input').set('cmf8', [10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 30 32 39 40 41 42 43 44 45 46 47 60 65 66 67 68 69 70 71 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 148 149 153 154 155 156 157 158 159 160 161]);
model.geom('geom1').run('cmf9');
model.geom('geom1').create('cmf10', 'CompositeFaces');
model.geom('geom1').feature('cmf10').selection('input').set('cmf9', [13 14 15 16 48]);
model.geom('geom1').run('cmf10');
model.geom('geom1').create('cmf11', 'CompositeFaces');
model.geom('geom1').feature('cmf11').selection('input').set('cmf10', [40 41 44]);

model.title([]);

model.description('');

model.label('fda_benchmark_blood_pump_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
