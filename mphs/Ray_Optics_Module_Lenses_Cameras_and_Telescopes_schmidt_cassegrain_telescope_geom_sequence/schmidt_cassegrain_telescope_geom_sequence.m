function out = model
%
% schmidt_cassegrain_telescope_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Lenses_Cameras_and_Telescopes');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').label('Schmidt-Cassegrain Telescope Geometry Sequence');
model.geom('geom1').lengthUnit('mm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('nix', '0.0', 'Global optical axis, x-component');
model.param.set('niy', '0.0', 'Global optical axis, y-component');
model.param.set('niz', '-1.0', 'Global optical axis, z-component');
model.param.set('R1_corr', '0', 'Corrector radius of curvature, surface 1');
model.param.set('R2_corr', '-56118.2800[mm]', 'Corrector radius of curvature, surface 2');
model.param.set('A04_corr', '6.431005e-10', 'Corrector 4th order aspheric term, surface 2');
model.param.set('A06_corr', '3.113976e-16', 'Corrector 6th order aspheric term, surface 2');
model.param.set('Tc_corr', '4.0000[mm]', 'Corrector central thickness');
model.param.set('d0_corr', '210.0000[mm]', 'Corrector outer diameter');
model.param.set('R_sec', '252.6581[mm]', 'Secondary mirror radius of curvature');
model.param.set('d0_sec', '60.0000[mm]', 'Secondary mirror outer diameter');
model.param.set('dc_sec', '53.9204[mm]', 'Secondary mirror clear diameter');
model.param.set('Tc_sec', '7.0000[mm]', 'Secondary mirror central thickness');
model.param.set('z_sec', '7.0000[mm]', 'Secondary mirror z-coordinate, relative to corrector surface 2');
model.param.set('R_prim', '-812.8000[mm]', 'Primary mirror radius of curvature');
model.param.set('d0_prim', '215.0000[mm]', 'Primary mirror outer diameter');
model.param.set('d1_prim', '206.1674[mm]', 'Primary mirror surface diameter');
model.param.set('dh_prim', '50.0000[mm]', 'Primary mirror hole diameter');
model.param.set('Tc_prim', '20.0000[mm]', 'Primary mirror central thickness');
model.param.set('z_prim', '-303.8701[mm]', 'Primary mirror z-coordinate, relative to secondary mirror');
model.param.set('d_img', '40.0000[mm]', 'Image plane diameter');
model.param.set('z_img', '200.0000[mm]', 'Image plane z-coordinate, relative to primary mirror vertex');
model.param.set('d_obs', '70.0000[mm]', 'Central obstruction diameter');
model.param.set('z_obs', '-10.0000[mm]', 'Central obstruction z-coordinate, relative to corrector surface 1');

model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Aspheric_Lenses/aspheric_even_lens_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').label('Corrector');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R1', 'R1_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R2', 'R2_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'k1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'k2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A_norm', '1[mm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A02_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A04_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A06_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A08_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A10_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A12_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A14_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A16_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A18_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A20_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A22_1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A02_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A04_2', 'A04_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A06_2', 'A06_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A08_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A10_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A12_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A14_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A16_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A18_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A20_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'A22_2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', 'Tc_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'd0_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1_clear', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2_clear', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 'nix');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 'niy');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 'niz');
model.geom.load({'part2'}, 'Ray_Optics_Module/3D/Mirrors/spherical_mirror_3d.mph', {'part1'});
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').label('Secondary mirror');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'R', 'R_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'Tc', 'Tc_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd0', 'd0_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_clear', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_hole', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niz', -1);
model.geom('geom1').feature('pi2').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi2').set('workplane', 'wp2');
model.geom('geom1').feature('pi2').set('displ', {'0' '0' 'z_sec'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part2');
model.geom('geom1').feature('pi3').label('Primary mirror');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'R', 'R_prim');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'Tc', 'Tc_prim');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd0', 'd0_prim');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd1', 'd1_prim');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_clear', 0);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd_hole', 'dh_prim');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'niz', -1);
model.geom('geom1').feature('pi3').set('workplanesrc', 'pi2');
model.geom('geom1').feature('pi3').set('workplane', 'wp1');
model.geom('geom1').feature('pi3').set('displ', {'0' '0' 'z_prim'});
model.geom.load({'part3'}, 'Ray_Optics_Module/3D/Apertures_and_Obstructions/circular_planar_annulus.mph', {'part1'});
model.geom('geom1').run('pi3');
model.geom('geom1').create('pi4', 'PartInstance');
model.geom('geom1').feature('pi4').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi4').set('part', 'part3');
model.geom('geom1').feature('pi4').label('Image plane');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd0', 'd_img');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi4').set('workplanesrc', 'pi3');
model.geom('geom1').feature('pi4').set('workplane', 'wp1');
model.geom('geom1').feature('pi4').set('displ', {'0' '0' 'z_img'});
model.geom('geom1').run('pi4');
model.geom('geom1').create('pi5', 'PartInstance');
model.geom('geom1').feature('pi5').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi5').set('part', 'part3');
model.geom('geom1').feature('pi5').label('Central obstruction');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd0', 'd_obs');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi5').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi5').set('workplane', 'wp1');
model.geom('geom1').feature('pi5').set('displ', {'0' '0' 'z_obs'});
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_sel1', true);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Clear Apertures');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel3', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel3', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel4', 'csel1');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Obstructions');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel5', 'csel2');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel5', 'csel2');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel6', 'csel2');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel7', 'csel2');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Mirrors');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel1', 'csel3');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel1', 'csel3');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel2', 'csel2');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_comsel2', 'csel2');
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_cylsel1', 'csel3');
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_cylsel2', 'csel2');
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_comsel2', 'csel2');
model.geom('geom1').feature('pi4').setEntry('selkeepbnd', 'pi4_sel1', true);
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel1', 'csel2');

model.title([]);

model.description('');

model.label('schmidt_cassegrain_telescope_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
