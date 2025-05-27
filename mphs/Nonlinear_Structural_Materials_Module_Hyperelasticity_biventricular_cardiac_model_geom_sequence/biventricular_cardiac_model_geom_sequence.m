function out = model
%
% biventricular_cardiac_model_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Nonlinear_Structural_Materials_Module/Hyperelasticity');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Heart Geometry Parameters');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('aL', '3[cm]', 'x-semiaxis, left ventricle');
model.param.set('bL', 'aL', 'y-semiaxis, left ventricle');
model.param.set('cL', '7[cm]', 'z-semiaxis, left ventricle');
model.param.set('tL', '1.2[cm]', 'Wall thickness, left ventricle');
model.param.set('aR', '5.1[cm]', 'x-semiaxis, right ventricle');
model.param.set('bR', 'bL', 'y-semiaxis, right ventricle');
model.param.set('cR', '6[cm]', 'z-semiaxis, right ventricle');
model.param.set('tR', '0.6[cm]', 'Wall thickness, right ventricle');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('elp1', 'Ellipsoid');
model.geom('geom1').feature('elp1').label('Ellipsoid: Left Ventricle');
model.geom('geom1').feature('elp1').set('semiaxes', {'aL' 'bL' 'cL'});
model.geom('geom1').feature('elp1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('elp1').setIndex('layer', 'tL', 0);
model.geom('geom1').feature.duplicate('elp2', 'elp1');
model.geom('geom1').feature('elp2').label('Ellipsoid: Right Ventricle');
model.geom('geom1').feature('elp2').set('semiaxes', {'aR' 'bR' 'cR'});
model.geom('geom1').feature('elp2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('elp2').setIndex('layer', 'tR', 0);
model.geom('geom1').run('elp2');
model.geom('geom1').create('pard1', 'PartitionDomains');

model.view('view1').set('transparency', true);

model.geom('geom1').feature('pard1').selection('domain').set('elp2', [1 3 5 6 8]);
model.geom('geom1').feature('pard1').set('partitionwith', 'faces');
model.geom('geom1').feature('pard1').selection('face').set('elp1', [16 22]);
model.geom('geom1').run('pard1');
model.geom('geom1').feature.create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(2);
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('elp1', [2 4 5 7 9]);
model.geom('geom1').feature('del1').selection('input').set('pard1', [1 2 3 4 5 6 7 9 10]);
model.geom('geom1').runPre('fin');
model.geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.geom('geom1').feature('fin').set('repairtol', '3e-4');
model.geom('geom1').run('fin');
model.geom('geom1').create('igf1', 'IgnoreFaces');
model.geom('geom1').feature('igf1').selection('input').set('fin', [11 20]);
model.geom('geom1').run('igf1');

model.view('view1').set('transparency', true);

model.title([]);

model.description('');

model.label('biventricular_cardiac_model_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
