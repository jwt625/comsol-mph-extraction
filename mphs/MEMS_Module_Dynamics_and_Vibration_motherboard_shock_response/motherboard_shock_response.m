function out = model
%
% motherboard_shock_response.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/MEMS_Module/Dynamics_and_Vibration');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');

model.study.create('std1');
model.study('std1').create('eig', 'Eigenfrequency');
model.study('std1').feature('eig').set('eigmethod', 'region');
model.study('std1').feature('eig').set('shift', '0');
model.study('std1').feature('eig').set('shiftactive', false);
model.study('std1').feature('eig').set('appnreigs', '50');
model.study('std1').feature('eig').set('eigsr', '0.1');
model.study('std1').feature('eig').set('eiglr', '33');
model.study('std1').feature('eig').set('chkeigregion', true);
model.study('std1').feature('eig').set('conrad', '1');
model.study('std1').feature('eig').set('conradynhm', '1');
model.study('std1').feature('eig').set('storefact', false);
model.study('std1').feature('eig').set('solnum', 'auto');
model.study('std1').feature('eig').set('notsolnum', 'auto');
model.study('std1').feature('eig').set('outputmap', {});
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').set('ngenAUX', '1');
model.study('std1').feature('eig').set('goalngenAUX', '1');
model.study('std1').feature('eig').setSolveFor('/physics/solid', true);

model.common.create('rsp1', 'ResponseSpectrum', 'comp1');
model.common('rsp1').set('eigStudy', 'std1');

model.view('view1').set('showgrid', false);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'motherboard_shock_response.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('imprint', true);
model.geom('geom1').run('fin');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').set([1]);
model.selection('sel1').label('PCB');
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').set([17 21]);
model.selection('sel2').label('Heat sinks');
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').set([3 4 7 8 9 10 18 22]);
model.selection('sel3').label('Chips');
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').set([2 5 6 11 12 13 14]);
model.selection('sel4').label('Connector blocks');
model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').set([23 24 25 28 31]);
model.selection('sel5').label('Capacitors (larger)');
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').set([15 16 19 20 26 27 29 30]);
model.selection('sel6').label('Capacitors (smaller)');
model.selection.create('sel7', 'Explicit');
model.selection('sel7').model('comp1');
model.selection('sel7').geom(2);
model.selection('sel7').set([7 9 11 12 13 14 16 17 18 19 38 40 42 43 44 45 46 47 48 49 68 70 72 73 74 75 77 78 79 80]);
model.selection('sel7').label('Mounting holes');

