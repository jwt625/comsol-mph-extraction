function out = model
%
% submarine_cable_03_bonding_capacitive.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Tutorials,_Cables');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').setSolveFor('/physics/ec', true);

model.param.label('Geometric Parameters 1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Dcon', '26.2[mm]', 'Diameter of main conductors (phase)');
model.param.set('Tins', '24.0[mm]', 'Insulation thickness (XLPE)');
model.param.set('Dins', '77.6[mm]', 'Diameter over insulation (XLPE and SCC)');
model.param.set('Tscc', '(Dins/2-Dcon/2-Tins)/2', 'Semi-conductive compound thickness');
model.param.set('Tpbs', '2.9[mm]', 'Lead sheath thickness');
model.param.set('Tpe', '2.9[mm]', 'Polyethylene sheath thickness');
model.param.set('Dpha', 'Dins+2*Tpbs+2*Tpe', 'Diameter over phase (including sheath and PE)');
model.param.set('Dpha3', 'Dpha*(2/sqrt(3)+1)', 'Diameter over three phases combined');
model.param.set('Dfic', '2.5[mm]', 'Diameter of fiber optic core');
model.param.set('Tfih', '0.5[mm]', 'Steel helix thickness (fiber)');
model.param.set('Dfib', '9.2[mm]', 'Diameter over fiber optic cable');
model.param.set('Dcab', '219.0[mm]', 'Outer diameter of submarine cable');
model.param.set('Darm', '(Dcab+Dpha3)/2', 'Central diameter of armor ring');
model.param.set('Tarm', '5.6[mm]', 'Armor thickness (wire diameter)');
model.param.set('Narm', '110', 'Number of armor wires in ring');
model.param.set('mfil', '0.5[mm]', 'Filler margin');
model.param.set('marm', 'pi*Darm/Narm-Tarm', 'Armor margin');
model.param.create('par2');
model.param('par2').label('Geometric Parameters 2');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('Acon', '500[mm^2]', 'Cross sectional area of main conductors (per phase)');
model.param('par2').set('Ncon', 'Acon/(pi*(Dcon/2)^2)', 'Conductor packing density (phase)');
model.param('par2').set('Apbs', 'pi*(Dins+Tpbs)*Tpbs', 'Cross sectional area of lead sheath (per phase)');
model.param('par2').set('Lsec1', '1/3', 'Relative length cross bonding section 1');
model.param('par2').set('Lsec2', '1-Lsec1-Lsec3', 'Relative length cross bonding section 2');
model.param('par2').set('Lsec3', '1/3', 'Relative length cross bonding section 3');
model.param('par2').set('Lcab', '10[km]', 'Total length of submarine cable');
model.param('par2').set('Scab', '1e5', 'Geometric scale factor (2Daxi model)');
model.param.create('par3');
model.param('par3').label('Electromagnetic Parameters');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('f0', '50[Hz]', 'Operating frequency');
model.param('par3').set('w0', '(2*pi*f0[1/Hz])[rad/s]', 'Angular frequency');
model.param('par3').set('V0', '220[kV]/sqrt(3)', 'Phase to ground voltage (amplitude)');
model.param('par3').set('I0', '655[A]*sqrt(2)', 'Rated current (amplitude)');
model.param('par3').set('Scup', '5.96e7[S/m]', ['Copper conductivity, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C']);
model.param('par3').set('Spbs', '4.55e6[S/m]', ['Lead sheath conductivity, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C']);
model.param('par3').set('Sarm', '4.03e6[S/m]', ['Armor wire conductivity, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C']);
model.param('par3').set('Mcup', '1', 'Relative permeability, copper');
model.param('par3').set('Mpbs', '1', 'Relative permeability, lead sheath');
model.param('par3').set('Marm', '100-50*j', 'Relative permeability, armor wires');
model.param('par3').set('Dscup', 'min(1/real(sqrt(j*w0*mu0_const*Mcup*Scup)),Dcon/3)', 'Skin depth, copper (analytic)');
model.param('par3').set('Dspbs', 'min(1/real(sqrt(j*w0*mu0_const*Mpbs*Spbs)),12*Tpbs)', 'Skin depth, lead sheath (analytic)');
model.param('par3').set('Dsarm', 'min(1/real(sqrt(j*w0*mu0_const*Marm*Sarm)),Tarm/2)', 'Skin depth, armor wires (analytic)');
model.param('par3').set('Rcon', '1/Acon/Scup', ['Main conductor DC resistance per phase, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C (analytic)']);
model.param('par3').set('Rpbs', '1/Apbs/Spbs', ['Lead sheath DC resistance per phase, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C (analytic)']);
model.param('par3').set('Exlpe', '2.5', 'Relative permittivity XLPE (from IEC 60287)');
model.param('par3').set('Cpha', '2*pi*epsilon0_const*Exlpe/log((Dins/2-Tscc)/(Dcon/2+Tscc))', 'Capacitance per phase (analytic)');
model.param('par3').set('Icpha', 'w0*Cpha*V0', 'Charging current per phase (analytic)');

