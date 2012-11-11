package com.ankamagames.tubul.types
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.BalanceManager.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.events.*;
    import com.ankamagames.tubul.interfaces.*;
    import flash.events.*;
    import flash.utils.*;

    public class PlayList extends EventDispatcher
    {
        private var _sounds:Vector.<ISound>;
        private var _playingSound:ISound;
        private var _playedSoundsId:Vector.<int>;
        public var shuffle:Boolean;
        public var loop:Boolean;
        private var _isPlaying:Boolean = false;
        private var _balanceManager:BalanceManager;
        private var _playSilence:Boolean = false;
        private var _silence:SoundSilence;
        private var _fadeIn:VolumeFadeEffect;
        private var _fadeOut:VolumeFadeEffect;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PlayList));

        public function PlayList(param1:Boolean = false, param2:Boolean = false, param3:SoundSilence = null, param4:VolumeFadeEffect = null, param5:VolumeFadeEffect = null)
        {
            this.shuffle = param1;
            this.loop = param2;
            this._silence = param3;
            this._fadeIn = param4;
            this._fadeOut = param5;
            if (this._silence)
            {
                this.playSilenceBetweenTwoSounds(true, this._silence);
            }
            this.init();
            return;
        }// end function

        public function get tracklist() : Vector.<ISound>
        {
            return this._sounds;
        }// end function

        public function get playingSound() : ISound
        {
            if (this._isPlaying)
            {
                return this._playingSound;
            }
            return null;
        }// end function

        public function get playingSoundIndex() : int
        {
            var _loc_1:* = 0;
            if (this._isPlaying)
            {
                _loc_1 = this._sounds.indexOf(this._playingSound);
                return _loc_1;
            }
            return -1;
        }// end function

        public function get playSilence() : Boolean
        {
            return this._playSilence;
        }// end function

        public function get running() : Boolean
        {
            return this._isPlaying;
        }// end function

        public function addSound(param1:ISound) : uint
        {
            this._sounds.push(param1);
            this._balanceManager.addItem(param1);
            return this._sounds.length;
        }// end function

        public function removeSound(param1:ISound) : uint
        {
            var _loc_2:* = this._sounds.indexOf(param1);
            if (_loc_2 != -1)
            {
                if (param1.isPlaying)
                {
                    param1.stop();
                }
                this._balanceManager.removeItem(param1);
                this._sounds.splice(_loc_2, 1);
            }
            return this._sounds.length;
        }// end function

        public function removeSoundBySoundId(param1:String, param2:Boolean = true) : uint
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            for each (_loc_3 in this._sounds)
            {
                
                if (_loc_3.uri.fileName.split(".")[0] == param1)
                {
                    _loc_4 = this._sounds.indexOf(_loc_3);
                    if (_loc_4 != -1)
                    {
                        if (_loc_3.isPlaying)
                        {
                            _loc_3.stop();
                        }
                        this._balanceManager.removeItem(_loc_3);
                        this._sounds.splice(_loc_4, 1);
                    }
                }
            }
            return this._sounds.length;
        }// end function

        public function play() : void
        {
            if (this._isPlaying)
            {
                return;
            }
            if (this._sounds && this._sounds.length > 0)
            {
                this._isPlaying = true;
                if (this.shuffle)
                {
                    this._playingSound = this._balanceManager.callItem() as ISound;
                }
                else
                {
                    this._playingSound = this._sounds[0] as ISound;
                }
                this.playSound(this._playingSound);
            }
            return;
        }// end function

        public function nextSound(param1:VolumeFadeEffect = null, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            if (param2 && this._playingSound)
            {
                this._playingSound.stop(param1);
            }
            else
            {
                this._playingSound = null;
                if (this.shuffle)
                {
                    this._playingSound = this._balanceManager.callItem() as ISound;
                }
                else
                {
                    _loc_3 = this._sounds.indexOf(this._playingSound);
                    if (_loc_3 == (this._sounds.length - 1))
                    {
                        _log.info("We reached the end of the playlist.");
                        if (this.loop)
                        {
                            _log.info("Playlist is in loop mode. Looping.");
                            this._playingSound = this._sounds[0] as ISound;
                        }
                        else
                        {
                            _log.info("Playlist stop.");
                            this._playingSound = null;
                        }
                        dispatchEvent(new PlaylistEvent(PlaylistEvent.COMPLETE));
                    }
                    else
                    {
                        this._playingSound = this._sounds[(_loc_3 + 1)] as ISound;
                    }
                }
                if (this._playingSound)
                {
                    this.playSound(this._playingSound);
                }
            }
            return;
        }// end function

        public function previousSound() : void
        {
            switch(this.shuffle)
            {
                case true:
                {
                    break;
                }
                case false:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function stop(param1:VolumeFadeEffect = null) : void
        {
            if (this._playingSound == null)
            {
                return;
            }
            if (param1)
            {
                param1.attachToSoundSource(this._playingSound);
                param1.addEventListener(FadeEvent.COMPLETE, this.onFadeOutStopPlaylistComplete);
                param1.start();
            }
            else
            {
                this._playingSound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundComplete);
                this._playingSound.stop();
                this._isPlaying = false;
                dispatchEvent(new PlaylistEvent(PlaylistEvent.COMPLETE));
            }
            return;
        }// end function

        public function reset() : void
        {
            this.stop();
            this.init();
            return;
        }// end function

        public function playSilenceBetweenTwoSounds(param1:Boolean = false, param2:SoundSilence = null) : void
        {
            this._playSilence = param1;
            if (param1 == false && this._silence != null)
            {
                this._silence.clean();
                this._silence = null;
                return;
            }
            if (param1 == true)
            {
                if (param2 == null && this._silence == null)
                {
                    _log.error("Aucun silence à jouer !");
                    this._playSilence = false;
                    return;
                }
                if (param2 != null)
                {
                    if (this._silence != null)
                    {
                        this._silence.clean();
                    }
                    this._silence = param2;
                }
                return;
            }
            return;
        }// end function

        private function init() : void
        {
            var _loc_1:* = null;
            if (this._silence)
            {
                this._silence.clean();
            }
            if (this._sounds)
            {
                for each (_loc_1 in this._sounds)
                {
                    
                    _loc_1.stop();
                    _loc_1 = null;
                }
            }
            this._sounds = new Vector.<ISound>;
            this._balanceManager = new BalanceManager();
            this._isPlaying = false;
            return;
        }// end function

        private function playSound(param1:ISound) : void
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._playingSound = param1;
            this._playingSound.eventDispatcher.addEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundComplete, false, EventListenerPriority.NORMAL);
            var _loc_2:* = this._playingSound.bus;
            if (_loc_2 != null)
            {
                _loc_3 = false;
                if (this._playingSound.totalLoops > -1)
                {
                    _loc_3 = true;
                }
                if (this._fadeIn)
                {
                    _loc_4 = this._fadeIn.clone();
                }
                if (this._fadeOut)
                {
                    _loc_5 = this._fadeOut.clone();
                }
                this._playingSound.play(_loc_3, this._playingSound.totalLoops, _loc_4, _loc_5);
                _loc_6 = new PlaylistEvent(PlaylistEvent.NEW_SOUND);
                _loc_6.newSound = this._playingSound;
                dispatchEvent(_loc_6);
            }
            return;
        }// end function

        private function onSoundComplete(event:SoundCompleteEvent) : void
        {
            this._playingSound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundComplete);
            if (this._playSilence && this._silence != null)
            {
                if (!this._silence.hasEventListener(SoundSilenceEvent.COMPLETE))
                {
                    this._silence.addEventListener(SoundSilenceEvent.COMPLETE, this.onSilenceComplete);
                }
                _log.info("Playlist silence Start");
                this._silence.start();
            }
            else
            {
                event.stopImmediatePropagation();
                this.nextSound();
            }
            return;
        }// end function

        private function onSilenceComplete(event:SoundSilenceEvent) : void
        {
            var _loc_2:* = new SoundCompleteEvent(SoundCompleteEvent.SOUND_COMPLETE);
            _loc_2.sound = this.playingSound;
            dispatchEvent(_loc_2);
            _log.info("Playlist silence End");
            this.nextSound();
            return;
        }// end function

        private function onFadeOutStopPlaylistComplete(event:FadeEvent) : void
        {
            this.stop();
            return;
        }// end function

    }
}
