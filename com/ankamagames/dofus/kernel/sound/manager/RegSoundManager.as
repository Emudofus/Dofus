package com.ankamagames.dofus.kernel.sound.manager
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.dofus.datacenter.ambientSounds.*;
    import com.ankamagames.dofus.datacenter.sounds.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.dofus.kernel.sound.type.*;
    import com.ankamagames.dofus.kernel.sound.utils.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.uiApi.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.parser.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.events.*;
    import com.ankamagames.tubul.factory.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.utils.*;

    public class RegSoundManager extends EventDispatcher implements ISoundManager
    {
        private var _previousSubareaId:int;
        private var _criterionSubarea:int;
        private var _entitySounds:Array;
        private var _reverseEntitySounds:Dictionary;
        private var _entityDictionary:Dictionary;
        private var _adminSounds:Dictionary;
        private var _ambientManager:AmbientSoundsManager;
        private var _localizedSoundsManager:LocalizedSoundsManager;
        private var _fightMusicManager:FightMusicManager;
        private var _forceSounds:Boolean = true;
        private var _soundDirectoryExist:Boolean = true;
        private var _inFight:Boolean;
        private var _adminPlaylist:PlayList;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RegSoundManager));
        private static var _self:ISoundManager;

        public function RegSoundManager()
        {
            this.init();
            return;
        }// end function

        public function set soundDirectoryExist(param1:Boolean) : void
        {
            this._soundDirectoryExist = param1;
            return;
        }// end function

        public function get soundDirectoryExist() : Boolean
        {
            return this._soundDirectoryExist;
        }// end function

        public function get soundIsActivate() : Boolean
        {
            return this.checkIfAvailable();
        }// end function

        public function get entitySounds() : Array
        {
            return this._entitySounds;
        }// end function

        public function get reverseEntitySounds() : Dictionary
        {
            return this._reverseEntitySounds;
        }// end function

        public function set forceSoundsDebugMode(param1:Boolean) : void
        {
            this._forceSounds = param1;
            return;
        }// end function

        public function playMainClientSounds() : void
        {
            if (this._localizedSoundsManager != null && this._localizedSoundsManager.isInitialized)
            {
                this._localizedSoundsManager.playLocalizedSounds();
            }
            if (this._ambientManager != null)
            {
                this._ambientManager.playMusicAndAmbient();
            }
            if (this._fightMusicManager != null && this._inFight)
            {
                this._fightMusicManager.playFightMusic();
            }
            this.playIntroMusic();
            SoundManager.getInstance().setSoundOptions();
            return;
        }// end function

        public function stopMainClientSounds() : void
        {
            if (this._localizedSoundsManager != null && this._localizedSoundsManager.isInitialized)
            {
                this._localizedSoundsManager.stopLocalizedSounds();
            }
            if (this._ambientManager != null)
            {
                this._ambientManager.stopMusicAndAmbient();
            }
            if (this._fightMusicManager != null && this._inFight)
            {
                this._fightMusicManager.stopFightMusic();
            }
            this.stopIntroMusic(true);
            return;
        }// end function

        public function activateSound() : void
        {
            this._forceSounds = true;
            this.playMainClientSounds();
            return;
        }// end function

        public function deactivateSound() : void
        {
            this.stopMainClientSounds();
            this._forceSounds = false;
            RegConnectionManager.getInstance().send(ProtocolEnum.DEACTIVATE_SOUNDS);
            return;
        }// end function

        public function setSubArea(param1:Map = null) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_2:* = MapPosition.getMapPositionById(param1.id);
            this.removeLocalizedSounds();
            this._localizedSoundsManager.setMap(param1);
            if (this.soundIsActivate && RegConnectionManager.getInstance().isMain)
            {
                this._localizedSoundsManager.playLocalizedSounds();
            }
            this._previousSubareaId = param1.subareaId;
            this._criterionSubarea = 1;
            var _loc_3:* = SubArea.getSubAreaById(param1.subareaId);
            if (_loc_3 == null)
            {
                return;
            }
            var _loc_4:* = new Vector.<Vector.<AmbientSound>>;
            var _loc_5:* = 0;
            while (_loc_5 < 4)
            {
                
                _loc_4[_loc_5] = new Vector.<AmbientSound>;
                _loc_5++;
            }
            if (_loc_2)
            {
                for each (_loc_7 in _loc_2.sounds)
                {
                    
                    _loc_8 = new AmbientSound();
                    _loc_8.channel = _loc_7.channel;
                    _loc_8.criterionId = _loc_7.criterionId;
                    _loc_8.id = _loc_7.id;
                    _loc_8.silenceMax = _loc_7.silenceMax;
                    _loc_8.silenceMin = _loc_7.silenceMin;
                    _loc_8.volume = _loc_7.volume;
                    _loc_4[(_loc_7.type_id - 1)].push(_loc_8);
                }
            }
            for each (_loc_6 in _loc_3.ambientSounds)
            {
                
                _loc_9 = new AmbientSound();
                _loc_9.channel = _loc_6.channel;
                _loc_9.criterionId = _loc_6.criterionId;
                _loc_9.id = _loc_6.id;
                _loc_9.silenceMax = _loc_6.silenceMax;
                _loc_9.silenceMin = _loc_6.silenceMin;
                _loc_9.volume = _loc_6.volume;
                _loc_10 = true;
                if (_loc_10)
                {
                    _loc_4[(_loc_6.type_id - 1)].push(_loc_9);
                }
            }
            _log.info("Subarea Id : " + _loc_3.id + " / Map id : " + param1.id);
            this._ambientManager.setAmbientSounds(_loc_4[0], _loc_4[1]);
            this._ambientManager.selectValidSounds();
            this._ambientManager.playMusicAndAmbient();
            this._fightMusicManager.setFightSounds(_loc_4[2], _loc_4[3]);
            return;
        }// end function

        public function playUISound(param1:String, param2:Boolean = false) : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            var _loc_3:* = new SoundDofus(param1);
            _loc_3.play(param2);
            return;
        }// end function

        public function playSound(param1:ISound, param2:Boolean = false, param3:int = -1) : ISound
        {
            var _loc_6:* = null;
            if (!this.checkIfAvailable())
            {
                return null;
            }
            var _loc_4:* = param1.uri.fileName.split(".mp3")[0];
            var _loc_5:* = new SoundDofus(_loc_4, true);
            for (_loc_6 in param1)
            {
                
                if (_loc_5.hasOwnProperty(_loc_6))
                {
                    _loc_5[_loc_6] = param1;
                }
            }
            _loc_5.play(param2, param3);
            return _loc_5;
        }// end function

        public function playFightMusic() : void
        {
            this._inFight = true;
            this._fightMusicManager.selectValidSounds();
            this._fightMusicManager.startFight();
            this._fightMusicManager.playFightMusic();
            return;
        }// end function

        public function prepareFightMusic() : void
        {
            this._fightMusicManager.prepareFightMusic();
            return;
        }// end function

        public function stopFightMusic() : void
        {
            this._inFight = false;
            this._fightMusicManager.stopFightMusic();
            return;
        }// end function

        public function handleFLAEvent(param1:String, param2:String, param3:String, param4:Object = null) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (!(this.soundIsActivate && RegConnectionManager.getInstance().isMain))
            {
                return;
            }
            if (param4 is TiphonSprite && TiphonSprite(param4).parentSprite && TiphonSprite(param4).parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET, 0))
            {
                return;
            }
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = -1;
            if (param4.hasOwnProperty("absoluteBounds"))
            {
                _loc_5 = param4.absoluteBounds.x;
                _loc_6 = param4.absoluteBounds.y;
                _loc_7 = param4.id;
                if (_loc_7 != PlayedCharacterManager.getInstance().infos.id && _loc_7 > 0 && Kernel.getWorker().getFrame(FightBattleFrame) == null)
                {
                    return;
                }
            }
            else if (param4 is WorldEntitySprite)
            {
                _loc_5 = InteractiveCellManager.getInstance().getCell((param4 as WorldEntitySprite).cellId).x;
                _loc_6 = InteractiveCellManager.getInstance().getCell((param4 as WorldEntitySprite).cellId).y;
                _loc_7 = (param4 as WorldEntitySprite).identifier;
            }
            else if (param4 is TiphonSprite)
            {
                _loc_9 = param4 as TiphonSprite;
                if (_loc_9.parentSprite is TiphonSprite)
                {
                    if (_loc_9.parentSprite.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) != null)
                    {
                        _loc_10 = _loc_9.parentSprite;
                        if (_loc_10.hasOwnProperty("absoluteBounds"))
                        {
                            _loc_5 = _loc_10.absoluteBounds.x;
                            _loc_6 = _loc_10.absoluteBounds.y;
                            _loc_7 = _loc_10.id;
                            if (_loc_7 != PlayedCharacterManager.getInstance().infos.id && _loc_7 > 0 && Kernel.getWorker().getFrame(FightBattleFrame) == null)
                            {
                                return;
                            }
                        }
                    }
                }
                else
                {
                    return;
                }
            }
            else
            {
                return;
            }
            switch(param2)
            {
                case "Sound":
                {
                    param3 = param3 + "*";
                    break;
                }
                case "DataSound":
                {
                    param3 = this.buildSoundLabel(_loc_7, param1, param3) + "*";
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_8:* = -1;
            if (param4.look.skins)
            {
                _loc_8 = param4.look.skins[0];
            }
            if (param3)
            {
                RegConnectionManager.getInstance().send(ProtocolEnum.FLA_EVENT, param3, _loc_7, _loc_5, _loc_6, _loc_8);
            }
            return;
        }// end function

        public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.DYNAMIC_MIX, RegConnectionManager.getInstance().socketClientID, param1.endingValue, param1.timeFade, param2, param3.timeFade);
            return;
        }// end function

        public function retriveRollOffPresets() : void
        {
            return;
        }// end function

        public function setSoundSourcePosition(param1:int, param2:Point) : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            if (param1 == PlayedCharacterManager.getInstance().id)
            {
                RegConnectionManager.getInstance().send(ProtocolEnum.SET_PLAYER_POSITION, RegConnectionManager.getInstance().socketClientID, param2.x, param2.y);
            }
            else
            {
                RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_SOURCE_POSITION, RegConnectionManager.getInstance().socketClientID, param1, param2.x, param2.y);
            }
            return;
        }// end function

        public function addSoundEntity(param1:ISound, param2:int) : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            if (this._entitySounds[param2] == null)
            {
                this._entitySounds[param2] = new Vector.<ISound>;
            }
            this._entityDictionary[DofusEntities.getEntity(param2)] = this._entitySounds[param2];
            this._entitySounds[param2].push(param1);
            this._reverseEntitySounds[param1] = param2;
            return;
        }// end function

        public function removeSoundEntity(param1:ISound) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._reverseEntitySounds[param1];
            if (!this._entitySounds[_loc_2])
            {
                return;
            }
            for each (_loc_3 in this._entitySounds[_loc_2])
            {
                
                if (_loc_3 == param1)
                {
                    _loc_3.stop();
                    this._entitySounds[_loc_2].splice(this._entitySounds[_loc_2].indexOf(_loc_3), 1);
                    delete this._reverseEntitySounds[param1];
                    if (this._entitySounds[_loc_2].length == 0)
                    {
                        this._entitySounds[_loc_2] = null;
                    }
                    return;
                }
            }
            return;
        }// end function

        public function removeEntitySound(param1:IEntity) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._entityDictionary[param1] == null)
            {
                return;
            }
            for each (_loc_2 in this._entityDictionary[param1])
            {
                
                _loc_3 = new VolumeFadeEffect(-1, 0, 0.1);
                _loc_2.stop(_loc_3);
            }
            delete this._entityDictionary[param1];
            return;
        }// end function

        public function retriveXMLSounds() : void
        {
            return;
        }// end function

        private function playIntro() : void
        {
            return;
        }// end function

        public function playIntroMusic(param1:Boolean = true) : void
        {
            if (!(this.soundIsActivate && RegConnectionManager.getInstance().isMain))
            {
                return;
            }
            var _loc_2:* = new SystemApi();
            if (_loc_2.isInGame())
            {
                return;
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_INTRO, RegConnectionManager.getInstance().socketClientID);
            return;
        }// end function

        public function switchIntroMusic(param1:Boolean) : void
        {
            if (!(this.soundIsActivate && RegConnectionManager.getInstance().isMain))
            {
                return;
            }
            var _loc_2:* = new SystemApi();
            if (_loc_2.isInGame())
            {
                return;
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.SWITCH_INTRO, RegConnectionManager.getInstance().socketClientID, param1);
            return;
        }// end function

        public function stopIntroMusic(param1:Boolean = false) : void
        {
            if (!this.checkIfAvailable())
            {
                return;
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.STOP_INTRO, RegConnectionManager.getInstance().socketClientID, param1);
            return;
        }// end function

        public function removeAllSounds(param1:Number = 0, param2:Number = 0) : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_ALL_SOUNDS, RegConnectionManager.getInstance().socketClientID);
            return;
        }// end function

        public function fadeBusVolume(param1:int, param2:Number, param3:Number) : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.FADE_BUS, param1, param2, param3);
            return;
        }// end function

        public function setBusVolume(param1:int, param2:Number) : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.SET_BUS_VOLUME, param1, param2);
            return;
        }// end function

        public function reset() : void
        {
            this.stopMainClientSounds();
            this.removeAllSounds();
            return;
        }// end function

        private function init() : void
        {
            this._previousSubareaId = -1;
            this._localizedSoundsManager = new LocalizedSoundsManager();
            this._ambientManager = new AmbientSoundsManager();
            this._fightMusicManager = new FightMusicManager();
            this._entitySounds = new Array();
            this._reverseEntitySounds = new Dictionary();
            this._adminSounds = new Dictionary();
            this._entityDictionary = new Dictionary();
            if (AirScanner.hasAir())
            {
                StageShareManager.stage["nativeWindow"].addEventListener(Event.CLOSE, this.onClose);
            }
            RegConnectionManager.getInstance().send(ProtocolEnum.SAY_HELLO, RegConnectionManager.getInstance().socketClientID, File.applicationDirectory.nativePath + "/config.xml");
            return;
        }// end function

        private function removeLocalizedSounds() : void
        {
            this._entitySounds = new Array();
            this._reverseEntitySounds = new Dictionary();
            RegConnectionManager.getInstance().send(ProtocolEnum.REMOVE_LOCALIZED_SOUNDS, RegConnectionManager.getInstance().socketClientID);
            return;
        }// end function

        private function checkIfAvailable() : Boolean
        {
            return this._forceSounds && this._soundDirectoryExist;
        }// end function

        public function playAdminSound(param1:String, param2:Number, param3:Boolean, param4:uint) : void
        {
            var _loc_5:* = SoundUtil.getBusIdBySoundId(param1);
            var _loc_6:* = SoundUtil.getConfigEntryByBusId(_loc_5);
            var _loc_7:* = new Uri(_loc_6 + param1 + ".mp3");
            var _loc_8:* = new SoundDofus(param1);
            new SoundDofus(param1).busId = _loc_5;
            this._adminSounds[param4] = _loc_8;
            _loc_8.play(param3);
            _loc_8.volume = param2;
            return;
        }// end function

        public function stopAdminSound(param1:uint) : void
        {
            var _loc_2:* = this._adminSounds[param1] as ISound;
            _loc_2.stop();
            return;
        }// end function

        public function addSoundInPlaylist(param1:String, param2:Number, param3:uint, param4:uint) : Boolean
        {
            if (this._adminPlaylist == null)
            {
                this._adminPlaylist = new PlayList(false, true);
            }
            var _loc_5:* = SoundUtil.getBusIdBySoundId(param1);
            var _loc_6:* = SoundUtil.getConfigEntryByBusId(_loc_5);
            var _loc_7:* = new Uri(_loc_6 + param1 + ".mp3");
            var _loc_8:* = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_7);
            SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_7).busId = _loc_5;
            if (this._adminPlaylist.addSound(_loc_8) > 0)
            {
                return true;
            }
            return false;
        }// end function

        public function removeSoundInPLaylist(param1:String) : Boolean
        {
            if (this._adminPlaylist == null)
            {
                return false;
            }
            this._adminPlaylist.removeSoundBySoundId(param1, true);
            return true;
        }// end function

        public function playPlaylist() : void
        {
            if (this.checkIfAvailable())
            {
                return;
            }
            if (this._adminPlaylist == null)
            {
                return;
            }
            this._adminPlaylist.play();
            return;
        }// end function

        public function stopPlaylist() : void
        {
            if (this.checkIfAvailable())
            {
                return;
            }
            if (this._adminPlaylist == null)
            {
                return;
            }
            this._adminPlaylist.stop();
            return;
        }// end function

        public function resetPlaylist() : void
        {
            if (this._adminPlaylist)
            {
                this._adminPlaylist.reset();
            }
            return;
        }// end function

        private function onRemoveSoundInTubul(event:AudioBusEvent) : void
        {
            this.removeSoundEntity(event.sound);
            return;
        }// end function

        private function onSoundAdminComplete(event:SoundCompleteEvent) : void
        {
            event.sound.eventDispatcher.removeEventListener(SoundCompleteEvent.SOUND_COMPLETE, this.onSoundAdminComplete);
            var _loc_2:* = event.sound.uri.fileName.split(".mp3")[0];
            this._adminSounds[_loc_2] = null;
            delete this._adminSounds[_loc_2];
            return;
        }// end function

        public function onClose(event:Event) : void
        {
            RegConnectionManager.getInstance().send(ProtocolEnum.SAY_GOODBYE, RegConnectionManager.getInstance().socketClientID);
            return;
        }// end function

        public function buildSoundLabel(param1:int, param2:String, param3:String) : String
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (param3 != null)
            {
                _loc_8 = /^\s*(.*?)\s*$""^\s*(.*?)\s*$/g;
                param3 = param3.replace(_loc_8, "$1");
                if (param3.length == 0)
                {
                    param3 = null;
                }
            }
            var _loc_4:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
            if (!(Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame))
            {
                _loc_4 = Kernel.getWorker().getFrame(FightEntitiesFrame) as AbstractEntitiesFrame;
            }
            var _loc_5:* = _loc_4.getEntityInfos(param1);
            if (!_loc_4.getEntityInfos(param1) || !_loc_5.look)
            {
                _log.error(param1 + " : donnés incomplètes pour ce bones, impossible de créer les sons");
                return null;
            }
            var _loc_6:* = _loc_5.look.bonesId;
            var _loc_7:* = SoundBones.getSoundBonesById(_loc_6);
            if (SoundBones.getSoundBonesById(_loc_6) != null)
            {
                _loc_9 = new Vector.<SoundEventParamWrapper>;
                for each (_loc_10 in _loc_7.getSoundAnimationByLabel(param2, param3))
                {
                    
                    _loc_9.push(new SoundEventParamWrapper(_loc_10.filename, _loc_10.volume, _loc_10.rolloff, _loc_10.automationDuration, _loc_10.automationVolume, _loc_10.automationFadeIn, _loc_10.automationFadeOut, _loc_10.noCutSilence));
                }
            }
            return FLAEventLabelParser.buildSoundLabel(_loc_9);
        }// end function

    }
}
