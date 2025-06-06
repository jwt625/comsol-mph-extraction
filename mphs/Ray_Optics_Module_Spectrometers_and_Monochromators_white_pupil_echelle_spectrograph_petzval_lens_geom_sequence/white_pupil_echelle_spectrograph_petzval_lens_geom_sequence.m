function out = model
%
% white_pupil_echelle_spectrograph_petzval_lens_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Spectrometers_and_Monochromators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('nix', '0', 'Global optical axis, x-component');
model.param.set('niy', '0', 'Global optical axis, y-component');
model.param.set('niz', '1', 'Global optical axis, z-component');
model.param.set('R1_1', '98.45049[mm]', 'L1, surface 1 radius of curvature');
model.param.set('R2_1', '-83.29386[mm]', 'L1, surface 2 radius of curvature');
model.param.set('Tc_1', '13.000[mm]', 'L1 center thickness');
model.param.set('d0_1', '58.000[mm]', 'L1, outer diameter');
model.param.set('d1_1', '0', 'L1, surface 1 diameter');
model.param.set('d2_1', '0', 'L1, surface 2 diameter');
model.param.set('d1_clear_1', '2*28.478[mm]', 'L1, surface 1 clear aperture diameter');
model.param.set('d2_clear_1', '2*26.267[mm]', 'L1, surface 2 clear aperture diameter');
model.param.set('T_1', '0.000[mm]', 'L1 to L2 spacing');
model.param.set('R1_2', 'R2_1', 'L2, surface 1 radius of curvature');
model.param.set('R2_2', '-1421.38828[mm]', 'L2, surface 2 radius of curvature');
model.param.set('Tc_2', '4.000[mm]', 'L2 center thickness');
model.param.set('d0_2', '58.000[mm]', 'L2, outer diameter');
model.param.set('d1_2', '0', 'L2, surface 1 diameter');
model.param.set('d2_2', '0', 'L2, surface 2 diameter');
model.param.set('d1_clear_2', 'd2_clear_1', 'L2, surface 1 clear aperture diameter');
model.param.set('d2_clear_2', '2*20.020[mm]', 'L2, surface 2 clear aperture diameter');
model.param.set('T_2', '40.000[mm]', 'L2 to Stop spacing');
model.param.set('Tc_3', '0', 'Stop center thickness');
model.param.set('d0_S', 'd0_1', 'Stop maximum diameter');
model.param.set('d1_S', '2*16.631[mm]', 'Stop clear diameter');
model.param.set('T_3', '40.000[mm]', 'Stop to L3 spacing');
model.param.set('R1_4', '59.00613[mm]', 'L3, surface 1 radius of curvature');
model.param.set('R2_4', '-54.36470[mm]', 'L3, surface 2 radius of curvature');
model.param.set('Tc_4', '12.000[mm]', 'L3 center thickness');
model.param.set('d0_4', '45.000[mm]', 'L3, outer diameter');
model.param.set('d1_4', '0', 'L3, surface 1 diameter');
model.param.set('d2_4', '0', 'L3, surface 2 diameter');
model.param.set('d1_clear_4', '2*20.543[mm]', 'L3, surface 1 clear aperture diameter');
model.param.set('d2_clear_4', '2*20.074[mm]', 'L3, surface 2 clear aperture diameter');
model.param.set('T_4', '0.000[mm]', 'L3 to L4 spacing');
model.param.set('R1_5', 'R2_4', 'L4, surface 1 radius of curvature');
model.param.set('R2_5', '-549.36547[mm]', 'L4, surface 2 radius of curvature');
model.param.set('Tc_5', '3.000[mm]', 'L4 center thickness');
model.param.set('d0_5', '45.000[mm]', 'L4, outer diameter');
model.param.set('d1_5', '0', 'L4, surface 1 diameter');
model.param.set('d2_5', '0', 'L4, surface 2 diameter');
model.param.set('d1_clear_5', 'd2_clear_4', 'L4, surface 1 clear aperture diameter');
model.param.set('d2_clear_5', '2*16.492[mm]', 'L4, surface 2 clear aperture diameter');
model.param.set('T_5', '46.82210[mm]', 'L4 to L5 spacing');
model.param.set('R1_6', '-39.80076[mm]', 'L5, surface 1 radius of curvature');
model.param.set('R2_6', '0', 'L5, surface 2 radius of curvature');
model.param.set('Tc_6', '2.000[mm]', 'L5 center thickness');
model.param.set('d0_6', '42.500[mm]', 'L5, outer diameter');
model.param.set('d1_6', '40.000[mm]', 'L5, surface 1 diameter');
model.param.set('d2_6', '0', 'L5, surface 2 diameter');
model.param.set('d1_clear_6', '2*17.297[mm]', 'L5, surface 1 clear aperture diameter');
model.param.set('d2_clear_6', '2*18.940[mm]', 'L5, surface 2 clear aperture diameter');
model.param.set('T_6', '1.9548[mm]', 'L5 to detector spacing (adjusted)');
model.param.set('d0_D', '2*17.904[mm]', ' Detector diameter');

