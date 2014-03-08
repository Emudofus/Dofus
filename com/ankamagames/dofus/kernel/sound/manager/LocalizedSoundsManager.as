package com.ankamagames.dofus.kernel.sound.manager
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.kernel.sound.type.LocalizedMapSound;
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.map.elements.SoundElement;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.dofus.kernel.sound.utils.SoundUtil;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.tubul.factory.SoundFactory;
   import com.ankamagames.tubul.enum.EnumSoundType;
   import com.ankamagames.tubul.types.sounds.LocalizedSound;
   import com.ankamagames.tubul.types.SoundSilence;
   import com.ankamagames.tubul.Tubul;
   import com.ankamagames.dofus.kernel.sound.type.SoundDofus;
   
   public class LocalizedSoundsManager extends Object
   {
      
      public function LocalizedSoundsManager() {
         super();
         this._isInitialized = false;
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LocalizedSoundsManager));
      
      private var _localizedSounds:Vector.<LocalizedMapSound>;
      
      private var _sounds:Vector.<ISound>;
      
      private var _isInitialized:Boolean;
      
      public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public function setMap(param1:Map) : void {
         var _loc2_:Layer = null;
         var _loc3_:Cell = null;
         var _loc4_:BasicElement = null;
         var _loc5_:SoundElement = null;
         var _loc6_:LocalizedMapSound = null;
         this.removeLocalizedSounds();
         for each (_loc2_ in param1.layers)
         {
            for each (_loc3_ in _loc2_.cells)
            {
               for each (_loc4_ in _loc3_.elements)
               {
                  if(_loc4_ is SoundElement)
                  {
                     _loc5_ = _loc4_ as SoundElement;
                     _loc6_ = new LocalizedMapSound(_loc5_.soundId.toString(),_loc5_.cell.pixelCoords,_loc5_.nullVolumeDistance,_loc5_.fullVolumeDistance,_loc5_.minDelayBetweenLoops,_loc5_.maxDelayBetweenLoops,_loc5_.baseVolume);
                     this._localizedSounds.push(_loc6_);
                  }
               }
            }
         }
         this._isInitialized = true;
      }
      
      public function playLocalizedSounds() : void {
         var _loc1_:LocalizedMapSound = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:Uri = null;
         var _loc5_:ISound = null;
         for each (_loc1_ in this._localizedSounds)
         {
            _loc2_ = SoundUtil.getBusIdBySoundId(_loc1_.soundId);
            _loc3_ = SoundUtil.getConfigEntryByBusId(_loc2_);
            _loc4_ = new Uri(_loc3_ + _loc1_.soundId + ".mp3");
            if(SoundManager.getInstance().manager is ClassicSoundManager)
            {
               _loc5_ = SoundFactory.getSound(EnumSoundType.LOCALIZED_SOUND,_loc4_);
               _loc5_.busId = _loc2_;
               (_loc5_ as LocalizedSound).saturationRange = _loc1_.saturationRange;
               (_loc5_ as LocalizedSound).silence = new SoundSilence(_loc1_.silenceMin,_loc1_.silenceMax);
               (_loc5_ as LocalizedSound).range = _loc1_.range;
               (_loc5_ as LocalizedSound).volumeMax = _loc1_.volumeMax;
               (_loc5_ as LocalizedSound).position = _loc1_.position;
               (_loc5_ as LocalizedSound).updateObserverPosition(Tubul.getInstance().earPosition);
               SoundManager.getInstance().manager.playSound(_loc5_);
            }
            if(SoundManager.getInstance().manager is RegSoundManager)
            {
               _loc5_ = new SoundDofus(_loc1_.soundId);
               _loc5_.busId = _loc2_;
               (_loc5_ as SoundDofus).saturationRange = _loc1_.saturationRange;
               (_loc5_ as SoundDofus).silence = new SoundSilence(_loc1_.silenceMin,_loc1_.silenceMax);
               (_loc5_ as SoundDofus).range = _loc1_.range;
               (_loc5_ as SoundDofus).volumeMax = _loc1_.volumeMax;
               (_loc5_ as SoundDofus).position = _loc1_.position;
               _loc5_.play();
            }
            this._sounds.push(_loc5_);
         }
      }
      
      public function stopLocalizedSounds() : void {
         var _loc1_:ISound = null;
         for each (_loc1_ in this._sounds)
         {
            _loc1_.stop();
            _loc1_ = null;
         }
         this._sounds = new Vector.<ISound>();
      }
      
      private function removeLocalizedSounds() : void {
         this.stopLocalizedSounds();
         this._localizedSounds = new Vector.<LocalizedMapSound>();
      }
   }
}