model.coordSystem.create('sys2', 'geom1', 'Scaling');

model.geom('geom1').run;

model.coordSystem('sys2').selection.all;
model.coordSystem('sys2').setIndex('map', 'Scab*z', 2);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'Dins/2+Tpbs-Dcon/2' '1'});
model.geom('geom1').feature('r1').setIndex('size', 'Lcab/Scab', 1);
model.geom('geom1').feature('r1').set('pos', {'Dcon/2' '0'});
model.geom('geom1').feature.duplicate('r2', 'r1');
model.geom('geom1').feature('r2').setIndex('layer', 'Tscc', 0);
model.geom('geom1').feature('r2').setIndex('layer', 'Tins', 1);
model.geom('geom1').feature('r2').setIndex('layer', 'Tscc', 2);
model.geom('geom1').feature('r2').set('layerleft', true);
model.geom('geom1').feature('r2').set('layerbottom', false);
model.geom('geom1').run('fin');

model.view('view1').set('showmaterial', true);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Semiconductive compound');
model.material('mat1').set('color', 'black');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('Cross-linked polyethylene (XLPE)');
model.material('mat2').selection.set([2]);
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Lead');
model.material('mat3').selection.set([4]);
model.material('mat3').set('family', 'lead');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'2[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'2.25'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'1e-18[S/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'Exlpe'});
model.material('mat3').propertyGroup('def').set('electricconductivity', {'Spbs'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1'});

model.physics('ec').create('cucn2', 'CurrentConservation', 2);
model.physics('ec').feature('cucn2').selection.set([4]);
model.physics('ec').feature('cucn2').set('sigma_mat', 'userdef');
model.physics('ec').feature('cucn2').set('sigma', {'Spbs/Scab' '0' '0' '0' 'Spbs' '0' '0' '0' 'Spbs'});
model.physics('ec').create('gnd1', 'Ground', 1);
model.physics('ec').feature('gnd1').selection.set([11]);
model.physics('ec').create('pot1', 'ElectricPotential', 1);
model.physics('ec').feature('pot1').label('Phase 1');
model.physics('ec').feature('pot1').selection.set([1]);
model.physics('ec').feature('pot1').set('V0', '(V0-(I0*Rcon*sys2.z))');

model.study('std1').feature('freq').set('plist', 'f0');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 1, 0);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Dipole');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('expr', {'ec.Er' 'ec.Ez'});
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.02);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'DipoleDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Electric Potential, Revolved Geometry (ec)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'rev1');
model.result('pg2').setIndex('looplevel', 1, 0);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom2/pdef1/pcond2/pcond3/pcond1/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('colortable', 'Dipole');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Electric Field Norm (ec)');
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 1, 0);
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom3/pdef1/pcond2/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'ec.normE');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('surf1').set('colorcalibration', -0.8);
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('solutionparams', 'parent');
model.result('pg3').feature('str1').set('expr', {'ec.Er' 'ec.Ez'});
model.result('pg3').feature('str1').set('titletype', 'none');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('udist', 0.02);
model.result('pg3').feature('str1').set('maxlen', 0.4);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('inheritcolor', false);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13]);
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'ec.normE');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('str1').feature.create('filt1', 'Filter');
model.result('pg3').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Electric Potential Norm, 1D (ec)');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg4').feature('lngr1').set('linewidth', 'preference');
model.result('pg4').feature('lngr1').selection.set([13]);
model.result('pg4').feature('lngr1').set('expr', 'abs(V)');
model.result('pg4').feature('lngr1').set('descractive', true);
model.result('pg4').feature('lngr1').set('descr', 'Voltage raise across lead sheath');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'sys2.z');
model.result('pg4').feature('lngr1').set('xdataunit', 'km');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Electric Current Norm, 1D (ec)');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').selection.set([13]);
model.result('pg5').feature('lngr1').set('expr', 'ec.normJ*Apbs');
model.result('pg5').feature('lngr1').set('descractive', true);
model.result('pg5').feature('lngr1').set('descr', 'Charging current through lead sheath');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'sys2.z');
model.result('pg5').feature('lngr1').set('xdataunit', 'km');
model.result('pg5').run;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').label('Resistive Losses');
model.result.numerical('int1').selection.all;
model.result.numerical('int1').setIndex('expr', 'ec.Qh*Scab', 0);
model.result.numerical('int1').setIndex('descr', 'Resistive losses', 0);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Resistive Losses');
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').setResult;

