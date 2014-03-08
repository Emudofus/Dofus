package com.ankamagames.tiphon.sequence
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class SetDirectionStep extends AbstractSequencable
   {
      
      public function SetDirectionStep(param1:TiphonSprite, param2:uint) {
         super();
         this._target = param1;
         this._nDirection = param2;
      }
      
      private var _nDirection:uint;
      
      private var _target:TiphonSprite;
      
      override public function start() : void {
         if(!this._target.getAnimation() || (this._target.hasAnimation(this._target.getAnimation(),this._nDirection)))
         {
            this._target.setDirection(this._nDirection);
         }
         else
         {
            _log.error("[SetDirectionStep] La direction " + this._nDirection + " n\'est pas disponible sur l\'animation " + this._target.getAnimation() + " du bones " + this._target.look.getBone());
         }
         executeCallbacks();
      }
      
      override public function toString() : String {
         return "set direction " + this._nDirection + " on " + this._target.name;
      }
   }
}