model.view('view1').set('showmaterial', true);

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
model.material('mat1').selection.named('sel1');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat2').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat2').label('Aluminum');
model.material('mat2').set('family', 'aluminum');
model.material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat2').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat2').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat2').propertyGroup('Enu').set('nu', '0.33');
model.material('mat2').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat2').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat2').selection.named('sel2');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat3').label('Silicon');
model.material('mat3').set('family', 'custom');
model.material('mat3').set('customspecular', [0.7843137254901961 1 1]);
model.material('mat3').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat3').set('customambient', [0.6666666666666666 0.6666666666666666 0.7058823529411765]);
model.material('mat3').set('noise', true);
model.material('mat3').set('fresnel', 0.7);
model.material('mat3').set('metallic', 0);
model.material('mat3').set('pearl', 0);
model.material('mat3').set('diffusewrap', 0);
model.material('mat3').set('clearcoat', 0);
model.material('mat3').set('reflectance', 0);
model.material('mat3').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1e-12[S/m]' '0' '0' '0' '1e-12[S/m]' '0' '0' '0' '1e-12[S/m]'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]' '0' '0' '0' '2.6e-6[1/K]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', '700[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('relpermittivity', {'11.7' '0' '0' '0' '11.7' '0' '0' '0' '11.7'});
model.material('mat3').propertyGroup('def').set('density', '2329[kg/m^3]');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]' '0' '0' '0' '130[W/(m*K)]'});
model.material('mat3').propertyGroup('Enu').set('E', '170[GPa]');
model.material('mat3').propertyGroup('Enu').set('nu', '0.28');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'3.48' '0' '0' '0' '3.48' '0' '0' '0' '3.48'});
model.material('mat3').selection.named('sel3');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').label('Acrylic plastic');
model.material('mat4').set('family', 'custom');
model.material('mat4').set('customspecular', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat4').set('customdiffuse', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat4').set('customambient', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.material('mat4').set('noise', true);
model.material('mat4').set('lighting', 'phong');
model.material('mat4').set('shininess', 1000);
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '1470[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('density', '1190[kg/m^3]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]'});
model.material('mat4').propertyGroup('Enu').set('E', '3.2[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.35');
model.material('mat4').selection.named('sel4');
model.material('mat4').set('family', 'plasticshiny');
model.material('mat4').set('color', 'black');
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat5').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat5').label('Aluminum 1');
model.material('mat5').set('family', 'aluminum');
model.material('mat5').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat5').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat5').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat5').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat5').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat5').propertyGroup('Enu').set('nu', '0.33');
model.material('mat5').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat5').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat5').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat5').label('Capacitors (larger) composite material');
model.material('mat5').selection.named('sel5');
model.material('mat5').propertyGroup('def').set('density', {'1500[kg/m^3]'});
model.material('mat5').set('family', 'plasticshiny');
model.material('mat5').set('color', 'yellow');
model.material.create('mat6', 'Common', 'comp1');
model.material('mat6').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat6').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat6').label('Aluminum 1');
model.material('mat6').set('family', 'aluminum');
model.material('mat6').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat6').propertyGroup('def').set('heatcapacity', '900[J/(kg*K)]');
model.material('mat6').propertyGroup('def').set('thermalconductivity', {'238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]' '0' '0' '0' '238[W/(m*K)]'});
model.material('mat6').propertyGroup('def').set('electricconductivity', {'3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]' '0' '0' '0' '3.774e7[S/m]'});
model.material('mat6').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat6').propertyGroup('def').set('thermalexpansioncoefficient', {'23e-6[1/K]' '0' '0' '0' '23e-6[1/K]' '0' '0' '0' '23e-6[1/K]'});
model.material('mat6').propertyGroup('def').set('density', '2700[kg/m^3]');
model.material('mat6').propertyGroup('Enu').set('E', '70[GPa]');
model.material('mat6').propertyGroup('Enu').set('nu', '0.33');
model.material('mat6').propertyGroup('Murnaghan').set('l', '-250[GPa]');
model.material('mat6').propertyGroup('Murnaghan').set('m', '-330[GPa]');
model.material('mat6').propertyGroup('Murnaghan').set('n', '-350[GPa]');
model.material('mat6').selection.named('sel6');
model.material('mat6').label('Capacitors (smaller) composite material');
model.material('mat6').propertyGroup('def').set('density', {'2000[kg/m^3]'});
model.material('mat6').set('family', 'plasticshiny');
model.material('mat6').set('color', 'cyan');

