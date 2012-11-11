package com.ankamagames.tubul.types
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.utils.*;

    public class SoundMerger extends EventDispatcher
    {
        private var _output:Sound;
        private var _outputChannel:SoundChannel;
        private var _sounds:Vector.<SoundWrapper>;
        private var _soundsCount:uint;
        private var _directlyPlayed:Dictionary;
        private var _directChannels:Dictionary;
        private var _outputBytes:ByteArray;
        private var _cuttingBytes:ByteArray;
        private static const DATA_SAMPLES_BUFFER_SIZE:uint = 4096;
        private static const SILENCE_SAMPLES_BUFFER_SIZE:uint = 2048;
        public static const MINIMAL_LENGTH_TO_MERGE:uint = 3500;
        public static const MAXIMAL_LENGTH_TO_MERGE:uint = 10000;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundMerger));

        public function SoundMerger()
        {
            this.init();
            return;
        }// end function

        public function getSoundChannel(param1:SoundWrapper) : SoundChannel
        {
            return this._directlyPlayed[param1];
        }// end function

        public function addSound(param1:SoundWrapper) : void
        {
            this.directPlay(param1, param1.loops);
            return;
        }// end function

        public function removeSound(param1:SoundWrapper) : void
        {
            var _loc_2:* = this._sounds.indexOf(param1);
            if (_loc_2 != -1)
            {
                this._sounds.splice(_loc_2, 1);
                param1.dispatchEvent(new Event(Event.SOUND_COMPLETE));
                var _loc_3:* = this;
                _loc_3._soundsCount = this._soundsCount - 1;
                if (!--this._soundsCount)
                {
                    this.setSilence(true);
                }
            }
            else if (this._directlyPlayed[param1])
            {
                this.directStop(param1);
            }
            return;
        }// end function

        private function init() : void
        {
            this._sounds = new Vector.<SoundWrapper>;
            this._directlyPlayed = new Dictionary();
            this._directChannels = new Dictionary();
            this._cuttingBytes = new ByteArray();
            this._output = new Sound();
            this._output.addEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleSilence);
            this._outputChannel = this._output.play();
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        private function setSilence(param1:Boolean) : void
        {
            if (param1)
            {
                this._output.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleData);
                this._output.addEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleSilence);
            }
            else
            {
                this._output.addEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleData);
                this._output.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleSilence);
            }
            return;
        }// end function

        private function directPlay(param1:SoundWrapper, param2:int) : void
        {
            var _loc_3:* = null;
            if (!StageShareManager.stage.hasEventListener(Event.ENTER_FRAME))
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
            _loc_3 = param1.sound.play(0, 1, param1.getSoundTransform());
            if (_loc_3 == null)
            {
                _log.error("directChannel is null !");
                return;
            }
            if (this._directlyPlayed[param1] != null)
            {
                this._directChannels[this._directlyPlayed[param1]] = null;
                delete this._directChannels[this._directlyPlayed[param1]];
            }
            this._directlyPlayed[param1] = _loc_3;
            this._directChannels[_loc_3] = param1;
            if (!_loc_3.hasEventListener(Event.SOUND_COMPLETE))
            {
                _loc_3.addEventListener(Event.SOUND_COMPLETE, this.directSoundComplete);
            }
            return;
        }// end function

        private function directStop(param1:SoundWrapper, param2:Boolean = false) : void
        {
            var _loc_3:* = this._directlyPlayed[param1];
            _loc_3.removeEventListener(Event.SOUND_COMPLETE, this.directSoundComplete);
            _loc_3.stop();
            param1.currentLoop = 0;
            if (!param2)
            {
                param1.dispatchEvent(new Event(Event.SOUND_COMPLETE));
            }
            delete this._directlyPlayed[param1];
            delete this._directChannels[_loc_3];
            if (StageShareManager.stage.hasEventListener(Event.ENTER_FRAME) && this._directChannels.length == 0)
            {
                StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            }
            return;
        }// end function

        private function sampleData(event:SampleDataEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_16:* = false;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = false;
            var _loc_2:* = getTimer();
            var _loc_15:* = event.data;
            _loc_11 = 0;
            while (_loc_11 < this._soundsCount)
            {
                
                _loc_14 = this._sounds[_loc_11] as SoundWrapper;
                if (_loc_14._extractFinished)
                {
                }
                else
                {
                    _loc_4 = DATA_SAMPLES_BUFFER_SIZE;
                    _loc_3 = _loc_14.soundData.position;
                    _loc_21 = true;
                    do
                    {
                        
                        if (_loc_3 == 0 && _loc_21)
                        {
                            _loc_5 = _loc_14.sound.extract(_loc_14.soundData, _loc_4, 0);
                        }
                        else
                        {
                            _loc_5 = _loc_14.sound.extract(_loc_14.soundData, _loc_4);
                        }
                        _loc_21 = false;
                        _loc_16 = _loc_5 != _loc_4;
                        if (!_loc_14.hadBeenCut && (_loc_14.loops == 0 || _loc_14.loops > 1))
                        {
                            var _loc_22:* = _loc_14;
                            var _loc_23:* = _loc_14.currentLoop + 1;
                            _loc_22.currentLoop = _loc_23;
                            _loc_14.soundData.position = _loc_9;
                            _loc_10 = 0;
                            while (_loc_10 < _loc_5)
                            {
                                
                                _loc_6 = _loc_14.soundData.readFloat();
                                _loc_7 = _loc_14.soundData.readFloat();
                                if (_loc_6 > 0.001 || _loc_6 < -0.001 || _loc_7 > 0.001 || _loc_7 < -0.001)
                                {
                                    _loc_14.hadBeenCut = true;
                                    break;
                                }
                                _loc_10 = _loc_10 + 1;
                            }
                            _loc_8 = _loc_10 + 1;
                            _loc_10 = _loc_10 + 1;
                            while (_loc_10 < _loc_5)
                            {
                                
                                this._cuttingBytes.writeFloat(_loc_14.soundData.readFloat());
                                this._cuttingBytes.writeFloat(_loc_14.soundData.readFloat());
                                _loc_10 = _loc_10 + 1;
                            }
                            if (this._cuttingBytes.length > 0)
                            {
                                _loc_4 = _loc_4 + _loc_8;
                                _loc_13 = _loc_14.soundData;
                                _loc_14.soundData = this._cuttingBytes;
                                this._cuttingBytes = _loc_13;
                                this._cuttingBytes.clear();
                            }
                            else
                            {
                                _loc_9 = _loc_9 + DATA_SAMPLES_BUFFER_SIZE * 8;
                                _loc_4 = _loc_4 + DATA_SAMPLES_BUFFER_SIZE;
                            }
                        }
                        if (_loc_16)
                        {
                            _loc_14.extractFinished();
                            break;
                        }
                        _loc_4 = _loc_4 - _loc_5;
                    }while (_loc_4 > 0)
                    _loc_14.soundData.position = _loc_3;
                }
                _loc_11 = _loc_11 + 1;
            }
            _loc_10 = 0;
            while (_loc_10 < DATA_SAMPLES_BUFFER_SIZE)
            {
                
                var _loc_22:* = 0;
                _loc_18 = 0;
                _loc_17 = _loc_22;
                _loc_11 = 0;
                while (_loc_11 < this._soundsCount)
                {
                    
                    if (_loc_10 == 0)
                    {
                        _loc_14.checkSoundPosition();
                    }
                    _loc_14 = this._sounds[_loc_11] as SoundWrapper;
                    if (_loc_14.soundData.bytesAvailable < 8)
                    {
                        if (_loc_14.loops == 0 || _loc_14.loops > 1 && (_loc_14.currentLoop + 1) < _loc_14.loops)
                        {
                            _loc_14.soundData.position = 0;
                            var _loc_22:* = _loc_14;
                            var _loc_23:* = _loc_14.currentLoop + 1;
                            _loc_22.currentLoop = _loc_23;
                        }
                        else
                        {
                            this.removeSound(_loc_14);
                            break;
                        }
                    }
                    else
                    {
                        _loc_19 = _loc_14.soundData.readFloat() * _loc_14._volume * (1 - _loc_14._pan);
                        _loc_20 = _loc_14.soundData.readFloat() * _loc_14._volume * (1 + _loc_14._pan);
                        _loc_17 = _loc_17 + (_loc_19 * _loc_14._leftToLeft + _loc_20 * _loc_14._rightToLeft);
                        _loc_18 = _loc_18 + (_loc_19 * _loc_14._leftToRight + _loc_20 * _loc_14._rightToRight);
                    }
                    _loc_11 = _loc_11 + 1;
                }
                if (_loc_17 > 1)
                {
                    _loc_17 = 1;
                }
                if (_loc_17 < -1)
                {
                    _loc_17 = -1;
                }
                if (_loc_18 > 1)
                {
                    _loc_18 = 1;
                }
                if (_loc_18 < -1)
                {
                    _loc_18 = -1;
                }
                _loc_15.writeFloat(_loc_17);
                _loc_15.writeFloat(_loc_18);
                _loc_10 = _loc_10 + 1;
            }
            return;
        }// end function

        private function sampleSilence(event:SampleDataEvent) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < SILENCE_SAMPLES_BUFFER_SIZE)
            {
                
                event.data.writeFloat(0);
                event.data.writeFloat(0);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function directSoundComplete(event:Event) : void
        {
            var _loc_2:* = this._directChannels[event.target];
            var _loc_3:* = _loc_2;
            var _loc_4:* = _loc_2.currentLoop + 1;
            _loc_3.currentLoop = _loc_4;
            if (_loc_2.currentLoop < _loc_2.loops || _loc_2.loops == 0)
            {
                this.directPlay(_loc_2, _loc_2.loops);
            }
            else
            {
                this.directStop(_loc_2, true);
                _loc_2.dispatchEvent(event);
            }
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._directChannels)
            {
                
                _loc_2.checkSoundPosition();
            }
            return;
        }// end function

    }
}
