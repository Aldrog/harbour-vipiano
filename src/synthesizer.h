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
    void startPlaying();
    void stopPlaying();

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
