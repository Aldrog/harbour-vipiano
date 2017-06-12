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

#include "synthesizer.h"
#include <QDebug>
#include <sailfishapp.h>
#include <string.h>

Synthesizer::Synthesizer(QObject *parent) : QObject(parent)
{
    m_settings = new_fluid_settings();
    m_synth = new_fluid_synth(m_settings);
    unsigned int sfontId = fluid_synth_sfload(m_synth, SailfishApp::pathTo("soundfonts/FluidR3_GM.sf2").path().toStdString().c_str(), true);
    if(sfontId == FLUID_FAILED)
        qDebug() << "Failed font loading";
    else {
        fluid_sfont_t *sfont = fluid_synth_get_sfont_by_id(m_synth, sfontId);
        fluid_preset_t* preset = new fluid_preset_t();
        preset->sfont = sfont;

        // Reset the iteration
        sfont->iteration_start(sfont);

        // Go through all the presets within the soundfont
        int more = 1;
        while (more) {
            more = sfont->iteration_next(sfont, preset); // Will return 0 if no more soundfonts left
            if (more) {
                m_presets.append(new SynthPreset(preset, this));
            }
        }
        delete preset;

        setCurrentProgram(m_presets[0]);

        fluid_settings_setstr(m_settings, "audio.driver", "pulseaudio");
        m_adriver = new_fluid_audio_driver(m_settings, m_synth);

        void *user_data = nullptr;
        resource = audioresource_init(AUDIO_RESOURCE_GAME, Synthesizer::onAudioAcquired, user_data);
        audioresource_acquire(resource);
    }
}

Synthesizer::~Synthesizer()
{
    audioresource_release(resource);
    audioresource_free(resource);

    delete_fluid_synth(m_synth);
    delete_fluid_settings(m_settings);
}

QQmlListProperty<SynthPreset> Synthesizer::availablePrograms()
{
    return QQmlListProperty<SynthPreset>(this, m_presets);
}

void Synthesizer::setCurrentProgram(SynthPreset *program)
{
    if(program == currentProgram())
        return;
    m_currentPreset = program;
    selectProgram(m_currentPreset);
    emit currentProgramChanged();
}

void Synthesizer::startPlaying(int key)
{
    fluid_synth_noteon(m_synth, 0, key, 100);
}

void Synthesizer::stopPlaying(int key)
{
    fluid_synth_noteoff(m_synth, 0, key);
}

void Synthesizer::selectProgram(SynthPreset *preset)
{
    fluid_synth_program_select(m_synth, 0, preset->sfontId(), preset->bank(), preset->program());
}

void Synthesizer::onAudioAcquired(audioresource_t *audio_resource, bool acquired, void *user_data)
{
    qDebug() << acquired;
}

SynthPreset::SynthPreset(fluid_preset_t *preset, QObject *parent) :
    QObject(parent),
    m_preset(new fluid_preset_t(*preset))
{ }

SynthPreset::~SynthPreset()
{
    delete m_preset;
}

QString SynthPreset::name()
{
    return QString::fromLatin1(m_preset->get_name(m_preset));
}

int SynthPreset::bank()
{
    return m_preset->get_banknum(m_preset);
}

int SynthPreset::program()
{
    return m_preset->get_num(m_preset);
}

unsigned int SynthPreset::sfontId()
{
    return m_preset->sfont->id;
}
