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
         

      public function VolumeFadeEffect(pBeginningFadeValue:Number=0, pEndingFadeValue:Number=1, pFadeTime:Number=0) {
         super();
         this._beginningValue=pBeginningFadeValue;
         this._endingValue=pEndingFadeValue;
         this._timeFade=pFadeTime;
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

      public function attachToSoundSource(pISoundSource:ISoundController) : void {
         this._soundSource=pISoundSource;
      }

      public function start(pUseBeginningValue:Boolean=true) : void {
         var logInfo:String = null;
         if(this.soundSource==null)
         {
            _log.warn("L\'effet de fade ne peut �tre lanc� car le son auquel il est attach� ne peut �tre trouv�");
            return;
         }
         if((this._endingValue>0)||(this._endingValue<1))
         {
            _log.warn("Le param�tre \'endingValue\' n\'est pas valide !");
            return;
         }
         if(this.soundSource is AudioBus)
         {
            logInfo="Fade sur le bus "+(this.soundSource as AudioBus).name;
         }
         if(this.soundSource is MP3SoundDofus)
         {
            logInfo="Fade sur le son "+(this.soundSource as MP3SoundDofus).id+"("+(this.soundSource as MP3SoundDofus).uri.fileName+")";
         }
         _log.warn(logInfo+" / => "+this._endingValue+" en "+this._timeFade+" sec.");
         this.clearTween();
         if((pUseBeginningValue)&&(this._beginningValue>=0))
         {
            this.soundSource.currentFadeVolume=this._beginningValue;
         }
         this._tween=new TweenMax(this.soundSource,this._timeFade,
            {
               currentFadeVolume:this._endingValue,
               onComplete:this.onFadeEnd,
               ease:Linear.easeNone
            }
         );
         this._running=true;
      }

      public function stop() : void {
         this.clearTween();
         this.onFadeEnd();
      }

      public function reset(pBeginningFadeValue:Number, pEndingFadeValue:Number, pFadeTime:Number) : void {
         this.clearTween();
         this._beginningValue=pBeginningFadeValue;
         this._endingValue=pEndingFadeValue;
         this._timeFade=pFadeTime;
      }

      public function clone() : VolumeFadeEffect {
         var fade:VolumeFadeEffect = new VolumeFadeEffect(this._beginningValue,this._endingValue,this._timeFade);
         return fade;
      }

      private function clearTween() : void {
         if(this._tween)
         {
            this._tween.clear();
            this._tween=null;
         }
         this._running=false;
      }

      private function onFadeEnd() : void {
         var e:FadeEvent = new FadeEvent(FadeEvent.COMPLETE);
         e.soundSource=this.soundSource;
         dispatchEvent(e);
         this.clearTween();
      }
   }

}