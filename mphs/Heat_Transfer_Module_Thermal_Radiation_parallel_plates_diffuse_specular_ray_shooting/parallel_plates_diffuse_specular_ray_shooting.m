function out = model
%
% parallel_plates_diffuse_specular_ray_shooting.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Thermal_Radiation');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('rad', 'SurfaceToSurfaceRadiation', 'geom1');
model.physics('rad').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/rad', true);

model.param.set('w', '10[cm]');
model.param.descr('w', 'Width of the plates');
model.param.set('d', '10[cm]');
model.param.descr('d', 'Distance between the plates');
model.param.set('th', 'w/20');
model.param.descr('th', 'Thickness of the plates');
model.param.set('T0', '300[K]');
model.param.descr('T0', 'Room temperature');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'w' 'th'});
model.geom('geom1').feature('r1').set('base', 'center');
model.geom('geom1').feature('r1').set('pos', {'0' '-(d+th)/2'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').feature('r1').set('selresultshow', 'bnd');
model.geom('geom1').feature('r1').label('Lower plate');
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').set('pos', {'0' '(d+th)/2'});
model.geom('geom1').feature('r2').label('Upper plate');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').selection.geom('geom1', 1);
model.variable('var1').selection.all;
model.variable('var1').label('Study 1');
model.variable('var1').set('epsilon_mat', '0.6');
model.variable('var1').descr('epsilon_mat', 'Emissivity');
model.variable('var1').set('rhod_mat', '0.08');
model.variable('var1').descr('rhod_mat', 'Diffuse reflectivity');

model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('table', {'-.49945499542445175000' '-.72041782640953041531';  ...
'-.49713063021837630000' '-.71991088499246001211';  ...
'-.49295799586795145000' '-.71900347615318219878';  ...
'-.48695168400966195000' '-.71770340943363138076';  ...
'-.47913392430695410000' '-.71602244650687917286';  ...
'-.46953377200148115000' '-.71397635504777592866';  ...
'-.45818693115489010000' '-.71158514338917501783';  ...
'-.44513560901476370000' '-.70887332026698187993';  ...
'-.43042835559114615000' '-.70587014060788902533';  ...
'-.41411988191153245000' '-.70260980221763138353';  ...
'-.39627085604969060000' '-.69913155603436351148';  ...
'-.37694767724268775000' '-.69547969143363354903';  ...
'-.35622222878851835000' '-.69170335941042814263';  ...
'-.33417161058768500000' '-.68785620107079841485';  ...
'-.31087785230036165000' '-.68399575711894696970';  ...
'-.28642760817565195000' '-.68018264586555002201';  ...
'-.26091183468309290000' '-.67647951212565348695';  ...
'-.23442545214302050000' '-.67294976610059335070';  ...
'-.20706699161315195000' '-.66965614839425370876';  ...
'-.17893822834420475000' '-.66665917292461353676';  ...
'-.15014380316766595000' '-.66401551195067755216';  ...
'-.12079083322389935000' '-.66177639540324401875';  ...
'-.09098851347853875000' '-.65998609943959078245';  ...
'-.06084771050944440000' '-.65868059657406921520';  ...
'-.03048055007528935000' '-.65788643241758727058';  ...
'0' '-.65761988294637615913';  ...
'.03048055007528935000' '-.65788643241758727068';  ...
'.06084771050944440000' '-.65868059657406921538';  ...
'.09098851347853875000' '-.65998609943959078255';  ...
'.12079083322389935000' '-.66177639540324401903';  ...
'.15014380316766595000' '-.66401551195067755193';  ...
'.17893822834420475000' '-.66665917292461353693';  ...
'.20706699161315195000' '-.66965614839425370868';  ...
'.23442545214302050000' '-.67294976610059335081';  ...
'.26091183468309290000' '-.67647951212565348678';  ...
'.28642760817565195000' '-.68018264586555002215';  ...
'.31087785230036165000' '-.68399575711894696948';  ...
'.33417161058768500000' '-.68785620107079841490';  ...
'.35622222878851835000' '-.69170335941042814270';  ...
'.37694767724268775000' '-.69547969143363354901';  ...
'.39627085604969060000' '-.69913155603436351146';  ...
'.41411988191153245000' '-.70260980221763138351';  ...
'.43042835559114615000' '-.70587014060788902550';  ...
'.44513560901476370000' '-.70887332026698188006';  ...
'.45818693115489010000' '-.71158514338917501795';  ...
'.46953377200148115000' '-.71397635504777592845';  ...
'.47913392430695410000' '-.71602244650687917298';  ...
'.48695168400966195000' '-.71770340943363138086';  ...
'.49295799586795145000' '-.71900347615318219870';  ...
'.49713063021837630000' '-.71991088499246001206';  ...
'.49945499542445175000' '-.72041782640953041538'});
model.func('int1').setIndex('argunit', 1, 0);
model.func('int1').setIndex('fununit', 1, 0);
model.func('int1').set('funcname', 'reference_solution');

model.physics('rad').prop('RadiationSettings').set('radiationMethod', 'rayshooting');
model.physics('rad').prop('RadiationSettings').set('radiationResolutionRayShooting', 256);
model.physics('rad').prop('RadiationSettings').set('highOrderMeshElements', true);
model.physics('rad').create('osurf1', 'OpaqueSurfaceSpecularDiffuse', 1);
model.physics('rad').feature('osurf1').selection.all;
model.physics('rad').feature('osurf1').set('radDirectionType', 'RadiationDirectionPlus');
model.physics('rad').feature('osurf1').set('minput_temperature', 'T0');
model.physics('rad').feature('osurf1').set('Tamb', 0);
model.physics('rad').feature('init1').set('Tinit', 'T0');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Plates, boundaries');
model.material('mat1').propertyGroup('def').set('emissivity', {'epsilon_mat'});
model.material('mat1').propertyGroup('def').set('surfacediffusereflectivity', {'rhod_mat'});

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('size').set('hauto', 1);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_rad_osurf1_Ju_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_osurf1_Jd_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf1_Jd_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').feature('comp1_rad_dsurf1_Ju_band').set('scalemethod', 'init');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_rad_dsurf1_Ju_band' 'comp1_rad_dsurf1_Jd_band' 'comp1_rad_osurf1_Ju_band' 'comp1_rad_osurf1_Jd_band'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, radiation variables');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Radiosity');
model.sol('sol1').feature('s1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('s1').feature('se1').set('segaaccdim', 10);
model.sol('sol1').feature('s1').feature('se1').set('ntolfact', 0.1);
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('s1').feature('i1').label('AMG, radiation variables');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i2').label('GMG, radiation variables');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').set('mcasegen', 'any');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Surface Radiosity (rad)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'rad/RAD_PhysicsInterfaces/icom1/pdef1/pcond2/pg1');
model.result('pg1').feature.create('line1', 'Line');
model.result('pg1').feature('line1').label('Upside Radiosity');
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('expr', 'rad.Ju');
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('smooth', 'internal');
model.result('pg1').feature('line1').set('inheritdeformscale', false);
model.result('pg1').feature('line1').set('showsolutionparams', 'on');
model.result('pg1').feature('line1').set('data', 'parent');
model.result('pg1').feature('line1').feature.create('def1', 'Deform');
model.result('pg1').feature('line1').feature('def1').set('expr', {'nx/sqrt(tremetric)' 'ny/sqrt(tremetric)'});
model.result('pg1').feature('line1').feature('def1').set('scale', '0.1');
model.result('pg1').feature.create('line2', 'Line');
model.result('pg1').feature('line2').label('Downside Radiosity');
model.result('pg1').feature('line2').set('showsolutionparams', 'on');
model.result('pg1').feature('line2').set('expr', 'rad.Jd');
model.result('pg1').feature('line2').set('linetype', 'tube');
model.result('pg1').feature('line2').set('smooth', 'internal');
model.result('pg1').feature('line2').set('showsolutionparams', 'on');
model.result('pg1').feature('line2').set('data', 'parent');
model.result('pg1').feature('line2').set('inheritplot', 'line1');
model.result('pg1').feature('line2').feature.create('def1', 'Deform');
model.result('pg1').feature('line2').feature('def1').set('expr', {'-nx/sqrt(tremetric)' '-ny/sqrt(tremetric)'});
model.result('pg1').run;
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').importData('parallel_plates_diffuse_specular_data.txt');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Validation');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Dimensionless radiative heat flux');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'x/w');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'q/(\varepsilon Eb)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr1').set('linewidth', 'preference');
model.result('pg2').feature('lngr1').label('Theory');
model.result('pg2').feature('lngr1').selection.set([5]);
model.result('pg2').feature('lngr1').set('expr', 'reference_solution(x/w)');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x/w');
model.result('pg2').feature('lngr1').set('linestyle', 'none');
model.result('pg2').feature('lngr1').set('linemarker', 'circle');
model.result('pg2').feature('lngr1').set('linecolor', 'fromtheme');
model.result('pg2').feature('lngr1').set('resolution', 'norefine');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('autosolution', false);
model.result('pg2').feature('lngr1').set('autoplotlabel', true);
model.result('pg2').run;
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('markerpos', 'datapoints');
model.result('pg2').feature('lngr2').set('linewidth', 'preference');
model.result('pg2').feature('lngr2').label('Simulation');
model.result('pg2').feature('lngr2').selection.set([5]);
model.result('pg2').feature('lngr2').set('expr', 'rad.rflux/(rad.epsilon*rad.ebu)');
model.result('pg2').feature('lngr2').set('xdata', 'expr');
model.result('pg2').feature('lngr2').set('xdataexpr', 'x/w');
model.result('pg2').feature('lngr2').set('linewidth', 3);
model.result('pg2').feature('lngr2').set('resolution', 'norefine');
model.result('pg2').feature('lngr2').set('legend', true);
model.result('pg2').feature('lngr2').set('autosolution', false);
model.result('pg2').feature('lngr2').set('autoplotlabel', true);
model.result('pg2').run;

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.multiphysics.create('htrad1', 'HeatTransferWithSurfaceToSurfaceRadiation', 'geom1', 1);

