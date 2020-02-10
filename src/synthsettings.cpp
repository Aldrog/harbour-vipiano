/*
 * Copyright © 2020 Andrew Penkrat
 *
 * This file is part of ViPiano.
 *
 * ViPiano is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ViPiano is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ViPiano.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "synthsettings.h"

double SynthSettings::gain() const {
    return value(gainKey, 0.5).toDouble();
}

void SynthSettings::setGain(double gain) {
    return setValue(gainKey, gain);
}

bool SynthSettings::dynamicLoading() const {
    return value(dynamicLoadingKey, true).toBool();
}

void SynthSettings::setDynamicLoading(bool dynamicLoading) {
    return setValue(dynamicLoadingKey, dynamicLoading);
}

const QString SynthSettings::gainKey = QStringLiteral("Synth/Gain");
const QString SynthSettings::dynamicLoadingKey = QStringLiteral("Synth/DynamicLoading");

