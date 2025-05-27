function out = model
%
% pcb_import.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ECAD_Import_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'printed_circuit_board_si_geom.zip');
model.geom('geom1').feature('imp1').setIndex('importlayer', false, 6);
model.geom('geom1').feature('imp1').setIndex('importlayer', true, 9);
model.geom('geom1').feature('imp1').set('importtype', 'shell');
model.geom('geom1').feature('imp1').set('ignoreoutsideboard', true);
model.geom('geom1').feature('imp1').importData;

model.view('view1').label('View no scaling');
model.view.duplicate('view2', 'view1');
model.view('view2').label('View automatic scaling');
model.view('view2').camera.set('viewscaletype', 'automatic');
model.view('view2').set('transparency', true);

model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('PCB Domain');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'imp1_TOP' 'imp1_BOTTOM' 'imp1_TOP_DIEL'});
model.geom('geom1').feature('unisel1').set('selshow', 'dom');
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Copper Boundaries');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').set('input', {'imp1_TOP' 'imp1_BOTTOM' 'imp1_DRILL_TOP_DIEL'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('unisel1');
model.geom('geom1').run('uni1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').named('unisel1');
model.geom('geom1').feature('dif1').selection('input2').named('imp1_DRILL_TOP_DIEL');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('FR4 (Circuit Board)');
model.material('mat1').set('family', 'pcbgreen');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0.004[S/m]' '0' '0' '0' '0.004[S/m]' '0' '0' '0' '0.004[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'4.5' '0' '0' '0' '4.5' '0' '0' '0' '4.5'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'18e-6[1/K]' '0' '0' '0' '18e-6[1/K]' '0' '0' '0' '18e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '1369[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('density', '1900[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'0.3[W/(m*K)]' '0' '0' '0' '0.3[W/(m*K)]' '0' '0' '0' '0.3[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '22[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.15');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat2').label('Copper');
model.material('mat2').set('family', 'copper');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.35');
model.material('mat2').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat2').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat2').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat2').propertyGroup('linzRes').addInput('temperature');
model.material('mat1').selection.named('geom1_unisel1_dom');
model.material('mat2').selection.geom('geom1', 2);
model.material('mat2').selection.named('geom1_unisel2');

model.mesh('mesh1').run;

model.view('view1').set('rendermesh', false);

model.component('comp1').measure.selection.geom(1);
model.component('comp1').measure.selection.set([317]);

model.geom('geom1').create('rmd1', 'RemoveDetails');
model.geom('geom1').feature('rmd1').set('smallfaces', false);
model.geom('geom1').feature('rmd1').set('sliverfaces', false);
model.geom('geom1').feature('rmd1').set('narrowfaceregions', false);
model.geom('geom1').feature('rmd1').set('thindomains', false);
model.geom('geom1').feature('rmd1').set('detailsizetype', 'absolute');
model.geom('geom1').feature('rmd1').set('maxabssize', '0.008[in]');
model.geom('geom1').feature('rmd1').set('contangletol', '16[deg]');
model.geom('geom1').run('rmd1');
model.geom('geom1').feature('rmd1').set('automatic', 'off');
model.geom('geom1').runPre('rmd1/aigv4');
model.geom('geom1').feature('rmd1').set('automatic', true);
model.geom('geom1').run('rmd1');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '0.7[in]');
model.mesh('mesh1').feature('size').set('hmin', '0.07[in]');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.named('geom1_imp1_TOP_DIEL_bnd');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmax', '0.1[in]');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hmin', '0.01[in]');
model.mesh('mesh1').run;

model.view('view1').set('rendermesh', true);

model.title('Importing and Meshing a PCB Geometry from an ODB++ Archive');

model.description(['This tutorial model shows how to import data from an ODB++ archive to generate a geometry of a printed circuit board (PCB). Follow the instructions to learn how to remove small details from the geometry, create a mesh, and use automatically generated selections to define physics and mesh settings.' newline  newline 'The ODB++ file is provided courtesy of Hypertherm, Inc., Hanover, NH, USA']);

model.label('pcb_import.mph');

model.modelNode.label('Components');

out = model;