model.study('std1').feature('stat').setSolveFor('/multiphysics/htrad1', true);

model.multiphysics('htrad1').selection.all;
model.multiphysics('htrad1').set('Heat_physics', 'ht');
model.multiphysics('htrad1').set('Rad_physics', 'rad');

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Quartz');
model.material('mat2').selection.set([1]);
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'1.1'});
model.material('mat2').propertyGroup('def').set('density', {'2200'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'480'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').selection.set([2]);
model.material('mat3').label('Copper');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'400'});
model.material('mat3').propertyGroup('def').set('density', {'8700'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'385'});

model.variable.duplicate('var2', 'var1');
model.variable('var2').selection.named('geom1_r2_bnd');
model.variable('var2').label('Study 2, Upper plate');
model.variable('var2').descr('epsilon_mat', 'Specular reflectivity, upper plate');
model.variable.duplicate('var3', 'var2');
model.variable('var3').selection.named('geom1_r1_bnd');
model.variable('var3').label('Study 2, Lower plate');
model.variable('var3').set('epsilon_mat', '0.9');
model.variable('var3').descr('epsilon_mat', 'Diffuse reflectivity, lower plate');
model.variable('var3').set('rhod_mat', '0.09');

model.physics('ht').prop('PhysicalModelProperty').set('Tref', 'T0');
model.physics('ht').feature('init1').set('Tinit', 'T0');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').selection.all;
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 10);
model.physics('ht').feature('hf1').set('Text', 'T0');
model.physics('ht').create('dbp1', 'DepositedBeamPower', 1);
model.physics('ht').feature('dbp1').selection.set([6]);
model.physics('ht').feature('dbp1').set('e', [0 -1 0]);
model.physics('ht').feature('dbp1').set('P0', 4000);
model.physics('ht').feature('dbp1').set('O', {'0.025' 'd+w' '0'});
model.physics('ht').feature('dbp1').set('sigma', 0.01);

