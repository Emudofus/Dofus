package com.ankamagames.dofus.kernel.sound.manager
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.ambientSounds.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.type.*;
    import com.ankamagames.dofus.kernel.sound.utils.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.BalanceManager.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tubul.enum.*;
    import com.ankamagames.tubul.factory.*;
    import com.ankamagames.tubul.interfaces.*;
    import com.ankamagames.tubul.types.*;
    import flash.utils.*;

    public class FightMusicManager extends Object
    {
        private var _fightMusics:Vector.<AmbientSound>;
        private var _bossMusics:Vector.<AmbientSound>;
        private var _fightMusic:AmbientSound;
        private var _bossMusic:AmbientSound;
        private var _hasBoss:Boolean;
        private var _fightMusicsId:Array;
        private var _fightMusicBalanceManager:BalanceManager;
        private var _actualFightMusic:ISound;
        private var _actualFightMusicId:String;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightMusicManager));

        public function FightMusicManager()
        {
            this.init();
            return;
        }// end function

        public function prepareFightMusic() : void
        {
            SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID, 0, TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
            SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID, 0, TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
            return;
        }// end function

        public function startFight() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._hasBoss = false;
            var _loc_1:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if (_loc_1)
            {
                for each (_loc_2 in _loc_1.getEntitiesDictionnary())
                {
                    
                    if (_loc_2 is GameFightMonsterInformations)
                    {
                        _loc_3 = _loc_2 as GameFightMonsterInformations;
                        _loc_4 = Monster.getMonsterById(_loc_3.creatureGenericId);
                        if (_loc_4.isBoss)
                        {
                            this._hasBoss = true;
                        }
                    }
                }
            }
            return;
        }// end function

        public function playFightMusic() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!SoundManager.getInstance().manager.soundIsActivate)
            {
                return;
            }
            if (SoundManager.getInstance().manager is RegSoundManager && !RegConnectionManager.getInstance().isMain)
            {
                return;
            }
            if (this._hasBoss && this._bossMusic)
            {
                _loc_1 = this._bossMusic;
            }
            else
            {
                _loc_1 = this._fightMusic;
            }
            if (_loc_1)
            {
                _loc_2 = SoundUtil.getBusIdBySoundId(String(_loc_1.id));
                _loc_3 = SoundUtil.getConfigEntryByBusId(_loc_2);
                _loc_4 = new Uri(_loc_3 + _loc_1.id + ".mp3");
                if (SoundManager.getInstance().manager is ClassicSoundManager)
                {
                    this._actualFightMusic = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND, _loc_4);
                }
                if (SoundManager.getInstance().manager is RegSoundManager)
                {
                    this._actualFightMusic = new SoundDofus(String(_loc_1.id));
                }
                this._actualFightMusic.busId = _loc_2;
                this._actualFightMusic.volume = 1;
                this._actualFightMusic.currentFadeVolume = 0;
                _loc_5 = new VolumeFadeEffect(-1, 1, TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
                this._actualFightMusic.play(true, 0, _loc_5);
            }
            return;
        }// end function

        public function stopFightMusic() : void
        {
            if (!SoundManager.getInstance().manager.soundIsActivate || this._actualFightMusic == null)
            {
                return;
            }
            if (SoundManager.getInstance().manager is RegSoundManager && !RegConnectionManager.getInstance().isMain)
            {
                return;
            }
            var _loc_1:* = new VolumeFadeEffect(-1, 0, TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
            this._actualFightMusic.stop(_loc_1);
            SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID, 1, TubulSoundConfiguration.TIME_FADE_IN_MUSIC * 2);
            SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID, 1, TubulSoundConfiguration.TIME_FADE_IN_MUSIC * 2);
            return;
        }// end function

        public function setFightSounds(param1:Vector.<AmbientSound>, param2:Vector.<AmbientSound>) : void
        {
            var _loc_4:* = null;
            this._fightMusics = param1;
            this._bossMusics = param2;
            var _loc_3:* = "";
            if (this._fightMusics.length == 0 && this._bossMusics.length == 0)
            {
                _loc_3 = "Ni musique de combat, ni musique de boss ???";
            }
            else
            {
                _loc_3 = "Cette map contient les musiques de combat : ";
                for each (_loc_4 in this._fightMusics)
                {
                    
                    _loc_3 = _loc_3 + (_loc_4.id + ", ");
                }
                _loc_3 = " et les musiques de boss d\'id : ";
                for each (_loc_4 in this._bossMusics)
                {
                    
                    _loc_3 = _loc_3 + (_loc_4.id + ", ");
                }
            }
            _log.info(_loc_3);
            return;
        }// end function

        public function selectValidSounds() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            for each (_loc_2 in this._fightMusics)
            {
                
                _loc_1++;
            }
            _loc_3 = int(Math.random() * _loc_1);
            for each (_loc_2 in this._fightMusics)
            {
                
                if (_loc_3 == 0)
                {
                    this._fightMusic = _loc_2;
                    break;
                }
                _loc_3 = _loc_3 - 1;
            }
            _loc_1 = 0;
            for each (_loc_2 in this._bossMusics)
            {
                
                _loc_1++;
            }
            _loc_3 = int(Math.random() * _loc_1);
            for each (_loc_2 in this._bossMusics)
            {
                
                if (_loc_3 == 0)
                {
                    this._bossMusic = _loc_2;
                    break;
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        private function init() : void
        {
            this._fightMusicsId = TubulSoundConfiguration.fightMusicIds;
            this._fightMusicBalanceManager = new BalanceManager(this._fightMusicsId);
            return;
        }// end function

    }
}
