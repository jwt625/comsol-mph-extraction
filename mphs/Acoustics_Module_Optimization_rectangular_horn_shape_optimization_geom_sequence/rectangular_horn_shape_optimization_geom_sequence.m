function out = model
%
% rectangular_horn_shape_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Optimization');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('f0', 'c0/1/h0', 'Frequency');
model.param.set('c0', '343[m/s]', 'Speed of sound');
model.param.set('R0', '4*h0', 'Evaluation distance');
model.param.set('theta0', '15[deg]', 'Desired rotation of beam');
model.param.set('h0', '0.3[m]', 'Horn height');
model.param.set('w0', 'h0', 'Horn width');
model.param.set('L0', '0.8*h0', 'Horn length');
model.param.set('scaleMax', '0.2', 'Maximum displacement');
model.param.set('Rair', '2*h0', 'Air radius');
model.param.set('V0', '1[V]', 'Driving voltage');
model.param.set('rSpeaker', 'L0/2.2', 'Speaker radius');
model.param.set('backV', '10[cm^3]', 'Back volume');
model.param.set('meshsz', 'c0/f0/6', 'Mesh size');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('sph1', 'Sphere');
model.geom('geom1').feature('sph1').set('r', 'Rair');
model.geom('geom1').feature('sph1').set('selresult', true);
model.geom('geom1').run('sph1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').run('wp1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').named('sph1');
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').run('par1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par1', 1);
model.geom('geom1').run('del1');
model.geom('geom1').create('pyr1', 'Pyramid');
model.geom('geom1').feature('pyr1').set('a', 'L0');
model.geom('geom1').feature('pyr1').set('b', 'w0');
model.geom('geom1').feature('pyr1').set('h', 'h0');
model.geom('geom1').feature('pyr1').set('rat', 2);
model.geom('geom1').feature('pyr1').set('pos', {'0' '0' '-h0'});
model.geom('geom1').feature('pyr1').set('selresult', true);
model.geom('geom1').run('pyr1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Sphere and Pyramid');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'sph1' 'pyr1'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickz', '-h0');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'rSpeaker');
model.geom('geom1').feature('wp2').geom.feature('c1').set('angle', 180);
model.geom('geom1').run('wp2');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('Box to Subtract');
model.geom('geom1').feature('blk1').set('size', {'2*Rair' 'Rair' 'Rair+h0'});
model.geom('geom1').feature('blk1').set('pos', {'-Rair' '-Rair' '-h0'});
model.geom('geom1').feature('blk1').set('selresult', true);
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('unisel1');
model.geom('geom1').feature('dif1').selection('input2').named('blk1');
model.geom('geom1').run('fin');
model.geom('geom1').create('ballsel1', 'BallSelection');
model.geom('geom1').feature('ballsel1').label('Exterior Field Boundary');
model.geom('geom1').feature('ballsel1').set('entitydim', 2);
model.geom('geom1').feature('ballsel1').set('posy', 'Rair*0.02');
model.geom('geom1').feature('ballsel1').set('posz', 'Rair');
model.geom('geom1').feature('ballsel1').set('r', 'Rair*0.01');
model.geom('geom1').run('ballsel1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Speaker Boundary');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('zmax', '-h0*0.9');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').label('Speaker Driver');
model.geom('geom1').feature('cylsel1').set('entitydim', 2);
model.geom('geom1').feature('cylsel1').set('r', 'rSpeaker*1.01');
model.geom('geom1').feature('cylsel1').set('condition', 'inside');
model.geom('geom1').run('cylsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Moving Boundaries');
model.geom('geom1').feature('boxsel2').set('entitydim', 2);
model.geom('geom1').feature('boxsel2').set('zmin', '-h0*0.9');
model.geom('geom1').feature('boxsel2').set('zmax', '-h0*0.8');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('boxsel3', 'BoxSelection');
model.geom('geom1').feature('boxsel3').label('Symmetry Boundary');
model.geom('geom1').feature('boxsel3').set('entitydim', 2);
model.geom('geom1').feature('boxsel3').set('ymax', 'eps');
model.geom('geom1').feature('boxsel3').set('condition', 'inside');
model.geom('geom1').run('boxsel3');

model.title([]);

model.description('');

model.label('rectangular_horn_shape_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
