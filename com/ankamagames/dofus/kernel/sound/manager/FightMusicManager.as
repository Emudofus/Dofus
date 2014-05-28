package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
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
      
      private static const _log:Logger;
      
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
         var entity:GameContextActorInformations = null;
         var monster:GameFightMonsterInformations = null;
         var monsterData:Monster = null;
         this._hasBoss = false;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(entitiesFrame)
         {
            for each(entity in entitiesFrame.getEntitiesDictionnary())
            {
               if(entity is GameFightMonsterInformations)
               {
                  monster = entity as GameFightMonsterInformations;
                  monsterData = Monster.getMonsterById(monster.creatureGenericId);
                  if(monsterData.isBoss)
                  {
                     this._hasBoss = true;
                  }
               }
            }
         }
      }
      
      public function playFightMusic() : void {
         var sound:AmbientSound = null;
         var busId:uint = 0;
         var soundPath:String = null;
         var soundUri:Uri = null;
         var fadeCurrentMusic:VolumeFadeEffect = null;
         if(!SoundManager.getInstance().manager.soundIsActivate)
         {
            return;
         }
         if((SoundManager.getInstance().manager is RegSoundManager) && (!RegConnectionManager.getInstance().isMain))
         {
            return;
         }
         if((this._hasBoss) && (this._bossMusic))
         {
            sound = this._bossMusic;
         }
         else
         {
            sound = this._fightMusic;
         }
         if(sound)
         {
            busId = SoundUtil.getBusIdBySoundId(String(sound.id));
            soundPath = SoundUtil.getConfigEntryByBusId(busId);
            soundUri = new Uri(soundPath + sound.id + ".mp3");
            if(SoundManager.getInstance().manager is ClassicSoundManager)
            {
               this._actualFightMusic = SoundFactory.getSound(EnumSoundType.UNLOCALIZED_SOUND,soundUri);
            }
            if(SoundManager.getInstance().manager is RegSoundManager)
            {
               this._actualFightMusic = new SoundDofus(String(sound.id));
            }
            this._actualFightMusic.busId = busId;
            this._actualFightMusic.volume = 1;
            this._actualFightMusic.currentFadeVolume = 0;
            fadeCurrentMusic = new VolumeFadeEffect(-1,1,TubulSoundConfiguration.TIME_FADE_IN_MUSIC);
            this._actualFightMusic.play(true,0,fadeCurrentMusic);
         }
      }
      
      public function stopFightMusic() : void {
         if((!SoundManager.getInstance().manager.soundIsActivate) || (this._actualFightMusic == null))
         {
            return;
         }
         if((SoundManager.getInstance().manager is RegSoundManager) && (!RegConnectionManager.getInstance().isMain))
         {
            return;
         }
         var stopFadeMusic:VolumeFadeEffect = new VolumeFadeEffect(-1,0,TubulSoundConfiguration.TIME_FADE_OUT_MUSIC);
         this._actualFightMusic.stop(stopFadeMusic);
         SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID,SoundManager.getInstance().options["volumeAmbientSound"],TubulSoundConfiguration.TIME_FADE_IN_MUSIC * 2);
         SoundManager.getInstance().manager.fadeBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID,SoundManager.getInstance().options["volumeMusic"],TubulSoundConfiguration.TIME_FADE_IN_MUSIC * 2);
      }
      
      public function setFightSounds(pFightMusic:Vector.<AmbientSound>, pBossMusic:Vector.<AmbientSound>) : void {
         var asound:AmbientSound = null;
         this._fightMusics = pFightMusic;
         this._bossMusics = pBossMusic;
         var logText:String = "";
         if((this._fightMusics.length == 0) && (this._bossMusics.length == 0))
         {
            logText = "Ni musique de combat, ni musique de boss ???";
         }
         else
         {
            logText = "Cette map contient les musiques de combat : ";
            for each(asound in this._fightMusics)
            {
               logText = logText + (asound.id + ", ");
            }
            logText = " et les musiques de boss d\'id : ";
            for each(asound in this._bossMusics)
            {
               logText = logText + (asound.id + ", ");
            }
         }
         _log.info(logText);
      }
      
      public function selectValidSounds() : void {
         var ambientSound:AmbientSound = null;
         var rnd:* = 0;
         var count:int = 0;
         for each(ambientSound in this._fightMusics)
         {
            count++;
         }
         rnd = int(Math.random() * count);
         for each(ambientSound in this._fightMusics)
         {
            if(rnd == 0)
            {
               this._fightMusic = ambientSound;
               break;
            }
            rnd--;
         }
         count = 0;
         for each(ambientSound in this._bossMusics)
         {
            count++;
         }
         rnd = int(Math.random() * count);
         for each(ambientSound in this._bossMusics)
         {
            if(rnd == 0)
            {
               this._bossMusic = ambientSound;
               break;
            }
            rnd--;
         }
      }
      
      private function init() : void {
         this._fightMusicsId = TubulSoundConfiguration.fightMusicIds;
         this._fightMusicBalanceManager = new BalanceManager(this._fightMusicsId);
      }
   }
}
