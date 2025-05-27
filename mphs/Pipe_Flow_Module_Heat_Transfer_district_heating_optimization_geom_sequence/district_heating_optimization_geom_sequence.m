function out = model
%
% district_heating_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Heat_Transfer');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Geometrical Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('W', '25[m]', 'x length');
model.param.set('L', '40[m]', 'y length');
model.param.set('Lz', '10[m]', 'Radiator length');
model.param.set('nxBlock', '4', 'Consumers per block');
model.param.set('nyBlock', '4', 'Consumer per block');
model.param.set('nxBlocks', '5', 'Blocks');
model.param.set('nyBlocks', '6', 'Blocks');
model.param.set('producer1x', '0[m]', 'Producer 1 x-coordinate');
model.param.set('producer1y', '0[m]', 'Producer 1 y-coordinate');
model.param.set('producer2x', 'L*nxBlock*ceil(nxBlocks/2)', 'Producer 2 x-coordinate');
model.param.set('producer2y', 'W*nyBlock*nyBlocks', 'Producer 2 y-coordinate');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').label('Block');
model.geom('geom1').feature('pol1').set('type', 'closed');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'nyBlock*W', 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 2);
model.geom('geom1').feature('pol1').setIndex('table', 'nxBlock*L', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'nyBlock*W', 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 2);
model.geom('geom1').feature('pol1').setIndex('table', 'nxBlock*L', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 0, 3, 2);
model.geom('geom1').feature('pol1').set('selresult', true);
model.geom('geom1').run('pol1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').named('pol1');
model.geom('geom1').feature('mov1').set('keep', true);
model.geom('geom1').feature('mov1').set('displz', 'Lz');
model.geom('geom1').run('mov1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').label('Consumer 1');
model.geom('geom1').feature('pol2').setIndex('table', 'L/2', 0, 0);
model.geom('geom1').feature('pol2').setIndex('table', 0, 0, 1);
model.geom('geom1').feature('pol2').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol2').setIndex('table', 'L/2', 1, 0);
model.geom('geom1').feature('pol2').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol2').setIndex('table', 'Lz', 1, 2);
model.geom('geom1').feature('pol2').set('selresult', true);
model.geom('geom1').feature.duplicate('pol3', 'pol2');
model.geom('geom1').feature('pol3').label('Consumer 2');
model.geom('geom1').feature('pol3').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol3').setIndex('table', '1.5*W', 0, 1);
model.geom('geom1').feature('pol3').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol3').setIndex('table', 0, 1, 0);
model.geom('geom1').feature('pol3').setIndex('table', '1.5*W', 1, 1);
model.geom('geom1').feature('pol3').setIndex('table', 'Lz', 1, 2);
model.geom('geom1').run('pol3');
model.geom('geom1').create('arr1', 'Array');
model.geom('geom1').feature('arr1').selection('input').named('pol2');
model.geom('geom1').feature('arr1').set('fullsize', {'nxBlock' '2' '1'});
model.geom('geom1').feature('arr1').set('displ', {'L' 'nyBlock*W' '0'});
model.geom('geom1').run('arr1');
model.geom('geom1').create('arr2', 'Array');
model.geom('geom1').feature('arr2').selection('input').named('pol3');
model.geom('geom1').feature('arr2').set('fullsize', {'2' 'nyBlock-2' '1'});
model.geom('geom1').feature('arr2').set('displ', {'nxBlock*L' 'W' '0'});
model.geom('geom1').run('arr2');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Block+Consumers');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'pol1' 'pol2' 'pol3'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('arr3', 'Array');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'pol1' 'pol2' 'pol3'});
model.geom('geom1').runPre('arr3');
model.geom('geom1').feature('arr3').selection('input').named('unisel1');
model.geom('geom1').feature('arr3').set('fullsize', {'nxBlocks' 'nyBlocks' '1'});
model.geom('geom1').feature('arr3').set('displ', {'nxBlock*L' 'nyBlock*W' '0'});
model.geom('geom1').run('arr3');
model.geom('geom1').feature.duplicate('pol4', 'pol3');
model.geom('geom1').feature('pol4').label('Inlet 1 Line');
model.geom('geom1').feature('pol4').setIndex('table', 'producer1x', 0, 0);
model.geom('geom1').feature('pol4').setIndex('table', 'producer1y', 0, 1);
model.geom('geom1').feature('pol4').setIndex('table', 'producer1x', 1, 0);
model.geom('geom1').feature('pol4').setIndex('table', 'producer1y', 1, 1);
model.geom('geom1').feature('pol4').setIndex('table', 'Lz/3', 1, 2);
model.geom('geom1').feature.duplicate('pol5', 'pol4');
model.geom('geom1').feature('pol5').label('Outlet 1 Line');
model.geom('geom1').feature('pol5').setIndex('table', 'Lz', 0, 2);
model.geom('geom1').feature('pol5').setIndex('table', '2*Lz/3', 1, 2);
model.geom('geom1').feature.duplicate('pol6', 'pol5');
model.geom('geom1').feature('pol6').label('Outlet 2 Line');
model.geom('geom1').feature('pol6').setIndex('table', 'producer2x', 0, 0);
model.geom('geom1').feature('pol6').setIndex('table', 'producer2y', 0, 1);
model.geom('geom1').feature('pol6').setIndex('table', 'producer2x', 1, 0);
model.geom('geom1').feature('pol6').setIndex('table', 'producer2y', 1, 1);
model.geom('geom1').feature.duplicate('pol7', 'pol6');
model.geom('geom1').feature('pol7').label('Inlet 2 Line');
model.geom('geom1').feature('pol7').setIndex('table', 0, 0, 2);
model.geom('geom1').feature('pol7').setIndex('table', 'Lz/3', 1, 2);
model.geom('geom1').run('fin');
model.geom('geom1').create('ballsel1', 'BallSelection');
model.geom('geom1').feature('ballsel1').label('Inlet 1');
model.geom('geom1').feature('ballsel1').set('entitydim', 0);
model.geom('geom1').feature('ballsel1').set('posx', 'producer1x');
model.geom('geom1').feature('ballsel1').set('posy', 'producer1y');
model.geom('geom1').feature('ballsel1').set('posz', 'Lz/3');
model.geom('geom1').feature('ballsel1').set('r', 'Lz/100');
model.geom('geom1').feature('ballsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('ballsel2', 'ballsel1');
model.geom('geom1').feature('ballsel2').label('Outlet 1');
model.geom('geom1').feature('ballsel2').set('posz', '2*Lz/3');
model.geom('geom1').feature.duplicate('ballsel3', 'ballsel2');
model.geom('geom1').feature('ballsel3').label('Outlet 2');
model.geom('geom1').feature('ballsel3').set('posx', 'producer2x');
model.geom('geom1').feature('ballsel3').set('posy', 'producer2y');
model.geom('geom1').feature.duplicate('ballsel4', 'ballsel3');
model.geom('geom1').feature('ballsel4').label('Inlet 2');
model.geom('geom1').feature('ballsel4').set('posz', 'Lz/3');
model.geom('geom1').run('ballsel4');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Consumers');
model.geom('geom1').feature('unisel2').set('entitydim', 1);
model.geom('geom1').feature('unisel2').set('input', {'pol2' 'pol3'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Hot Flow');
model.geom('geom1').feature('boxsel1').set('entitydim', 1);
model.geom('geom1').feature('boxsel1').set('zmax', 'Lz/100');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').feature.duplicate('boxsel2', 'boxsel1');
model.geom('geom1').feature('boxsel2').label('Cold Flow');
model.geom('geom1').feature('boxsel2').set('zmax', Inf);
model.geom('geom1').feature('boxsel2').set('zmin', 'Lz*99/100');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').feature('adjsel1').label('Consumer Points');
model.geom('geom1').feature('adjsel1').set('entitydim', 1);
model.geom('geom1').feature('adjsel1').set('outputdim', 0);
model.geom('geom1').feature('adjsel1').set('input', {'unisel2'});
model.geom('geom1').run('adjsel1');
model.geom('geom1').feature.duplicate('boxsel3', 'boxsel1');
model.geom('geom1').feature('boxsel3').label('Consumer Hot Points');
model.geom('geom1').feature('boxsel3').set('entitydim', 0);
model.geom('geom1').feature('boxsel3').set('inputent', 'selections');
model.geom('geom1').feature('boxsel3').set('input', {'pol2' 'pol3'});
model.geom('geom1').run('boxsel3');
model.geom('geom1').create('unisel3', 'UnionSelection');
model.geom('geom1').feature('unisel3').label('Inlets+Outlets');
model.geom('geom1').feature('unisel3').set('entitydim', 1);
model.geom('geom1').feature('unisel3').set('input', {'pol4' 'pol5' 'pol6' 'pol7'});

model.title([]);

model.description('');

model.label('district_heating_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
