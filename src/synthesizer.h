/*
 * Copyright © 2017, 2020 Andrew Penkrat
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

#ifndef SYNTHESIZER_H
#define SYNTHESIZER_H

#include "synthsettings.h"

#include <QObject>
#include <QQmlListProperty>
#include <fluidsynth.h>
#include <audioresource.h>

class SynthPreset : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(int bank READ bank CONSTANT)
    Q_PROPERTY(int program READ program CONSTANT)
public:
    SynthPreset(fluid_preset_t *preset, int sfontId, QObject *parent = nullptr);
    ~SynthPreset();

    QString name() const { return m_name; }
    int bank() const { return m_bankNum; }
    int program() const { return m_num; }
    int sfontId() const { return m_sfontId; }

private:
    const QString m_name;
    const int m_bankNum;
    const int m_num;
    const int m_sfontId;
};

class Synthesizer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<SynthPreset> availablePrograms READ availablePrograms NOTIFY availableProgramsChanged)
    Q_PROPERTY(SynthPreset *currentProgram READ currentProgram WRITE setCurrentProgram NOTIFY currentProgramChanged)
public:
    explicit Synthesizer(QObject *parent = nullptr);
    ~Synthesizer();

    QQmlListProperty<SynthPreset> availablePrograms();
    inline SynthPreset *currentProgram() { return m_currentPreset; }
    void setCurrentProgram(SynthPreset *program);

signals:
    void availableProgramsChanged();
    void currentProgramChanged();

public slots:
    void startPlaying(int key);
    void stopPlaying(int key);
    void selectProgram(SynthPreset *preset);

private slots:
    static void onAudioAcquired(audioresource_t *audio_resource, bool acquired, void *user_data);

private:
    SynthSettings *m_settings;

    fluid_settings_t *m_synthsettings;
    fluid_audio_driver_t *m_adriver;
    fluid_synth_t *m_synth;

    QList<SynthPreset *> m_presets;
    SynthPreset *m_currentPreset;

    audioresource_t *m_resource_handle;
};

#endif // SYNTHESIZER_H