model.study('std1').label('Study 1, without Heat Transfer');
model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledvariables', {'var2' 'var3'});
model.study('std1').feature('stat').setSolveFor('/physics/ht', false);
model.study('std1').feature('stat').setSolveFor('/multiphysics/htrad1', false);
model.study('std1').feature('stat').set('disabledphysics', {'ht'});
model.study('std1').feature('stat').set('disabledcoupling', {'htrad1'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/rad', true);
model.study('std2').feature('stat').setSolveFor('/physics/ht', true);
model.study('std2').feature('stat').setSolveFor('/multiphysics/htrad1', true);
model.study('std2').label('Study 2, with Heat Transfer');
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledvariables', {'var1'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_rad_osurf1_Ju_band').set('scalemethod', 'init');
model.sol('sol2').feature('v1').feature('comp1_rad_osurf1_Jd_band').set('scalemethod', 'init');
model.sol('sol2').feature('v1').feature('comp1_rad_dsurf1_Jd_band').set('scalemethod', 'init');
model.sol('sol2').feature('v1').feature('comp1_rad_dsurf1_Ju_band').set('scalemethod', 'init');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol2').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_T'});
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, heat transfer variables (ht) (Merged)');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').label('Temperature');
model.sol('sol2').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_rad_dsurf1_Ju_band' 'comp1_rad_dsurf1_Jd_band' 'comp1_rad_osurf1_Ju_band' 'comp1_rad_osurf1_Jd_band'});
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol2').feature('s1').create('d2', 'Direct');
model.sol('sol2').feature('s1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d2').label('Direct, radiation variables');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').label('Radiosity');
model.sol('sol2').feature('s1').feature('se1').set('segtermonres', 'off');
model.sol('sol2').feature('s1').feature('se1').set('ntolfact', 0.1);
model.sol('sol2').feature('s1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol2').feature('s1').feature('se1').set('segaaccdim', 10);
model.sol('sol2').feature('s1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol2').feature('s1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('rhob', 400);
model.sol('sol2').feature('s1').feature('i1').label('AMG, radiation variables (rad)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').create('i2', 'Iterative');
model.sol('sol2').feature('s1').feature('i2').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i2').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i2').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i2').label('GMG, radiation variables (rad)');
model.sol('sol2').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('prefun', 'gmg');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('mcasegen', 'any');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').create('i3', 'Iterative');
model.sol('sol2').feature('s1').feature('i3').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i3').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i3').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i3').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i3').set('maxlinit', 10000);
model.sol('sol2').feature('s1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i3').label('AMG, heat transfer variables (ht)');
model.sol('sol2').feature('s1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Surface Radiosity (rad) 1');
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('defaultPlotID', 'rad/RAD_PhysicsInterfaces/icom1/pdef1/pcond2/pg1');
model.result('pg3').feature.create('line1', 'Line');
model.result('pg3').feature('line1').label('Upside Radiosity');
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('expr', 'rad.Ju');
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').feature('line1').set('smooth', 'internal');
model.result('pg3').feature('line1').set('inheritdeformscale', false);
model.result('pg3').feature('line1').set('showsolutionparams', 'on');
model.result('pg3').feature('line1').set('data', 'parent');
model.result('pg3').feature('line1').feature.create('def1', 'Deform');
model.result('pg3').feature('line1').feature('def1').set('expr', {'nx/sqrt(tremetric)' 'ny/sqrt(tremetric)'});
model.result('pg3').feature('line1').feature('def1').set('scale', '0.1');
model.result('pg3').feature.create('line2', 'Line');
model.result('pg3').feature('line2').label('Downside Radiosity');
model.result('pg3').feature('line2').set('showsolutionparams', 'on');
model.result('pg3').feature('line2').set('expr', 'rad.Jd');
model.result('pg3').feature('line2').set('linetype', 'tube');
model.result('pg3').feature('line2').set('smooth', 'internal');
model.result('pg3').feature('line2').set('showsolutionparams', 'on');
model.result('pg3').feature('line2').set('data', 'parent');
model.result('pg3').feature('line2').set('inheritplot', 'line1');
model.result('pg3').feature('line2').feature.create('def1', 'Deform');
model.result('pg3').feature('line2').feature('def1').set('expr', {'-nx/sqrt(tremetric)' '-ny/sqrt(tremetric)'});
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Temperature (ht)');
model.result('pg4').set('data', 'dset2');
model.result('pg4').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg4').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg3').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Temperature');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').label('Upper plate');
model.result('pg5').feature('lngr1').selection.set([5]);
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').set('linewidth', 3);
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('autosolution', false);
model.result('pg5').feature('lngr1').set('autoplotlabel', true);
model.result('pg5').feature.duplicate('lngr2', 'lngr1');
model.result('pg5').run;
model.result('pg5').feature('lngr2').label('Lower plate');
model.result('pg5').feature('lngr2').selection.set([3]);
model.result('pg5').feature('lngr2').set('titletype', 'none');
model.result('pg5').feature('lngr2').set('linestyle', 'dashed');
model.result('pg5').run;
model.result('pg5').set('legendpos', 'middleright');
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Radiative heat flux');
model.result('pg6').run;
model.result('pg6').feature('lngr1').set('expr', 'rad.rflux');
model.result('pg6').run;
model.result('pg6').feature('lngr2').set('expr', 'rad.rflux');
model.result('pg6').run;
model.result.numerical.create('int1', 'IntLine');
model.result.numerical('int1').set('intsurface', true);
model.result.numerical('int1').label('Mean radiative heat flux');
model.result.numerical('int1').selection.set([3 5]);
model.result.numerical('int1').setIndex('expr', 'rad.rflux/(w*rad.epsilon*rad.ebu)', 0);
model.result.numerical('int1').setIndex('unit', 'm', 0);
model.result.numerical('int1').setIndex('descr', 'Radiative heat flux', 0);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Mean radiative heat flux');
model.result.numerical('int1').set('table', 'tbl2');
model.result.numerical('int1').setResult;
model.result.numerical.duplicate('int2', 'int1');
model.result.numerical('int2').label('Relative error in radiative heat flux');
model.result.numerical('int2').setIndex('expr', '((rad.rflux/(rad.epsilon*rad.ebu))/reference_solution(x)-1)^2/w', 0);
model.result.numerical('int2').setIndex('unit', '', 0);
model.result.numerical('int2').setIndex('descr', 'Relative error', 0);
model.result.numerical('int2').set('table', 'tbl2');
model.result.numerical('int2').appendResult;
model.result.numerical.create('int3', 'IntSurface');
model.result.numerical('int3').set('intvolume', true);
model.result.numerical('int3').label('Mean temperature, Lower plate');
model.result.numerical('int3').set('data', 'dset2');
model.result.numerical('int3').selection.set([1]);
model.result.numerical('int3').setIndex('expr', 'T/(w*th)', 0);
model.result.numerical('int3').setIndex('unit', 'm^2*K', 0);
model.result.numerical('int3').setIndex('descr', 'Temperature', 0);
model.result.table.create('tbl3', 'Table');
model.result.table('tbl3').comments('Mean temperature, Lower plate');
model.result.numerical('int3').set('table', 'tbl3');
model.result.numerical('int3').setResult;
model.result.numerical.duplicate('int4', 'int3');
model.result.numerical('int4').label('Mean temperature, Upper plate');
model.result.numerical('int4').selection.set([2]);
model.result.numerical('int4').set('table', 'tbl3');
model.result.numerical('int4').appendResult;
model.result.dataset.duplicate('dset3', 'dset1');
model.result.dataset('dset3').label('Study 1, without Heat Transfer/Solution 1, inner faces');
model.result.dataset('dset3').selection.geom('geom1', 1);
model.result.dataset('dset3').selection.geom('geom1', 1);
model.result.dataset('dset3').selection.set([3 5]);
model.result.dataset.create('extr1', 'Extrude2D');
model.result.dataset('extr1').set('data', 'dset3');
model.result.dataset('extr1').set('zmax', '2');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Surface Radiosity 3D');
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'rad.J');
model.result('pg7').feature('surf1').label('Radiosity');
model.result('pg7').feature('surf1').set('colortable', 'HeatCamera');
model.result('pg7').feature('surf1').set('rangecoloractive', true);
model.result('pg7').feature('surf1').set('rangecolormin', 285);
model.result('pg7').feature('surf1').set('rangecolormax', 288);
model.result('pg7').run;