model.physics('solid').create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.named('sel7');

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('size1').selection.named('sel6');
model.mesh('mesh1').feature('size1').set('hauto', 4);
model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').selection.set([4 5 8 10 21 22 23 24 25 26 27 28 30 34 35 36 37 39 41 50 51 52 53 54 55 56 58 61 62 63 64 66 67 69 71]);
model.mesh('mesh1').feature('fq1').create('size1', 'Size');
model.mesh('mesh1').feature('fq1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmax', '6[mm]');
model.mesh('mesh1').feature('fq1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('fq1').feature('size1').set('hmin', '0.06[mm]');
model.mesh('mesh1').run('fq1');
model.mesh('mesh1').create('fq2', 'FreeQuad');
model.mesh('mesh1').feature('fq2').selection.set([174 231]);
model.mesh('mesh1').feature('fq2').create('size1', 'Size');
model.mesh('mesh1').feature('fq2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('fq2').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('fq2').feature('size1').set('hmax', '5[mm]');
model.mesh('mesh1').run('fq2');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([86 92 97 102 109 114 119 128 133 140 146 151 158 215 280]);
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').selection.all;
model.mesh('mesh1').feature('map1').feature('size1').set('hauto', 2);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').label('Distribution: Default');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 3);
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').label('Distribution: PCB');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.named('sel1');
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 2);
model.mesh('mesh1').feature('swe1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis3').label('Distribution: Heat sinks');
model.mesh('mesh1').feature('swe1').feature('dis3').selection.named('sel2');
model.mesh('mesh1').feature('swe1').feature('dis3').set('numelem', 4);
model.mesh('mesh1').run;

model.func.create('int1', 'Interpolation');
model.func('int1').label('Acceleration (g) vs. Frequency (Hz)');
model.func('int1').set('table', {'' '';  ...
'5' '10.221170793435215';  ...
'10' '20.26879679745779';  ...
'15' '29.973306865496376';  ...
'20' '39.16869022232764';  ...
'25' '47.700241377321625';  ...
'30' '55.44173271375691';  ...
'35' '62.26790631941229';  ...
'40' '68.2226018837682';  ...
'45' '72.25156373117935';  ...
'50' '76.84071593485142';  ...
'55' '79.34738555413855';  ...
'60' '80.8482392265354';  ...
'65' '81.88481741900146';  ...
'70' '82.73388349564995';  ...
'75' '82.81339312855084';  ...
'80' '82.53033878691974';  ...
'85' '82.12161035440371';  ...
'90' '81.25042860023268';  ...
'95' '80.42718780153068';  ...
'100' '79.62075451679233';  ...
'105' '78.5425672184405';  ...
'110' '77.4317062689539';  ...
'115' '76.22878279044207';  ...
'120' '75.04889893574875';  ...
'125' '73.82984905846456';  ...
'130' '72.59556376060202';  ...
'135' '71.38816886436065';  ...
'140' '70.17472445496252';  ...
'145' '68.92259264141522';  ...
'150' '67.73817100986659';  ...
'155' '66.57237185032993';  ...
'160' '65.42065895455457';  ...
'165' '64.25557440276435';  ...
'170' '63.160208913606155';  ...
'175' '62.06421149880928';  ...
'180' '60.96426510310301';  ...
'185' '59.98596971506377';  ...
'190' '58.87254038128926';  ...
'195' '57.874864372406016';  ...
'200' '56.97642900020106';  ...
'205' '56.084318979720194';  ...
'210' '55.12502085742939';  ...
'215' '54.19609794896904';  ...
'220' '53.333682057489135';  ...
'225' '52.46242441302917';  ...
'230' '51.67980188311241';  ...
'235' '51.940219748215775';  ...
'240' '52.63103543335559';  ...
'245' '53.148082578976535';  ...
'250' '53.61390448939853';  ...
'255' '54.029157974307324';  ...
'260' '54.404221004194575';  ...
'265' '54.7293214577556';  ...
'270' '54.956260230626214';  ...
'275' '55.13961082277069';  ...
'280' '55.27848161396368';  ...
'285' '55.37288877771143';  ...
'290' '55.45133360069303';  ...
'295' '55.48029023176928';  ...
'300' '55.486249970663515';  ...
'305' '55.43565244709387';  ...
'310' '55.39571311136667';  ...
'315' '55.305464041629634';  ...
'320' '55.200957658726075';  ...
'325' '55.07014932176579';  ...
'330' '54.918613221547794';  ...
'335' '54.78581836433039';  ...
'340' '54.59963979660284';  ...
'345' '54.41891777279121';  ...
'350' '54.21076424650667';  ...
'355' '53.98568983729553';  ...
'360' '53.78315316910489';  ...
'365' '53.53425009581258';  ...
'370' '53.3056530389677';  ...
'375' '53.08237683268847';  ...
'380' '52.81568433866547';  ...
'385' '52.54058828031988';  ...
'390' '52.284171452598166';  ...
'395' '52.05344937096207';  ...
'400' '51.748491030293856';  ...
'405' '51.47798394800138';  ...
'410' '51.2091022269832';  ...
'415' '50.91592535132613';  ...
'420' '51.110965403803625';  ...
'425' '51.33274129522117';  ...
'430' '51.50010442793826';  ...
'435' '51.68071974285299';  ...
'440' '51.820151703046626';  ...
'445' '51.96016693327953';  ...
'450' '52.04227043949072';  ...
'455' '52.15510140956678';  ...
'460' '52.20727605726852';  ...
'465' '52.29401972298162';  ...
'470' '52.30039148909087';  ...
'475' '52.366714865333776';  ...
'480' '52.367301623729745';  ...
'485' '52.38348368533653';  ...
'490' '52.38171704170545';  ...
'495' '52.356738478805816';  ...
'500' '52.34889964505452';  ...
'505' '52.283464398893145';  ...
'510' '52.26926138134658';  ...
'515' '52.205594007530586';  ...
'520' '52.14218114343268';  ...
'525' '52.091000042536024';  ...
'530' '51.99739902385488';  ...
'535' '51.92705786674835';  ...
'540' '51.843990464114235';  ...
'545' '51.72214903770373';  ...
'550' '51.65426437019689';  ...
'555' '51.5504740423845';  ...
'560' '51.41096860446974';  ...
'565' '51.30628814933168';  ...
'570' '51.20152847439844';  ...
'575' '51.055367926505426';  ...
'580' '50.957244365619076';  ...
'585' '50.82526816718546';  ...
'590' '50.66256478862709';  ...
'595' '50.56286423180257';  ...
'600' '50.520073903870085';  ...
'605' '50.6656084295829';  ...
'610' '50.74635725502876';  ...
'615' '50.823273202611375';  ...
'620' '50.91586460927443';  ...
'625' '50.96879603292319';  ...
'630' '51.022408756141054';  ...
'635' '51.09889347209716';  ...
'640' '51.12487059740694';  ...
'645' '51.164722581127364';  ...
'650' '51.2051413810137';  ...
'655' '51.21640663972892';  ...
'660' '51.23710563906714';  ...
'665' '51.26267223604648';  ...
'670' '51.253228769399215';  ...
'675' '51.244644330351576';  ...
'680' '51.25613504449869';  ...
'685' '51.23845715758233';  ...
'690' '51.19521381905702';  ...
'695' '51.20113876427941';  ...
'700' '51.17765192802399';  ...
'705' '51.1308511687109';  ...
'710' '51.096251351081065';  ...
'715' '51.06834380931806';  ...
'720' '51.01812335614682';  ...
'725' '50.94723138923269';  ...
'730' '50.92143813645869';  ...
'735' '50.877064908467716';  ...
'740' '50.79843522593459';  ...
'745' '50.72563401665212';  ...
'750' '50.6867901857802';  ...
'755' '50.61459295248838';  ...
'760' '50.53261434565635';  ...
'765' '50.44745898745178';  ...
'770' '50.39321787863496';  ...
'775' '50.32013785221639';  ...
'780' '50.2621845333564';  ...
'785' '50.33192550169028';  ...
'790' '50.379794347590725';  ...
'795' '50.408276495741745';  ...
'800' '50.48570093053196';  ...
'805' '50.53506237060917';  ...
'810' '50.55987465951624';  ...
'815' '50.59566037402958';  ...
'820' '50.64195121555137';  ...
'825' '50.662897422474565';  ...
'830' '50.66880190881728';  ...
'835' '50.6853782779966';  ...
'840' '50.716756065066384';  ...
'845' '50.72629576168073';  ...
'850' '50.71689537345662';  ...
'855' '50.716384657669636';  ...
'860' '50.73072163138769';  ...
'865' '50.72961710135274';  ...
'870' '50.70966282361408';  ...
'875' '50.685070908931024';  ...
'880' '50.69069131027255';  ...
'885' '50.64948502161752';  ...
'890' '50.65424236086185';  ...
'895' '50.616332188420465';  ...
'900' '50.597766480960175';  ...
'905' '50.58379161690815';  ...
'910' '50.55669474286842';  ...
'915' '50.50897213927255';  ...
'920' '50.456387537642925';  ...
'925' '50.439321635244546';  ...
'930' '50.40919327141314';  ...
'935' '50.36963286539626';  ...
'940' '50.317761647093604';  ...
'945' '50.24996405875599';  ...
'950' '50.221734322413724';  ...
'955' '50.1819798879743';  ...
'960' '50.132078018860724';  ...
'965' '50.15690124134168';  ...
'970' '50.20765410418001';  ...
'975' '50.23616283503273';  ...
'980' '50.25660359996791';  ...
'985' '50.2871503222773';  ...
'990' '50.328488892460335';  ...
'995' '50.357394024381506';  ...
'1000' '50.371010299210894'});
model.func('int1').setIndex('fununit', 'Hz', 0);
model.func('int1').setIndex('argunit', 1, 0);
model.func.create('an1', 'Analytic');
model.func('an1').label('Vertical Spectrum');
model.func('an1').set('funcname', 'vsp');
model.func('an1').set('args', 'freq');
model.func('an1').set('expr', 'int1(freq)*g_const');
model.func('an1').setIndex('argunit', 'Hz', 0);
model.func('an1').set('fununit', 'm/s^2');
model.func('an1').setIndex('plotargs', 5, 0, 1);
model.func('an1').setIndex('plotargs', 600, 0, 2);
model.func('an1').createPlot('pg1');

model.result('pg1').run;
model.result('pg1').label('Vertical Spectrum');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Frequency (Hz)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Pseudoacceleration (m/s^2)');
model.result('pg1').set('axislimits', true);
model.result('pg1').set('xmin', 0);
model.result('pg1').set('xmax', 600);
model.result('pg1').run;

model.study('std1').feature('eig').set('eigmethod', 'manual');
model.study('std1').feature('eig').set('neigsactive', true);
model.study('std1').feature('eig').set('neigs', 15);
model.study('std1').feature('eig').set('shiftactive', true);
model.study('std1').feature('eig').set('shift', '65');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'eig');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'eig');
model.sol('sol1').create('e1', 'Eigenvalue');
model.sol('sol1').feature('e1').set('eigvfunscale', 'maximum');
model.sol('sol1').feature('e1').set('eigvfunscaleparam', '3.71E-7');
model.sol('sol1').feature('e1').set('control', 'eig');
model.sol('sol1').feature('e1').feature('aDef').set('cachepattern', true);
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'modeShape');
model.result('pg2').label('Mode Shape (solid)');
model.result('pg2').set('showlegends', false);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'solid.disp'});
model.result('pg2').feature('surf1').set('threshold', 'manual');
model.result('pg2').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg2').feature('surf1').set('colortable', 'Rainbow');
model.result('pg2').feature('surf1').set('colortabletrans', 'none');
model.result('pg2').feature('surf1').set('colorscalemode', 'linear');
model.result('pg2').feature('surf1').set('colortable', 'AuroraBorealis');
model.result('pg2').feature('surf1').create('def', 'Deform');
model.result('pg2').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg2').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.evaluationGroup.create('std1EvgFrq', 'EvaluationGroup');
model.result.evaluationGroup('std1EvgFrq').set('defaultPlotID', 'eigenfrequenciesTable_solid');
model.result.evaluationGroup('std1EvgFrq').set('data', 'dset1');
model.result.evaluationGroup('std1EvgFrq').label('Eigenfrequencies (Study 1)');
model.result.evaluationGroup('std1EvgFrq').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', '2*pi*freq', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', 'rad/s', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Angular frequency', 0);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'imag(freq)/abs(freq)', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Damping ratio', 1);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('expr', 'abs(freq)/imag(freq)/2', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1EvgFrq').feature('gev1').setIndex('descr', 'Quality factor', 2);
model.result.evaluationGroup('std1EvgFrq').run;
model.result.evaluationGroup.create('std1rsp1', 'EvaluationGroup');
model.result.evaluationGroup('std1rsp1').set('data', 'dset1');
model.result.evaluationGroup('std1rsp1').label('Participation Factors (Study 1)');
model.result.evaluationGroup('std1rsp1').create('gev1', 'EvalGlobal');
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('expr', 'rsp1.pfLnormX', 0);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('unit', '1', 0);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('descr', 'Participation factor, normalized, X-translation', 0);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('expr', 'rsp1.pfLnormY', 1);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('unit', '1', 1);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Y-translation', 1);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('expr', 'rsp1.pfLnormZ', 2);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('unit', '1', 2);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('descr', 'Participation factor, normalized, Z-translation', 2);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('expr', 'rsp1.mEffLX', 3);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('unit', 'kg', 3);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('descr', 'Effective modal mass, X-translation', 3);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('expr', 'rsp1.mEffLY', 4);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('unit', 'kg', 4);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('descr', 'Effective modal mass, Y-translation', 4);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('expr', 'rsp1.mEffLZ', 5);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('unit', 'kg', 5);
model.result.evaluationGroup('std1rsp1').feature('gev1').setIndex('descr', 'Effective modal mass, Z-translation', 5);
model.result.evaluationGroup('std1rsp1').run;
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'none');
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('source', 'evaluationgroup');
model.result('pg3').feature('tblp1').set('evaluationgroup', 'std1rsp1');
model.result('pg3').feature('tblp1').set('linewidth', 'preference');
model.result('pg3').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg3').run;
model.result('pg3').feature('tblp1').set('plotcolumninput', 'manual');
model.result('pg3').feature('tblp1').set('plotcolumns', [4]);
model.result('pg3').feature('tblp1').set('linemarker', 'asterisk');
model.result('pg3').feature('tblp1').set('linestyle', 'none');
model.result('pg3').run;
model.result('pg3').label('Participation Factors');
model.result('pg1').run;
model.result('pg1').set('xmin', 30);
model.result('pg1').set('xmax', 400);
model.result('pg1').set('ymin', 500);
model.result('pg1').set('ymax', 850);
model.result('pg1').set('legendpos', 'middleright');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('markerpos', 'datapoints');
model.result('pg1').feature('glob1').set('linewidth', 'preference');
model.result('pg1').feature('glob1').set('data', 'dset1');
model.result('pg1').feature('glob1').set('expr', {'vsp(freq)'});
model.result('pg1').feature('glob1').set('descr', {'Vertical Spectrum'});
model.result('pg1').feature('glob1').set('unit', {'m/s^2'});
model.result('pg1').feature('glob1').set('xdata', 'expr');
model.result('pg1').feature('glob1').set('xdataexpr', 'freq');
model.result('pg1').feature('glob1').set('linestyle', 'none');
model.result('pg1').feature('glob1').set('linemarker', 'cycle');
model.result('pg1').feature('glob1').set('legendmethod', 'manual');
model.result('pg1').feature('glob1').setIndex('legends', 'Values at eigenfrequencies', 0);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('looplevel', [3]);
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('expr', {'rsp1.mEffLZ'});
model.result.numerical('gev1').set('descr', {'Effective modal mass, Z-translation'});
model.result.numerical('gev1').set('unit', {'kg'});
model.result.numerical('gev1').setIndex('expr', 'rsp1.mEffLZ/rsp1.mass', 0);
model.result.numerical('gev1').setIndex('unit', 1, 0);
model.result.numerical('gev1').setIndex('descr', '', 0);
model.result.numerical('gev1').set('dataseries', 'integral');
model.result.numerical('gev1').set('dataseriesmethod', 'summation');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.dataset.create('rs1', 'ResponseSpectrum3D');
model.result.dataset('rs1').set('vertspectrum', 'an1');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Maximum Displacement, Response Spectrum');
model.result('pg4').set('data', 'rs1');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'w');
model.result('pg4').feature('surf1').set('unit', 'mm');
model.result('pg4').feature('surf1').set('colortable', 'Prism');
model.result('pg4').run;

