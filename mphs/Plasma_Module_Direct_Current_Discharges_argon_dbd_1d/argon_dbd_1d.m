function out = model
%
% argon_dbd_1d.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Plasma_Module/Direct_Current_Discharges');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('plas', 'ColdPlasma', 'geom1');
model.physics('plas').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/plas', true);

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').set('left', '-1e-4');
model.geom('geom1').feature('i1').setIndex('len', '1e-4', 0);
model.geom('geom1').feature('i1').setIndex('len', '1e-4', 1);
model.geom('geom1').feature('i1').setIndex('len', '1e-4', 2);
model.geom('geom1').runPre('fin');

model.param.set('f0', '50e3[Hz]');
model.param.descr('f0', 'RF Frequency');
model.param.set('w0', '2*pi*f0');
model.param.descr('w0', 'Angular frequency');
model.param.set('dplate', '0.1[m]');
model.param.descr('dplate', 'Plate diameter');
model.param.set('As', '0.25*pi*dplate^2');
model.param.descr('As', 'Plate area');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').set('Vrf', '-750[V]*sin(w0*t)');
model.variable('var1').descr('Vrf', 'Applied voltage');

model.physics('plas').create('ccn1', 'ChargeConservation', 1);
model.physics('plas').feature('ccn1').selection.set([1 3]);
model.physics('plas').create('xsec1', 'CrossSectionImport', -1);
model.physics('plas').feature('xsec1').set('Filepath', 'Ar_xsecs.txt');
model.physics('plas').feature('xsec1').runCommand('importData');
model.physics('plas').prop('CrossSectionArea').set('A', 'As');
model.physics('plas').prop('ElectronProperties').set('ReducedProps', true);
model.physics('plas').create('rxn1', 'Reaction', 1);
model.physics('plas').feature('rxn1').set('formula', 'Ars+Ars=>e+Ar+Ar+');
model.physics('plas').feature('rxn1').set('kf', '3.3734e8');
model.physics('plas').create('rxn2', 'Reaction', 1);
model.physics('plas').feature('rxn2').set('formula', 'Ars+Ar=>Ar+Ar');
model.physics('plas').feature('rxn2').set('kf', 1807);
model.physics('plas').feature('Ar').set('FromMassConstraint', true);
model.physics('plas').feature('Ar').set('PresetSpeciesData', 'Ar');
model.physics('plas').feature('Ars').set('x0', '1e-11');
model.physics('plas').feature('Ars').set('PresetSpeciesData', 'Ar');
model.physics('plas').feature('Ar_1p').set('InitIon', true);
model.physics('plas').feature('Ar_1p').set('PresetSpeciesData', 'Ar');
model.physics('plas').feature('pes1').set('SpecifyElectronDensityAndEnergy', 'FromElectronImpact');
model.physics('plas').feature('pes1').set('T', '400[K]');
model.physics('plas').feature('init1').set('neinit', '1e6');
model.physics('plas').feature('init1').set('ebarinit', 5);
model.physics('plas').create('sr1', 'SurfaceReaction', 0);
model.physics('plas').feature('sr1').selection.set([2]);
model.physics('plas').feature('sr1').set('formula', 'Ar+=>Ar');
model.physics('plas').feature('sr1').set('gammai', 0.01);
model.physics('plas').feature('sr1').set('ebari', 2.5);
model.physics('plas').create('sr2', 'SurfaceReaction', 0);
model.physics('plas').feature('sr2').selection.set([3]);
model.physics('plas').feature('sr2').set('formula', 'Ar+=>Ar');
model.physics('plas').feature('sr2').set('gammai', '1E-6');
model.physics('plas').feature('sr2').set('ebari', 2.5);
model.physics('plas').create('sr3', 'SurfaceReaction', 0);
model.physics('plas').feature('sr3').selection.set([2 3]);
model.physics('plas').feature('sr3').set('formula', 'Ars=>Ar');
model.physics('plas').create('wall1', 'WallDriftDiffusion', 0);
model.physics('plas').feature('wall1').selection.set([2 3]);
model.physics('plas').create('sca1', 'SurfaceChargeAccumulation', 0);
model.physics('plas').feature('sca1').selection.set([2 3]);
model.physics('plas').create('gnd1', 'Ground', 0);
model.physics('plas').feature('gnd1').selection.set([4]);
model.physics('plas').create('term1', 'Terminal', 0);
model.physics('plas').feature('term1').selection.set([1]);
model.physics('plas').feature('term1').set('TerminalName', 'electrode');
model.physics('plas').feature('term1').set('V0', 'Vrf');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Dielectric 1');
model.material('mat1').selection.set([1 3]);
model.material('mat1').propertyGroup('def').set('relpermittivity', {'10'});

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').selection.set([2]);
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 200);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 5);
model.mesh('mesh1').feature('edg1').feature('dis1').set('growthrate', 'exponential');
model.mesh('mesh1').feature('edg1').feature('dis1').set('symmetric', true);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5.0e-7,1.0e-4)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5.0e-7,1.0e-4)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('atolglobalmethod', 'unscaled');
model.sol('sol1').feature('t1').set('atolglobal', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1.0E-13)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('matherr', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1 2 3]);
model.result('pg1').feature('lngr1').set('expr', {'plas.ne'});
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1 2 3]);
model.result('pg2').feature('lngr1').set('expr', {'plas.Te'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2 3]);
model.result('pg3').feature('lngr1').set('expr', {'V'});
model.result('pg1').label('Electron Density (plas)');
model.result('pg2').label('Electron Temperature (plas)');
model.result('pg3').label('Electric Potential (plas)');
model.result('pg1').run;
model.result.dataset.create('par1', 'Parametric1D');
model.result.dataset('par1').set('seplevels', false);
model.result.dataset('par1').set('levelscale', '50e3');
model.result.dataset.duplicate('par2', 'par1');
model.result.dataset('par2').setIndex('looplevelinput', 'manual', 0);
model.result.dataset('par2').setIndex('looplevel', [21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201], 0);
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').run;
model.result('pg4').label('Excited Argon Mass Fraction');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'plas.wArs');
model.result('pg4').feature('surf1').set('descr', 'Mass fraction');
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Electric Potential');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('expr', 'V');
model.result('pg5').feature('surf1').set('descr', 'Electric potential');
model.result('pg5').feature('surf1').set('colortable', 'Dipole');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').run;
model.result.duplicate('pg6', 'pg5');
model.result('pg6').run;
model.result('pg6').label('Electric Field');
model.result('pg6').run;
model.result('pg6').feature('surf1').set('expr', 'plas.Ex');
model.result('pg6').feature('surf1').set('descr', 'Electric field, x-component');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').label('Electron Density');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('expr', 'plas.ne');
model.result('pg7').feature('surf1').set('descr', 'Electron density');
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').run;
model.result.duplicate('pg8', 'pg7');
model.result('pg8').run;
model.result('pg8').label('Mean Electron Energy');
model.result('pg8').run;
model.result('pg8').feature('surf1').set('expr', 'plas.ebar');
model.result('pg8').feature('surf1').set('descr', 'Mean electron energy');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').run;
model.result.duplicate('pg9', 'pg8');
model.result('pg9').run;
model.result('pg9').label('Electron Current Density');
model.result('pg9').set('data', 'par2');
model.result('pg9').run;
model.result('pg9').feature('surf1').set('expr', 'plas.Jelx');
model.result('pg9').feature('surf1').set('descr', 'Electron current density, x-component');
model.result('pg9').run;
model.result('pg9').run;
model.result('pg9').run;
model.result.duplicate('pg10', 'pg9');
model.result('pg10').run;
model.result('pg10').label('Argon Ion Current Density');
model.result('pg10').run;
model.result('pg10').feature('surf1').set('expr', 'plas.Jix_wAr_1p');
model.result('pg10').feature('surf1').set('descr', 'Ion current density, x-component');
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').run;
model.result.duplicate('pg11', 'pg10');
model.result('pg11').run;
model.result('pg11').label('Total Conduction Current Density');
model.result('pg11').run;
model.result('pg11').feature('surf1').set('expr', 'plas.Jix_wAr_1p+plas.Jelx');
model.result('pg11').run;
model.result('pg11').run;
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').label('Terminal Current');
model.result('pg12').create('glob1', 'Global');
model.result('pg12').feature('glob1').set('markerpos', 'datapoints');
model.result('pg12').feature('glob1').set('linewidth', 'preference');
model.result('pg12').feature('glob1').set('expr', {'plas.I_electrode'});
model.result('pg12').feature('glob1').set('descr', {'Current, Terminal  electrode'});
model.result('pg12').feature('glob1').set('unit', {'A'});
model.result('pg12').run;
model.result.create('pg13', 'PlotGroup1D');
model.result('pg13').run;
model.result('pg13').label('Total Power Deposition');
model.result('pg13').create('glob1', 'Global');
model.result('pg13').feature('glob1').set('markerpos', 'datapoints');
model.result('pg13').feature('glob1').set('linewidth', 'preference');
model.result('pg13').feature('glob1').set('expr', {'plas.Pcap_tot'});
model.result('pg13').feature('glob1').set('descr', {'Total capacitive power deposition, electrons'});
model.result('pg13').feature('glob1').set('unit', {'W'});
model.result('pg13').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('looplevelinput', 'last', 0);
model.result.numerical('gev1').setIndex('expr', 'timeavg(1e-5,2e-5,plas.Pcap_tot,''nointerp'')', 0);
model.result.numerical('gev1').setIndex('unit', 'W', 0);
model.result.numerical('gev1').setIndex('descr', 'Cycle 2', 0);
model.result.numerical('gev1').setIndex('expr', 'timeavg(2e-5,3e-5,plas.Pcap_tot,''nointerp'')', 1);
model.result.numerical('gev1').setIndex('unit', 'W', 1);
model.result.numerical('gev1').setIndex('descr', 'Cycle 3', 1);
model.result.numerical('gev1').setIndex('expr', 'timeavg(3e-5,4e-5,plas.Pcap_tot,''nointerp'')', 2);
model.result.numerical('gev1').setIndex('unit', 'W', 2);
model.result.numerical('gev1').setIndex('descr', 'Cycle 4', 2);
model.result.numerical('gev1').setIndex('expr', 'timeavg(4e-5,5e-5,plas.Pcap_tot,''nointerp'')', 3);
model.result.numerical('gev1').setIndex('unit', 'W', 3);
model.result.numerical('gev1').setIndex('descr', 'Cycle 5', 3);
model.result.numerical('gev1').setIndex('expr', 'timeavg(5e-5,6e-5,plas.Pcap_tot,''nointerp'')', 4);
model.result.numerical('gev1').setIndex('unit', 'W', 4);
model.result.numerical('gev1').setIndex('descr', 'Cycle 6', 4);
model.result.numerical('gev1').setIndex('expr', 'timeavg(6e-5,7e-5,plas.Pcap_tot,''nointerp'')', 5);
model.result.numerical('gev1').setIndex('unit', 'W', 5);
model.result.numerical('gev1').setIndex('descr', 'Cycle 7', 5);
model.result.numerical('gev1').setIndex('expr', 'timeavg(7e-5,8e-5,plas.Pcap_tot,''nointerp'')', 6);
model.result.numerical('gev1').setIndex('unit', 'W', 6);
model.result.numerical('gev1').setIndex('descr', 'Cycle 8', 6);
model.result.numerical('gev1').setIndex('expr', 'timeavg(8e-5,9e-5,plas.Pcap_tot,''nointerp'')', 7);
model.result.numerical('gev1').setIndex('unit', 'W', 7);
model.result.numerical('gev1').setIndex('descr', 'Cycle 9', 7);
model.result.numerical('gev1').setIndex('expr', 'timeavg(9e-5,10e-5,plas.Pcap_tot,''nointerp'')', 8);
model.result.numerical('gev1').setIndex('unit', 'W', 8);
model.result.numerical('gev1').setIndex('descr', 'Cycle 10', 8);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;

model.title('Dielectric Barrier Discharge');

model.description('This example simulates electrical breakdown in an atmospheric pressure gas. Because electrical breakdown is a complicated process, a 1D model is considered. To highlight the physics of the breakdown process, the example uses a simple argon chemistry, which keeps the number of species and reactions to a minimum.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('argon_dbd_1d.mph');

model.modelNode.label('Components');

out = model;