model.geom('geom1').label('Petzval Lens Geometry Sequence');
model.geom('geom1').lengthUnit('mm');
model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Spherical_Lenses/spherical_lens_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').label('Lens 1');
model.geom('geom1').feature('pi1').setEntry('inputname', 'R1', 'R1');
model.geom('geom1').feature('pi1').setEntry('inputname', 'R2', 'R2');
model.geom('geom1').feature('pi1').setEntry('inputname', 'Tc', 'Tc');
model.geom('geom1').feature('pi1').setEntry('inputname', 'd0', 'd0');
model.geom('geom1').feature('pi1').setEntry('inputname', 'd1', 'd1');
model.geom('geom1').feature('pi1').setEntry('inputname', 'd2', 'd2');
model.geom('geom1').feature('pi1').setEntry('inputname', 'd1_clear', 'd1_clear');
model.geom('geom1').feature('pi1').setEntry('inputname', 'd2_clear', 'd2_clear');
model.geom('geom1').feature('pi1').setEntry('inputname', 'nix', 'nix');
model.geom('geom1').feature('pi1').setEntry('inputname', 'niy', 'niy');
model.geom('geom1').feature('pi1').setEntry('inputname', 'niz', 'niz');
model.geom('geom1').feature('pi1').setEntry('inputname', 'n_extra_r', 'n_extra_r');
model.geom('geom1').feature('pi1').setEntry('inputname', 'n_extra_a', 'n_extra_a');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R1', 'R1_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R2', 'R2_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', 'Tc_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'd0_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 'd1_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2', 'd2_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1_clear', 'd1_clear_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2_clear', 'd2_clear_1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 'nix');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 'niy');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 'niz');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_r', '0');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_a', '0');
model.geom('geom1').run('pi1');

model.view('view1').camera.set('projection', 'orthographic');

