package com.ankamagames.dofus.kernel.sound.manager
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.data.map.elements.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.type.*;
    import com.ankamagames.dofus.kernel.sound.utils.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.factory.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import com.ankamagames.tubul.types.sounds.*;
    import flash.utils.*;

    public class LocalizedSoundsManager extends Object
    {
        private var _localizedSounds:Vector.<LocalizedMapSound>;
        private var _sounds:Vector.<ISound>;
        private var _isInitialized:Boolean;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(LocalizedSoundsManager));

        public function LocalizedSoundsManager()
        {
            this._isInitialized = false;
            return;
        }// end function

        public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        public function setMap(param1:Map) : void
        {
            var _loc_2:Layer = null;
            var _loc_3:Cell = null;
            var _loc_4:BasicElement = null;
            var _loc_5:SoundElement = null;
            var _loc_6:LocalizedMapSound = null;
            this.removeLocalizedSounds();
            for each (_loc_2 in param1.layers)
            {
                
                for each (_loc_3 in _loc_2.cells)
                {
                    
                    for each (_loc_4 in _loc_3.elements)
                    {
                        
                        if (_loc_4 is SoundElement)
                        {
                            _loc_5 = _loc_4 as SoundElement;
                            _loc_6 = new LocalizedMapSound(_loc_5.soundId.toString(), _loc_5.cell.pixelCoords, _loc_5.nullVolumeDistance, _loc_5.fullVolumeDistance, _loc_5.minDelayBetweenLoops, _loc_5.maxDelayBetweenLoops, _loc_5.baseVolume);
                            this._localizedSounds.push(_loc_6);
                        }
                    }
                }
            }
            this._isInitialized = true;
            return;
        }// end function

        public function playLocalizedSounds() : void
        {
            var _loc_1:LocalizedMapSound = null;
            var _loc_2:uint = 0;
            var _loc_3:String = null;
            var _loc_4:Uri = null;
            var _loc_5:ISound = null;
            for each (_loc_1 in this._localizedSounds)
            {
                
                _loc_2 = SoundUtil.getBusIdBySoundId(_loc_1.soundId);
                _loc_3 = SoundUtil.getConfigEntryByBusId(_loc_2);
                _loc_4 = new Uri(_loc_3 + _loc_1.soundId + ".mp3");
                if (SoundManager.getInstance().manager is ClassicSoundManager)
                {
                    _loc_5 = SoundFactory.getSound(EnumSoundType.LOCALIZED_SOUND, _loc_4);
                    _loc_5.busId = _loc_2;
                    (_loc_5 as LocalizedSound).saturationRange = _loc_1.saturationRange;
                    (_loc_5 as LocalizedSound).silence = new SoundSilence(_loc_1.silenceMin, _loc_1.silenceMax);
                    (_loc_5 as LocalizedSound).range = _loc_1.range;
                    (_loc_5 as LocalizedSound).volumeMax = _loc_1.volumeMax;
                    (_loc_5 as LocalizedSound).position = _loc_1.position;
                    (_loc_5 as LocalizedSound).updateObserverPosition(Tubul.getInstance().earPosition);
                    SoundManager.getInstance().manager.playSound(_loc_5);
                }
                if (SoundManager.getInstance().manager is RegSoundManager)
                {
                    _loc_5 = new SoundDofus(_loc_1.soundId);
                    _loc_5.busId = _loc_2;
                    (_loc_5 as SoundDofus).saturationRange = _loc_1.saturationRange;
                    (_loc_5 as SoundDofus).silence = new SoundSilence(_loc_1.silenceMin, _loc_1.silenceMax);
                    (_loc_5 as SoundDofus).range = _loc_1.range;
                    (_loc_5 as SoundDofus).volumeMax = _loc_1.volumeMax;
                    (_loc_5 as SoundDofus).position = _loc_1.position;
                    _loc_5.play();
                }
                this._sounds.push(_loc_5);
            }
            return;
        }// end function

        public function stopLocalizedSounds() : void
        {
            var _loc_1:ISound = null;
            for each (_loc_1 in this._sounds)
            {
                
                _loc_1.stop();
                _loc_1 = null;
            }
            this._sounds = new Vector.<ISound>;
            return;
        }// end function

        private function removeLocalizedSounds() : void
        {
            this.stopLocalizedSounds();
            this._localizedSounds = new Vector.<LocalizedMapSound>;
            return;
        }// end function

    }
}
