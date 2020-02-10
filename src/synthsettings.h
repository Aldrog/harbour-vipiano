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

#ifndef SYNTHSETTINGS_H
#define SYNTHSETTINGS_H

#include <QSettings>

class SynthSettings : QSettings
{
public:
    using QSettings::QSettings;

    double gain() const;
    void setGain(double gain);
    bool dynamicLoading() const;
    void setDynamicLoading(bool dynamicLoading);

private:
    static const QString gainKey;
    static const QString dynamicLoadingKey;
};

#endif // SYNTHSETTINGS_H
