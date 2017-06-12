/*
 * Copyright © 2017 Andrew Penkrat
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

#include <QObject>
#include <fluidsynth.h>
#include <audioresource.h>

class Synthesizer : public QObject
{
    Q_OBJECT
public:
    explicit Synthesizer(QObject *parent = 0);
    ~Synthesizer();

signals:

public slots:
    void startPlaying(int key);
    void stopPlaying(int key);

private slots:
    static void onAudioAcquired(audioresource_t *audio_resource, bool acquired, void *user_data);

private:
    fluid_settings_t* m_settings;
    fluid_audio_driver_t* m_adriver;
    fluid_synth_t* m_synth;
    int m_fontId;
    audioresource_t *resource;
};

#endif // SYNTHESIZER_H
