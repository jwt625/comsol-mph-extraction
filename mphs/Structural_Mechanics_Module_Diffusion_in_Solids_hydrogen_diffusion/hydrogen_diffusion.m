function out = model
%
% hydrogen_diffusion.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Diffusion_in_Solids');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').model('comp1');
model.physics.create('ts', 'TransportInSolids', 'geom1', {'c'});

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/solid', true);
model.study('std1').feature('time').setSolveFor('/physics/ts', true);

model.param.set('L', '20[mm]');
model.param.descr('L', 'Domain size');
model.param.set('Ld', '10[mm]');
model.param.descr('Ld', 'Defect length');
model.param.set('Hd', '0.4[mm]');
model.param.descr('Hd', 'Defect height');
model.param.label('Geometric Parameters');
model.param.create('par2');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('D', '2e-9[m^2/s]', 'Lattice diffusion coefficient');
model.param('par2').set('N', '1e6[mol/m^3]', 'Lattice site concentration');
model.param('par2').set('OmegaH', '2e-6[m^3/mol]', 'Hydrogen partial molar volume');
model.param('par2').set('T0', '293.15[K]', 'Temperature');
model.param('par2').set('NTrap1', '2[mol/m^3]', 'Trap 1 concentration');
model.param('par2').set('NTrap2', '1[mol/m^3]', 'Trap 2 concentration');
model.param('par2').set('Eb1', '10[kJ/mol]', 'Trap 1 binding energy');
model.param('par2').set('Eb2', '25[kJ/mol]', 'Trap 2 binding energy');
model.param('par2').set('pH', '13', 'Potential of Hydrogen');
model.param('par2').set('Vm', '-0.5[V]', 'Metal potential');
model.param('par2').set('Ve', '-0.025[V]', 'Electrolyte potential');
model.param('par2').set('Veq', '0[V]', 'Equilibrium potential');
model.param('par2').set('K_va', '1e-4[m/s]', 'Volmer forward reaction rate for acidic electrolyte');
model.param('par2').set('K_vb', '1e-8[mol/(m^2*s)]', 'Volmer forward reaction rate for basic electrolyte');
model.param('par2').set('K_ha', '1e-10[m/s]', 'Heyrovsky forward reaction rate for acidic electrolyte');
model.param('par2').set('K_hb', '9e-10[mol/(m^2*s)]', 'Heyrovsky forward reaction rate for basic electrolyte');
model.param('par2').set('K_t', '1e-6[mol/(m^2*s)]', 'Tafel forward reaction rate for acidic electrolyte');
model.param('par2').set('K_a', '1e5[m/s]', 'Absorption forward reaction rate');
model.param('par2').set('K_ar', '9e9[m/s]', 'Absorption backward reaction rate');
model.param('par2').set('alpha_va', '0.48', 'Volmer forward reaction coefficient for acidic electrolyte');
model.param('par2').set('alpha_vb', '0.48', 'Volmer forward reaction coefficient for basic electrolyte');
model.param('par2').set('alpha_ha', '0.33', 'Heyrovsky forward reaction coefficient for acidic electrolyte');
model.param('par2').set('alpha_hb', '0.33', 'Heyrovsky forward reaction coefficient for basic electrolyte');
model.param('par2').set('para', '1', 'Activation parameter');
model.param('par2').set('U0', '2e-2[mm]', 'Prescribed displacement on top boundary');
model.param('par2').label('Model Parameters');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').feature('sq1').set('size', 'L');
model.geom('geom1').feature('sq1').setIndex('layer', 'L/2', 0);
model.geom('geom1').feature('sq1').label('Metal Domain');
model.geom('geom1').run('sq1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Ld' 'Hd'});
model.geom('geom1').feature('r1').set('pos', {'0' '(L-Hd)/2'});
model.geom('geom1').feature('r1').label('Fracture');
model.geom('geom1').run('r1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r1', [2 3]);
model.geom('geom1').feature('fil1').set('radius', 'Hd/2');
model.geom('geom1').feature('fil1').label('Fracture Fillet');
model.geom('geom1').run('fil1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'sq1'});
model.geom('geom1').feature('dif1').selection('input2').set({'fil1'});
model.geom('geom1').feature('dif1').label('Remove Fracture');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Iron');
model.material('mat1').set('family', 'iron');
model.material('mat1').propertyGroup('def').set('relpermeability', {'4000' '0' '0' '0' '4000' '0' '0' '0' '4000'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]' '0' '0' '0' '1.12e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]' '0' '0' '0' '12.2e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7870[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]' '0' '0' '0' '76.2[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.29');

model.physics('solid').create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([6]);
model.physics('solid').feature('disp1').setIndex('Direction', 'prescribed', 1);
model.physics('solid').feature('disp1').setIndex('U0', 'U0', 1);
model.physics('solid').feature('disp1').label('Prescribed Displacement: Top');
model.physics('solid').create('roll1', 'Roller', 1);
model.physics('solid').feature('roll1').selection.set([2 8 9]);

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', '(NT/N)*exp(Eb/(R_const*T0))/((1+(max(cl,0)/N)*exp(Eb/(R_const*T0)))^2)');
model.func('an1').set('args', 'cl, NT, Eb');
model.func('an1').set('fununit', '1');
model.func('an1').setIndex('argunit', 'mol/m^3', 0);
model.func('an1').setIndex('argunit', 'mol/m^3', 1);
model.func('an1').setIndex('argunit', 'kJ/mol', 2);
model.func('an1').set('funcname', 'trapFun');
model.func('an1').label('Trap Contribution');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('D_sigma', 'D*c*OmegaH/(R_const*T0)', 'Stress-related diffusion coefficient');
model.variable('var1').set('srcCoeff', 'trapFun(c, NTrap1, Eb1)+trapFun(c, NTrap2, Eb2)', 'Source coefficient');
model.variable('var1').set('J_va', '(1-theta)*(K_va*cHp*exp(-alpha_va*eta)+K_vb*exp(-alpha_vb*eta))', 'Forward reaction contribution to influx');
model.variable('var1').set('J_vap', 'theta*(K_ha*cHp*exp(-alpha_ha*eta)+K_hb*exp(-alpha_hb*eta)+2*K_t*theta)', 'Backward reaction contribution to influx');
model.variable('var1').set('J_influx', 'J_va-J_vap', 'Net boundary flux');
model.variable('var1').set('cHp', '10^(3-pH)[mol/m^3]', 'H+ concentration at interface');
model.variable('var1').set('Vo', 'Vm-Veq-Ve', 'Overpotential');
model.variable('var1').set('eta', 'Vo*F_const/(R_const*T0)', 'Help variable');
model.variable('var1').set('theta', 'c/(K_a/K_ar*(N-c)+c)', 'Help variable');

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').set([1 3 4 5 10 11]);
model.selection('sel1').label('Influx Boundary Selection');

model.physics('ts').feature('solid1').set('D_c', {'D' '0' '0' '0' 'D' '0' '0' '0' 'D'});
model.physics('ts').feature('solid1').create('extfl1', 'ExternalFlux', 2);
model.physics('ts').feature('solid1').feature('extfl1').set('DeformedGeometryModel', 'material');
model.physics('ts').feature('solid1').feature('extfl1').setIndex('J0_material', {'D_sigma*d(-solid.pm,X)*para' '0' '0'}, 0);
model.physics('ts').feature('solid1').feature('extfl1').setIndex('J0_material', {'D_sigma*d(-solid.pm,X)*para' 'D_sigma*d(-solid.pm,Y)*para' '0'}, 0);
model.physics('ts').create('src1', 'Source', 2);
model.physics('ts').feature('src1').selection.set([1 2]);
model.physics('ts').feature('src1').setIndex('S', '-srcCoeff*cTIME', 0);
model.physics('ts').feature('src1').label('Source: Hydrogen Traps');
model.physics('ts').create('fl1', 'FluxBoundary', 1);
model.physics('ts').feature('fl1').selection.named('sel1');
model.physics('ts').feature('fl1').setIndex('J0', 'J_influx', 0);

model.mesh('mesh1').create('fq1', 'FreeQuad');
model.mesh('mesh1').feature('fq1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('fq1').selection.set([2]);
model.mesh('mesh1').feature('fq1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('fq1').feature('dis1').selection.set([5]);
model.mesh('mesh1').feature('fq1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('fq1').feature('dis1').set('elemcount', 40);
model.mesh('mesh1').feature('fq1').feature('dis1').set('elemratio', 2);
model.mesh('mesh1').feature('fq1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('fq1').feature('dis2').selection.set([7]);
model.mesh('mesh1').feature('fq1').feature('dis2').set('type', 'predefined');
model.mesh('mesh1').feature('fq1').feature('dis2').set('elemcount', 60);
model.mesh('mesh1').feature('fq1').feature('dis2').set('elemratio', 10);
model.mesh('mesh1').feature('fq1').feature('dis2').set('growthrate', 'exponential');
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').create('cpd1', 'CopyDomain');
model.mesh('mesh1').feature('cpd1').selection('source').set([2]);
model.mesh('mesh1').feature('cpd1').selection('destination').set([1]);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tunit', 'min');
model.study('std1').feature('time').set('tlist', '0 10^{range(log10(1/60),1/10,log10(120))} 120');
model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').setIndex('pname', 'alpha_ha', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'alpha_ha', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', '', 0);
model.study('std1').feature('param').setIndex('pname', 'para', 0);
model.study('std1').feature('param').setIndex('plistarr', '0 1', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.0282842712474619');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 10^{range(log10(1/60),1/10,log10(120))} 120');
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
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'para'});
model.batch('p1').set('plistarr', {'0 1'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 41, 0);
model.result('pg1').setIndex('looplevel', 2, 1);
model.result('pg1').set('defaultPlotID', 'stress');
model.result('pg1').label('Stress (solid)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.misesGp'});
model.result('pg1').feature('surf1').set('threshold', 'manual');
model.result('pg1').feature('surf1').set('thresholdvalue', 0.2);
model.result('pg1').feature('surf1').set('colortable', 'Rainbow');
model.result('pg1').feature('surf1').set('colortabletrans', 'none');
model.result('pg1').feature('surf1').set('colorscalemode', 'linear');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').setIndex('looplevel', 41, 0);
model.result('pg2').setIndex('looplevel', 2, 1);
model.result('pg2').label('Transported Quantity (ts)');
model.result('pg2').set('titletype', 'custom');
model.result('pg2').set('prefixintitle', '');
model.result('pg2').set('expressionintitle', false);
model.result('pg2').set('typeintitle', true);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'ts.c'});
model.result('pg2').create('str1', 'Streamline');
model.result('pg2').feature('str1').set('expr', {'ts.tflux_cx' 'ts.tflux_cy'});
model.result('pg2').feature('str1').set('posmethod', 'uniform');
model.result('pg2').feature('str1').set('recover', 'pprint');
model.result('pg2').feature('str1').set('pointtype', 'arrow');
model.result('pg2').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('str1').set('color', 'gray');
model.result('pg1').run;
model.result('pg1').label('Hydrostatic Stress');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Hydrostatic stress (MPa) and hydrogen flux (mol/m<sup>2</sup>s)');
model.result('pg1').set('paramindicator', 'Time=eval(t,min) min');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', '-solid.pm');
model.result('pg1').feature('surf1').set('unit', 'MPa');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg1').feature('surf1').feature('def').set('scale', 100);
model.result('pg1').run;
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').feature('str1').set('expr', {'ts.extflux_cx' 'v'});
model.result('pg1').feature('str1').setIndex('expr', 'ts.extflux_cy', 1);
model.result('pg1').run;
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Hydrogen concentration (mol/m<sup>3</sup>)');
model.result('pg2').set('paramindicator', 'Time=eval(t,min) min');
model.result('pg2').label('Concentration');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('colortable', 'Prism');
model.result('pg2').run;
model.result('pg2').feature('str1').set('color', 'black');
model.result('pg2').feature('str1').set('arrowlength', 'normalized');
model.result('pg2').feature('str1').set('inheritplot', 'surf1');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').set('data', 'dset2');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Diffusive and stress-induced flux');
model.result('pg3').set('paramindicator', 'Time=eval(t,min) min');
model.result('pg3').label('Diffusive and Stress-Induced Flux');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('expr', {'ts.extflux_cx' 'v'});
model.result('pg3').feature('str1').setIndex('expr', 'ts.extflux_cy', 1);
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature.duplicate('str2', 'str1');
model.result('pg3').run;
model.result('pg3').feature('str2').setIndex('expr', 'ts.dflux_cx', 0);
model.result('pg3').feature('str2').setIndex('expr', 'ts.dflux_cy', 1);
model.result('pg3').feature('str2').set('color', 'red');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').set('data', 'dset2');
model.result('pg4').setIndex('looplevelinput', 'last', 0);
model.result('pg4').set('titletype', 'none');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Distance from crack tip (mm)');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Hydrogen concentration (mol/m<sup>3</sup>)');
model.result('pg4').label('Hydrogen Concentration in Metal');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([7]);
model.result('pg4').feature('lngr1').set('expr', 'c');
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', 'Without stress-driven diffusion', 0);
model.result('pg4').feature('lngr1').setIndex('legends', 'With stress-driven diffusion', 1);
model.result('pg4').feature('lngr1').set('linemarker', 'cycle');
model.result('pg4').feature('lngr1').set('markerpos', 'interp');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Hydrogen concentration (mol/m<sup>3</sup>)');
model.result('pg5').label('Hydrogen Concentration at Crack Tip');
model.result('pg5').set('legendpos', 'lowerright');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([7]);
model.result('pg5').feature('ptgr1').set('expr', 'c');
model.result('pg5').feature('ptgr1').set('linemarker', 'cycle');
model.result('pg5').feature('ptgr1').set('markerpos', 'interp');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'Without stress-driven diffusion', 0);
model.result('pg5').feature('ptgr1').setIndex('legends', 'With stress-driven diffusion', 1);
model.result('pg5').run;

model.title('Hydrogen Diffusion in Metals');

model.description('This model shows how to simulate hydrogen uptake and diffusion in aqueous electrolytes. It uses the Transport in Solids interface to model both concentration-driven and stress-driven diffusion.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;

model.label('hydrogen_diffusion.mph');

model.modelNode.label('Components');

out = model;