model.view('view2').set('showgrid', false);
model.view('view2').camera.set('zoomanglefull', 121);
model.view('view2').camera.setIndex('position', 0.1, 0);
model.view('view2').camera.setIndex('position', 0, 1);
model.view('view2').camera.set('position', [0.1 0 0.1]);
model.view('view2').camera.set('target', [0 0 0.1]);
model.view('view2').camera.setIndex('up', 0, 0);
model.view('view2').camera.setIndex('up', 0, 1);
model.view('view2').camera.set('up', [0 0 1]);
model.view('view2').camera.set('rotationpoint', [0 0 0.1]);
model.view('view2').camera.setIndex('viewoffset', -0.02, 0);
model.view('view2').camera.set('viewoffset', [-0.02 -0.02]);

model.result('pg7').run;

model.view('view2').set('scenelight', false);

model.title('Surface-to-Surface Radiation with Diffuse and Specular Reflection');

model.description('This tutorial shows how to use the Surface-to-Surface Radiation interface to simulate radiative heat transfer with radiation between diffuse emitters and diffuse-and-specular reflectors. This model is separated in two parts. The first part focuses on a validation test for the radiative heat flux computed from the ray shooting algorithm, wherein results are compared to an analytical solution for two parallel plates at constant temperature. The second part introduces coupling with Heat Transfer in Solids.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('parallel_plates_diffuse_specular_ray_shooting.mph');

model.modelNode.label('Components');

out = model;