model.physics('ec').feature('gnd1').selection.set([11 12]);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').appendResult;

model.geom('geom1').feature('r1').setIndex('layer', 'Lsec1*Lcab/Scab', 0);
model.geom('geom1').feature('r1').setIndex('layer', 'Lsec2*Lcab/Scab', 1);
model.geom('geom1').run('fin');

model.physics('ec').feature('pot1').selection.set([5]);
model.physics('ec').create('pot2', 'ElectricPotential', 1);
model.physics('ec').feature('pot2').label('Phase 2');
model.physics('ec').feature('pot2').selection.set([3]);
model.physics('ec').feature('pot2').set('V0', '(V0-(I0*Rcon*sys2.z))*exp(-120[deg]*j)');
model.physics('ec').create('pot3', 'ElectricPotential', 1);
model.physics('ec').feature('pot3').label('Phase 3');
model.physics('ec').feature('pot3').selection.set([1]);
model.physics('ec').feature('pot3').set('V0', '(V0-(I0*Rcon*sys2.z))*exp(+120[deg]*j)');
model.physics('ec').create('ein2', 'ElectricInsulation', 1);
model.physics('ec').feature('ein2').selection.set([4 6 11 13 18 20]);

model.sol('sol1').study('std1');
model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('str1').active(false);
model.result('pg1').run;
model.result('pg1').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').run;
model.result('pg1').run;

model.view('view2').set('showgrid', false);
model.view('view2').set('showaxisorientation', false);

model.result('pg1').run;
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
model.result.export('anim1').set('sweeptype', 'dde');
model.result.export('anim1').set('maxframes', 6);
model.result.export('anim1').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').run;
model.result.numerical('int1').set('table', 'tbl1');
model.result.numerical('int1').appendResult;
model.result.export('anim1').showFrame;
model.result.export('anim1').set('maxframes', 60);
model.result.export('anim1').set('repeat', 'forever');
model.result('pg1').run;
model.result('pg1').run;

model.view('view2').set('showgrid', true);
model.view('view2').set('showaxisorientation', true);

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('vol1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').run;
model.result('pg3').feature('str1').active(false);
model.result('pg5').run;

model.title(['Submarine Cable 3 ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Bonding Capacitive']);

model.description(['Based on the results from the Capacitive Effects tutorial (the previous tutorial in this series), it is justified to neglect the capacitive coupling between the screens and consider one single isolated phase, together with its screen. As opposed to the Capacitive, Inductive, and Thermal Effects tutorials, this tutorial uses a 2D axisymmetric geometry representing the entire 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'kilometers of cable.' newline  newline 'For several bonding types, the build-up of charging currents and the corresponding losses in the screen are analyzed (verification is included). The model validates the assumption that the high phase potential induces a uniform charging current ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' one that barely depends on the screen potential ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' and so justifies the approach chosen in the Capacitive and Inductive Effects tutorials (chapters 2, and 4).']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('submarine_cable_03_bonding_capacitive.mph');

model.modelNode.label('Components');

out = model;
