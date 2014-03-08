package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
   import com.ankamagames.jerakine.BalanceManager.BalanceManager;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.TubulSoundConfiguration;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   
   public class FightMusicManager extends Object
   {
      
      public function FightMusicManager() {
         super();
         this.init();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightMusicManager));
      
      private var _fightMusics:Vector.<AmbientSound>;
      
      private var _bossMusics:Vector.<AmbientSound>;
      
      private var _fightMusic:AmbientSound;
      
      private var _bossMusic:AmbientSound;
      
      private var _hasBoss:Boolean;
      
      private var _fightMusicsId:Array;
      
      private var _fightMusicBalanceManager:BalanceManager;
      
      private var _actualFightMusic:ISound;
      
      private var _actualFightMusicId:String;
      
      public function prepareFightMusic() : void {
         SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID,0,TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
         SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID,0,TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
      }
      
      public function startFight() : void {
         var _loc2_:GameContextActorInformations = null;
         var _loc3_:GameFightMonsterInformations = null;
         var _loc4_:Monster = null;
         this._hasBoss = false;
         var _loc1_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(_loc1_)
         {
            for each (_loc2_ in _loc1_.getEntitiesDictionnary())
            {
               if(_loc2_ is GameFightMonsterInformations)
               {
                  _loc3_ = _loc2_ as GameFightMonsterInformations;
                  _loc4_ = Monster.getMonsterById(_loc3_.creatureGenericId);
                  if(_loc4_.isBoss)
                  {
                     this._hasBoss = true;
                  }
               }
            }
         }
      }
      
      public function playFightMusic() : void {
         var _loc1_:AmbientSound = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:Uri = null;
         var _loc5_:VolumeFadeEffect = null;
         if(!SoundManager.getInstance().manager.soundIsActivate)
         {
            return;
         }
         if(SoundManager.getInstance().manager is RegSoundManager && !RegConnectionManager.getInstance().isMain)
         {
            return;
         }
         if((this._hasBoss) && (this._bossMusic))
         {
            _loc1_ = this._bossMusic;
         }
         else
         {
            _loc1_ = this._fightMusic;
         }
         if(_loc1_)
         {
            _loc2_ = SoundUtil.getBusIdBySoundId(String(_loc1_.id));
            _loc3_ = SoundUtil.getConfigEntryByBusId(_loc2_);
            _loc4_ = new Uri(_loc3_ + _loc1_.id + ".mp3");
            if(SoundManager.getInstance().manager is ClassicSoundManager)
            {
               this._actualFightMusic = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,_loc4_);
            }
            if(SoundManager.getInstance().manager is RegSoundManager)
            {
               this._actualFightMusic = new SoundDofus(String(_loc1_.id));
            }
            this._actualFightMusic.busId = _loc2_;
            this._actualFightMusic.volume = 1;
            this._actualFightMusic.currentFadeVolume = 0;
            _loc5_ = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
            this._actualFightMusic.play(true,0,_loc5_);
         }
      }
      
      public function stopFightMusic() : void {
         if(!SoundManager.getInstance().manager.soundIsActivate || this._actualFightMusic == null)
         {
            return;
         }
         if(SoundManager.getInstance().manager is RegSoundManager && !RegConnectionManager.getInstance().isMain)
         {
            return;
         }
         var _loc1_:VolumeFadeEffect = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
         this._actualFightMusic.stop(_loc1_);
         SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID,SoundManager.getInstance().options["volumeAmbientSound"],TubulSoundConfiguration.TIME_FADE_IN_MUSIC * 2);
         SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID,SoundManager.getInstance().options["volumeMusic"],TubulSoundConfiguration.TIME_FADE_IN_MUSIC * 2);
      }
      
      public function setFightSounds(param1:Vector.<AmbientSound>, param2:Vector.<AmbientSound>) : void {
         var _loc4_:AmbientSound = null;
         this._fightMusics = param1;
         this._bossMusics = param2;
         var _loc3_:* = "";
         if(this._fightMusics.length == 0 && this._bossMusics.length == 0)
         {
            _loc3_ = "Ni musique de combat, ni musique de boss ???";
         }
         else
         {
            _loc3_ = "Cette map contient les musiques de combat : ";
            for each (_loc4_ in this._fightMusics)
            {
               _loc3_ = _loc3_ + (_loc4_.id + ", ");
            }
            _loc3_ = " et les musiques de boss d\'id : ";
            for each (_loc4_ in this._bossMusics)
            {
               _loc3_ = _loc3_ + (_loc4_.id + ", ");
            }
         }
         _log.info(_loc3_);
      }
      
      public function selectValidSounds() : void {
         var _loc2_:AmbientSound = null;
         var _loc3_:* = 0;
         var _loc1_:* = 0;
         for each (_loc2_ in this._fightMusics)
         {
            _loc1_++;
         }
         _loc3_ = int(Math.random() * _loc1_);
         for each (_loc2_ in this._fightMusics)
         {
            if(_loc3_ == 0)
            {
               this._fightMusic = _loc2_;
               break;
            }
            _loc3_--;
         }
         _loc1_ = 0;
         for each (_loc2_ in this._bossMusics)
         {
            _loc1_++;
         }
         _loc3_ = int(Math.random() * _loc1_);
         for each (_loc2_ in this._bossMusics)
         {
            if(_loc3_ == 0)
            {
               this._bossMusic = _loc2_;
               break;
            }
            _loc3_--;
         }
      }
      
      private function init() : void {
         this._fightMusicsId = TubulSoundConfiguration.fightMusicIds;
         this._fightMusicBalanceManager = new BalanceManager(this._fightMusicsId);
      }
   }
}
