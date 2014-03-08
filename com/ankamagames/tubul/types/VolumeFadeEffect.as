package com.ankamagames.tubul.types
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tubul.interfaces.ISoundController;
   import gs.TweenMax;
   import com.ankamagames.tubul.types.bus.AudioBus;
   import com.ankamagames.tubul.types.sounds.MP3SoundDofus;
   import gs.easing.Linear;
   import com.ankamagames.tubul.events.FadeEvent;
   
   public class VolumeFadeEffect extends EventDispatcher
   {
      
      public function VolumeFadeEffect(param1:Number=0, param2:Number=1, param3:Number=0) {
         super();
         this._beginningValue = param1;
         this._endingValue = param2;
         this._timeFade = param3;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(VolumeFadeEffect));
      
      private var _running:Boolean = false;
      
      private var _beginningValue:Number;
      
      private var _endingValue:Number;
      
      private var _timeFade:Number;
      
      private var _soundSource:ISoundController;
      
      private var _tween:TweenMax;
      
      public function get running() : Boolean {
         return this._running;
      }
      
      public function get beginningValue() : Number {
         return this._beginningValue;
      }
      
      public function get endingValue() : Number {
         return this._endingValue;
      }
      
      public function get timeFade() : Number {
         return this._timeFade;
      }
      
      private function get soundSource() : ISoundController {
         return this._soundSource;
      }
      
      public function attachToSoundSource(param1:ISoundController) : void {
         this._soundSource = param1;
      }
      
      public function start(param1:Boolean=true) : void {
         var _loc2_:String = null;
         if(this.soundSource == null)
         {
            _log.warn("L\'effet de fade ne peut être lancé car le son auquel il est attaché ne peut être trouvé");
            return;
         }
         if(this._endingValue < 0 || this._endingValue > 1)
         {
            _log.warn("Le paramètre \'endingValue\' n\'est pas valide !");
            return;
         }
         if(this.soundSource is AudioBus)
         {
            _loc2_ = "Fade sur le bus " + (this.soundSource as AudioBus).name;
         }
         if(this.soundSource is MP3SoundDofus)
         {
            _loc2_ = "Fade sur le son " + (this.soundSource as MP3SoundDofus).id + "(" + (this.soundSource as MP3SoundDofus).uri.fileName + ")";
         }
         _log.warn(_loc2_ + " / => " + this._endingValue + " en " + this._timeFade + " sec.");
         this.clearTween();
         if((param1) && this._beginningValue >= 0)
         {
            this.soundSource.currentFadeVolume = this._beginningValue;
         }
         this._tween = new TweenMax(this.soundSource,this._timeFade,
            {
               "currentFadeVolume":this._endingValue,
               "onComplete":this.onFadeEnd,
               "ease":Linear.easeNone
            });
         this._running = true;
      }
      
      public function stop() : void {
         this.clearTween();
         this.onFadeEnd();
      }
      
      public function reset(param1:Number, param2:Number, param3:Number) : void {
         this.clearTween();
         this._beginningValue = param1;
         this._endingValue = param2;
         this._timeFade = param3;
      }
      
      public function clone() : VolumeFadeEffect {
         var _loc1_:VolumeFadeEffect = new VolumeFadeEffect(this._beginningValue,this._endingValue,this._timeFade);
         return _loc1_;
      }
      
      private function clearTween() : void {
         if(this._tween)
         {
            this._tween.clear();
            this._tween = null;
         }
         this._running = false;
      }
      
      private function onFadeEnd() : void {
         var _loc1_:FadeEvent = new FadeEvent(FadeEvent.COMPLETE);
         _loc1_.soundSource = this.soundSource;
         dispatchEvent(_loc1_);
         this.clearTween();
      }
   }
}