model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Lens Material 1');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Lens Material 2');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Lens Material 3');
model.geom('geom1').selection.create('csel4', 'CumulativeSelection');
model.geom('geom1').selection('csel4').label('Lens Material 4');
model.geom('geom1').selection.create('csel5', 'CumulativeSelection');
model.geom('geom1').selection('csel5').label('Lens Exteriors');
model.geom('geom1').selection.create('csel6', 'CumulativeSelection');
model.geom('geom1').selection('csel6').label('Clear Apertures');
model.geom('geom1').selection.create('csel7', 'CumulativeSelection');
model.geom('geom1').selection('csel7').label('Obstructions');
model.geom('geom1').selection.create('csel8', 'CumulativeSelection');
model.geom('geom1').selection('csel8').label('Aperture Stop');
model.geom('geom1').selection.create('csel9', 'CumulativeSelection');
model.geom('geom1').selection('csel9').label('Image Plane');
model.geom('geom1').feature('pi1').setEntry('selcontributetodom', 'pi1_sel1', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel2', 'csel5');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel3', 'csel6');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel4', 'csel6');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel5', 'csel7');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel6', 'csel7');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel7', 'csel7');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part1');
model.geom('geom1').feature('pi2').label('Lens 2');
model.geom('geom1').feature('pi2').setEntry('inputname', 'R1', 'R1');
model.geom('geom1').feature('pi2').setEntry('inputname', 'R2', 'R2');
model.geom('geom1').feature('pi2').setEntry('inputname', 'Tc', 'Tc');
model.geom('geom1').feature('pi2').setEntry('inputname', 'd0', 'd0');
model.geom('geom1').feature('pi2').setEntry('inputname', 'd1', 'd1');
model.geom('geom1').feature('pi2').setEntry('inputname', 'd2', 'd2');
model.geom('geom1').feature('pi2').setEntry('inputname', 'd1_clear', 'd1_clear');
model.geom('geom1').feature('pi2').setEntry('inputname', 'd2_clear', 'd2_clear');
model.geom('geom1').feature('pi2').setEntry('inputname', 'nix', 'nix');
model.geom('geom1').feature('pi2').setEntry('inputname', 'niy', 'niy');
model.geom('geom1').feature('pi2').setEntry('inputname', 'niz', 'niz');
model.geom('geom1').feature('pi2').setEntry('inputname', 'n_extra_r', 'n_extra_r');
model.geom('geom1').feature('pi2').setEntry('inputname', 'n_extra_a', 'n_extra_a');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'R1', 'R1_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'R2', 'R2_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'Tc', 'Tc_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd0', 'd0_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd1', 'd1_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd2', 'd2_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd1_clear', 'd1_clear_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd2_clear', 'd2_clear_2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'nix', '0');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niy', '0');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niz', '1');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'n_extra_r', '0');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'n_extra_a', '0');
model.geom('geom1').feature('pi2').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi2').set('workplane', 'wp2');
model.geom('geom1').feature('pi2').set('displ', {'0' '0' 'T_1'});
model.geom('geom1').feature('pi2').setEntry('selcontributetodom', 'pi2_sel1', 'csel2');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_sel2', 'csel5');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_sel3', 'csel6');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_sel4', 'csel6');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_sel5', 'csel7');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_sel6', 'csel7');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_sel7', 'csel7');
model.geom.load({'part2'}, 'Ray_Optics_Module/3D/Apertures_and_Obstructions/circular_planar_annulus.mph', {'part1'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part2');
model.geom('geom1').feature('pi3').label('Stop');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd0', 'd0_S');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd1', 'd1_S');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi3').set('workplanesrc', 'pi2');
model.geom('geom1').feature('pi3').set('workplane', 'wp2');
model.geom('geom1').feature('pi3').set('displ', {'0' '0' 'T_2+Tc_3'});
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_sel1', 'csel8');
model.geom('geom1').run('pi3');
model.geom('geom1').create('pi4', 'PartInstance');
model.geom('geom1').feature('pi4').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi4').set('part', 'part1');
model.geom('geom1').feature('pi4').label('Lens 3');
model.geom('geom1').feature('pi4').setEntry('inputname', 'R1', 'R1');
model.geom('geom1').feature('pi4').setEntry('inputname', 'R2', 'R2');
model.geom('geom1').feature('pi4').setEntry('inputname', 'Tc', 'Tc');
model.geom('geom1').feature('pi4').setEntry('inputname', 'd0', 'd0');
model.geom('geom1').feature('pi4').setEntry('inputname', 'd1', 'd1');
model.geom('geom1').feature('pi4').setEntry('inputname', 'd2', 'd2');
model.geom('geom1').feature('pi4').setEntry('inputname', 'd1_clear', 'd1_clear');
model.geom('geom1').feature('pi4').setEntry('inputname', 'd2_clear', 'd2_clear');
model.geom('geom1').feature('pi4').setEntry('inputname', 'nix', 'nix');
model.geom('geom1').feature('pi4').setEntry('inputname', 'niy', 'niy');
model.geom('geom1').feature('pi4').setEntry('inputname', 'niz', 'niz');
model.geom('geom1').feature('pi4').setEntry('inputname', 'n_extra_r', 'n_extra_r');
model.geom('geom1').feature('pi4').setEntry('inputname', 'n_extra_a', 'n_extra_a');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'R1', 'R1_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'R2', 'R2_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'Tc', 'Tc_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd0', 'd0_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd1', 'd1_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd2', 'd2_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd1_clear', 'd1_clear_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd2_clear', 'd2_clear_4');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'nix', '0');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'niy', '0');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'niz', '1');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'n_extra_r', '0');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'n_extra_a', '0');
model.geom('geom1').feature('pi4').set('workplanesrc', 'pi3');
model.geom('geom1').feature('pi4').set('workplane', 'wp1');
model.geom('geom1').feature('pi4').set('displ', {'0' '0' 'T_3'});
model.geom('geom1').feature('pi4').setEntry('selcontributetodom', 'pi4_sel1', 'csel3');
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel2', 'csel5');
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel3', 'csel6');
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel4', 'csel6');
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel5', 'csel7');
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel6', 'csel7');
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel7', 'csel7');
model.geom('geom1').run('pi4');
model.geom('geom1').create('pi5', 'PartInstance');
model.geom('geom1').feature('pi5').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi5').set('part', 'part1');
model.geom('geom1').feature('pi5').label('Lens 4');
model.geom('geom1').feature('pi5').setEntry('inputname', 'R1', 'R1');
model.geom('geom1').feature('pi5').setEntry('inputname', 'R2', 'R2');
model.geom('geom1').feature('pi5').setEntry('inputname', 'Tc', 'Tc');
model.geom('geom1').feature('pi5').setEntry('inputname', 'd0', 'd0');
model.geom('geom1').feature('pi5').setEntry('inputname', 'd1', 'd1');
model.geom('geom1').feature('pi5').setEntry('inputname', 'd2', 'd2');
model.geom('geom1').feature('pi5').setEntry('inputname', 'd1_clear', 'd1_clear');
model.geom('geom1').feature('pi5').setEntry('inputname', 'd2_clear', 'd2_clear');
model.geom('geom1').feature('pi5').setEntry('inputname', 'nix', 'nix');
model.geom('geom1').feature('pi5').setEntry('inputname', 'niy', 'niy');
model.geom('geom1').feature('pi5').setEntry('inputname', 'niz', 'niz');
model.geom('geom1').feature('pi5').setEntry('inputname', 'n_extra_r', 'n_extra_r');
model.geom('geom1').feature('pi5').setEntry('inputname', 'n_extra_a', 'n_extra_a');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'R1', 'R1_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'R2', 'R2_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'Tc', 'Tc_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd0', 'd0_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd1', 'd1_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd2', 'd2_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd1_clear', 'd1_clear_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'd2_clear', 'd2_clear_5');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'nix', '0');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'niy', '0');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'niz', '1');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'n_extra_r', '0');
model.geom('geom1').feature('pi5').setEntry('inputexpr', 'n_extra_a', '0');
model.geom('geom1').feature('pi5').set('workplanesrc', 'pi4');
model.geom('geom1').feature('pi5').set('workplane', 'wp2');
model.geom('geom1').feature('pi5').set('displ', {'0' '0' 'T_4'});
model.geom('geom1').feature('pi5').setEntry('selcontributetodom', 'pi5_sel1', 'csel4');
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel2', 'csel5');
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel3', 'csel6');
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel4', 'csel6');
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel5', 'csel7');
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel6', 'csel7');
model.geom('geom1').feature('pi5').setEntry('selcontributetobnd', 'pi5_sel7', 'csel7');
model.geom('geom1').run('pi5');
model.geom('geom1').create('pi6', 'PartInstance');
model.geom('geom1').feature('pi6').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi6').set('part', 'part1');
model.geom('geom1').feature('pi6').label('Lens 5');
model.geom('geom1').feature('pi6').setEntry('inputname', 'R1', 'R1');
model.geom('geom1').feature('pi6').setEntry('inputname', 'R2', 'R2');
model.geom('geom1').feature('pi6').setEntry('inputname', 'Tc', 'Tc');
model.geom('geom1').feature('pi6').setEntry('inputname', 'd0', 'd0');
model.geom('geom1').feature('pi6').setEntry('inputname', 'd1', 'd1');
model.geom('geom1').feature('pi6').setEntry('inputname', 'd2', 'd2');
model.geom('geom1').feature('pi6').setEntry('inputname', 'd1_clear', 'd1_clear');
model.geom('geom1').feature('pi6').setEntry('inputname', 'd2_clear', 'd2_clear');
model.geom('geom1').feature('pi6').setEntry('inputname', 'nix', 'nix');
model.geom('geom1').feature('pi6').setEntry('inputname', 'niy', 'niy');
model.geom('geom1').feature('pi6').setEntry('inputname', 'niz', 'niz');
model.geom('geom1').feature('pi6').setEntry('inputname', 'n_extra_r', 'n_extra_r');
model.geom('geom1').feature('pi6').setEntry('inputname', 'n_extra_a', 'n_extra_a');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'R1', 'R1_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'R2', 'R2_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'Tc', 'Tc_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'd0', 'd0_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'd1', 'd1_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'd2', 'd2_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'd1_clear', 'd1_clear_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'd2_clear', 'd2_clear_6');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'nix', '0');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'niy', '0');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'niz', '1');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'n_extra_r', '0');
model.geom('geom1').feature('pi6').setEntry('inputexpr', 'n_extra_a', '0');
model.geom('geom1').feature('pi6').set('workplanesrc', 'pi5');
model.geom('geom1').feature('pi6').set('workplane', 'wp2');
model.geom('geom1').feature('pi6').set('displ', {'0' '0' 'T_5'});
model.geom('geom1').feature('pi6').setEntry('selcontributetodom', 'pi6_sel1', 'csel4');
model.geom('geom1').feature('pi6').setEntry('selcontributetobnd', 'pi6_sel2', 'csel5');
model.geom('geom1').feature('pi6').setEntry('selcontributetobnd', 'pi6_sel3', 'csel6');
model.geom('geom1').feature('pi6').setEntry('selcontributetobnd', 'pi6_sel4', 'csel6');
model.geom('geom1').feature('pi6').setEntry('selcontributetobnd', 'pi6_sel5', 'csel7');
model.geom('geom1').feature('pi6').setEntry('selcontributetobnd', 'pi6_sel6', 'csel7');
model.geom('geom1').feature('pi6').setEntry('selcontributetobnd', 'pi6_sel7', 'csel7');
model.geom.load({'part3'}, 'Ray_Optics_Module/3D/Apertures_and_Obstructions/rectangular_planar_annulus.mph', {'part1'});
model.geom('geom1').run('pi6');
model.geom('geom1').create('pi7', 'PartInstance');
model.geom('geom1').feature('pi7').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi7').set('part', 'part3');
model.geom('geom1').feature('pi7').label('Image');
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'w0', 'd0_D');
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'h0', 'd0_D');
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'w1', 0);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'h1', 0);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'nwx', 1);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'nwy', 0);
model.geom('geom1').feature('pi7').setEntry('inputexpr', 'nwz', 0);
model.geom('geom1').feature('pi7').set('workplanesrc', 'pi6');
model.geom('geom1').feature('pi7').set('workplane', 'wp2');
model.geom('geom1').feature('pi7').set('displ', {'0' '0' 'T_6'});
model.geom('geom1').feature('pi7').setEntry('selcontributetobnd', 'pi7_sel1', 'csel9');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('All Lenses');
model.geom('geom1').feature('sel1').selection('selection').set('pi1', 1);
model.geom('geom1').feature('sel1').selection('selection').set('pi2', 1);
model.geom('geom1').feature('sel1').selection('selection').set('pi4', 1);
model.geom('geom1').feature('sel1').selection('selection').set('pi5', 1);
model.geom('geom1').feature('sel1').selection('selection').set('pi6', 1);
model.geom('geom1').run('sel1');
model.geom('geom1').create('pi8', 'PartInstance');
model.geom('geom1').feature('pi8').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi8').set('part', 'part2');
model.geom('geom1').feature('pi8').label('Group 1 Aperture');
model.geom('geom1').feature('pi8').setEntry('inputexpr', 'd0', '1.25*d0_1');
model.geom('geom1').feature('pi8').setEntry('inputexpr', 'd1', 'd0_1');
model.geom('geom1').feature('pi8').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi8').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi8').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi8').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi8').set('workplane', 'wp3');
model.geom('geom1').feature('pi8').setEntry('selcontributetobnd', 'pi8_sel1', 'csel7');
model.geom('geom1').run('pi8');
model.geom('geom1').create('pi9', 'PartInstance');
model.geom('geom1').feature('pi9').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi9').set('part', 'part2');
model.geom('geom1').feature('pi9').label('Group 2 Aperture');
model.geom('geom1').feature('pi9').setEntry('inputexpr', 'd0', '1.25*d0_4');
model.geom('geom1').feature('pi9').setEntry('inputexpr', 'd1', 'd0_4');
model.geom('geom1').feature('pi9').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi9').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi9').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi9').set('workplanesrc', 'pi4');
model.geom('geom1').feature('pi9').set('workplane', 'wp3');
model.geom('geom1').feature('pi9').setEntry('selcontributetobnd', 'pi9_sel1', 'csel7');
model.geom('geom1').run('pi9');
model.geom('geom1').create('pi10', 'PartInstance');
model.geom('geom1').feature('pi10').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi10').set('part', 'part2');
model.geom('geom1').feature('pi10').label('Group 3 Aperture');
model.geom('geom1').feature('pi10').setEntry('inputexpr', 'd0', '1.25*d0_6');
model.geom('geom1').feature('pi10').setEntry('inputexpr', 'd1', 'd0_6');
model.geom('geom1').feature('pi10').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi10').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi10').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi10').set('workplanesrc', 'pi6');
model.geom('geom1').feature('pi10').set('workplane', 'wp3');
model.geom('geom1').feature('pi10').setEntry('selcontributetobnd', 'pi10_sel1', 'csel7');
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('white_pupil_echelle_spectrograph_petzval_lens_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