model.physics('solid').create('bex1', 'BaseExcitation', -1);
model.physics('solid').feature('bex1').set('ab', {'0' '0' '50*g_const'});

model.study.create('std2');
model.study('std2').setGenPlots(false);
model.study('std2').create('timod', 'Transientmodal');
model.study('std2').feature('timod').set('tunit', 'ms');
model.study('std2').feature('timod').set('tlist', 'range(0,0.5,60)');
model.study('std2').feature('timod').set('usertol', true);
model.study('std2').feature('timod').set('rtol', '0.0001');
model.study('std2').feature('timod').set('loadfact', 'sin(2*pi/22[ms]*t)*(t<11[ms])');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'timod');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3707859894871974');
model.sol('sol2').feature('v1').set('control', 'timod');
model.sol('sol2').create('mo1', 'Modal');
model.sol('sol2').feature('mo1').set('analysistype', 'transient');
model.sol('sol2').feature('mo1').set('tlist', 'range(0,0.5,60)');
model.sol('sol2').feature('mo1').set('control', 'timod');
model.sol('sol2').feature('v1').set('resscalemethod', 'manual');
model.sol('sol2').feature('mo1').set('control', 'timod');
model.sol('sol2').feature('mo1').feature('aDef').set('cachepattern', true);
model.sol('sol2').attach('std2');
model.sol('sol2').feature('mo1').set('eigsol', 'sol1');
model.sol('sol2').feature('mo1').set('dampratio', 0.05);
model.sol('sol2').feature('mo1').set('storeudot', false);
model.sol('sol2').runAll;

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').run;
model.result('pg5').label('Maximum Displacement, Time History');
model.result('pg5').set('data', 'dset2');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'timemax(0,60[ms],abs(w))');
model.result('pg5').feature('surf1').set('unit', 'mm');
model.result('pg5').feature('surf1').set('colortable', 'Prism');
model.result('pg5').run;
model.result('pg5').set('titletype', 'manual');
model.result('pg5').set('title', 'Surface: timemax(0, 50[ms], abs(w)) (m)');
model.result('pg5').set('paramindicator', '');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Displacement, Time');
model.result('pg6').set('data', 'dset2');
model.result('pg6').setIndex('looplevel', 23, 0);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'w');
model.result('pg6').feature('surf1').set('unit', 'mm');
model.result('pg6').feature('surf1').create('def1', 'Deform');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg6').feature('surf1').feature('def1').set('scale', 1);
model.result('pg6').run;
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
model.result.export('anim1').set('plotgroup', 'pg6');
model.result.export('anim1').set('maxframes', 100);
model.result.export('anim1').showFrame;
model.result.export('anim1').run;
model.result.create('pg7', 'PlotGroup3D');
model.result('pg7').run;
model.result('pg7').label('Stress, Response Spectrum');
model.result('pg7').set('data', 'rs1');
model.result('pg7').selection.geom('geom1', 3);
model.result('pg7').selection.geom('geom1', 3);
model.result('pg7').selection.set([1]);
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', 'solid.mises');
model.result('pg7').feature('surf1').set('unit', 'MPa');
model.result('pg7').feature('surf1').set('rangecoloractive', true);
model.result('pg7').feature('surf1').set('rangecolormax', 150);
model.result('pg7').feature('surf1').set('colortable', 'Prism');
model.result('pg7').run;
model.result('pg4').run;

model.title('Shock Response of a Motherboard');

model.description(['Electronic equipment often has to certified to function after having been subjected to a specified shock load. In this example, the effect of a 50' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'g, 11' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'ms half sine shock on a circuit board is investigated using response spectrum analysis.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('motherboard_shock_response.mph');

model.modelNode.label('Components');

out = model;
