package com.ankamagames.dofus.kernel.sound.type
{
   import com.ankamagames.tubul.interfaces.ISound;
   import com.ankamagames.tubul.interfaces.ILocalizedSound;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import __AS3__.vec.Vector;
   import com.ankamagames.tubul.interfaces.IEffect;
   import com.ankamagames.tubul.types.SoundSilence;
   import flash.geom.Point;
   import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
   import com.ankamagames.jerakine.protocolAudio.ProtocolEnum;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import com.ankamagames.tubul.interfaces.IAudioBus;
   import com.ankamagames.tubul.Tubul;
   import com.ankamagames.tubul.types.VolumeFadeEffect;
   import com.ankamagames.jerakine.newCache.ICache;
   
   public class SoundDofus extends Object implements ISound, ILocalizedSound
   {
      
      public function SoundDofus(param1:String, param2:Boolean=false) {
         super();
         this.init();
         if((_cache[param1]) && (param2))
         {
            this._id = _cache[param1];
         }
         else
         {
            this._id = _currentId--;
            if(param2)
            {
               _cache[param1] = this._id;
            }
         }
         this._soundId = param1;
         RegConnectionManager.getInstance().send(ProtocolEnum.ADD_SOUND,this._id,this._soundId,true);
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundDofus));
      
      private static var _currentId:int = -1;
      
      private static var _cache:Dictionary = new Dictionary();
      
      protected var _busId:int;
      
      protected var _id:int;
      
      protected var _soundId:String;
      
      protected var _uri:Uri;
      
      protected var _volume:Number;
      
      protected var _fadeVolume:Number;
      
      protected var _busVolume:Number;
      
      protected var _loop:Boolean = false;
      
      protected var _noCutSilence:Boolean;
      
      protected var _effects:Vector.<IEffect>;
      
      protected var _silence:SoundSilence;
      
      private var _pan:Number;
      
      private var _position:Point;
      
      private var _range:Number;
      
      private var _saturationRange:Number;
      
      private var _observerPosition:Point;
      
      private var _volumeMax:Number;
      
      public function get duration() : Number {
         _log.warn("Cette propriété (\'duration\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return 0;
      }
      
      public function get stereo() : Boolean {
         _log.warn("Cette propriété (\'stereo\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return false;
      }
      
      public function get totalLoops() : int {
         _log.warn("Cette propriété (\'totalLoops\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return -1;
      }
      
      public function get currentLoop() : uint {
         _log.warn("Cette propriété (\'currentLoop\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return 0;
      }
      
      public function get pan() : Number {
         _log.warn("Cette propriété (\'pan\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return this._pan;
      }
      
      public function set pan(param1:Number) : void {
         if(param1 < -1)
         {
            this._pan = -1;
         }
         if(param1 > 1)
         {
            this._pan = 1;
         }
         this._pan = param1;
      }
      
      public function get range() : Number {
         return this._range;
      }
      
      public function set range(param1:Number) : void {
         if(param1 < this._saturationRange)
         {
            param1 = this._saturationRange;
         }
         this._range = param1;
      }
      
      public function get saturationRange() : Number {
         return this._saturationRange;
      }
      
      public function set saturationRange(param1:Number) : void {
         if(param1 >= this._range)
         {
            param1 = this._range;
         }
         this._saturationRange = param1;
      }
      
      public function get position() : Point {
         return this._position;
      }
      
      public function set position(param1:Point) : void {
         this._position = param1;
      }
      
      public function get volumeMax() : Number {
         return this._volumeMax;
      }
      
      public function set volumeMax(param1:Number) : void {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._volumeMax = param1;
      }
      
      public function get effects() : Vector.<IEffect> {
         return this._effects;
      }
      
      public function get volume() : Number {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._volume = param1;
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_VOLUME,this._id,param1);
      }
      
      public function get currentFadeVolume() : Number {
         return this._fadeVolume;
      }
      
      public function set currentFadeVolume(param1:Number) : void {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._fadeVolume = param1;
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_FADE_VOLUME,this._id,param1);
      }
      
      public function get effectiveVolume() : Number {
         _log.warn("Cette propriété (\'effectiveVolume\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return 0;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get eventDispatcher() : EventDispatcher {
         _log.warn("Cette propriété (\'eventDispatcher\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return null;
      }
      
      public function get sound() : Sound {
         _log.warn("Cette propriété (\'sound\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return null;
      }
      
      public function set sound(param1:*) : void {
      }
      
      public function get busId() : int {
         return this._busId;
      }
      
      public function set busId(param1:int) : void {
      }
      
      public function get bus() : IAudioBus {
         _log.warn("Cette propriété (\'bus\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return Tubul.getInstance().getBus(this.busId);
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function get noCutSilence() : Boolean {
         _log.warn("Cette propriété (\'noCutSilence\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return this._noCutSilence;
      }
      
      public function set noCutSilence(param1:Boolean) : void {
         this._noCutSilence = param1;
         var _loc2_:Object = new Object();
         _loc2_.noCutSilence = param1;
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_SOUND_PROPERTIES,this._id,_loc2_);
      }
      
      public function get isPlaying() : Boolean {
         _log.warn("Cette propriété (\'isPlaying\') ne renvoie pas une valeur correcte ! La classe SoundDofus sert juste de passerelle entre DOFUS et REG !");
         return true;
      }
      
      public function get silence() : SoundSilence {
         return this._silence;
      }
      
      public function set silence(param1:SoundSilence) : void {
         this._silence = param1;
      }
      
      public function setCurrentLoop(param1:uint) : void {
      }
      
      public function addEffect(param1:IEffect) : void {
      }
      
      public function removeEffect(param1:IEffect) : void {
      }
      
      public function applyDynamicMix(param1:VolumeFadeEffect, param2:uint, param3:VolumeFadeEffect) : void {
      }
      
      public function play(param1:Boolean=false, param2:int=0, param3:VolumeFadeEffect=null, param4:VolumeFadeEffect=null) : void {
         var _loc5_:Number = -1;
         var _loc6_:Number = -1;
         var _loc7_:Number = -1;
         var _loc8_:Number = -1;
         var _loc9_:Number = -1;
         var _loc10_:Number = -1;
         if(param3)
         {
            _loc5_ = param3.beginningValue;
            _loc6_ = param3.endingValue;
            _loc7_ = param3.timeFade;
         }
         if(param4)
         {
            _loc8_ = param4.beginningValue;
            _loc9_ = param4.endingValue;
            _loc10_ = param4.timeFade;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.PLAY_SOUND,this._id,this._soundId,param1,param2,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
      }
      
      public function stop(param1:VolumeFadeEffect=null) : void {
         var _loc2_:Number = -1;
         var _loc3_:Number = -1;
         var _loc4_:Number = -1;
         if(param1 != null)
         {
            _loc2_ = param1.beginningValue;
            _loc3_ = param1.endingValue;
            _loc4_ = param1.timeFade;
         }
         RegConnectionManager.getInstance().send(ProtocolEnum.STOP_SOUND,this._id,_loc2_,_loc3_,_loc4_);
      }
      
      public function loadSound(param1:ICache) : void {
      }
      
      public function setLoops(param1:int) : void {
         RegConnectionManager.getInstance().send(ProtocolEnum.SET_LOOPS,this._id,param1);
      }
      
      public function clone() : ISound {
         _log.warn("Can\'t clone a SoundDofus !");
         return null;
      }
      
      private function init() : void {
         this._fadeVolume = 1;
         this._busVolume = 1;
         this._volume = 1;
      }
   }
}
