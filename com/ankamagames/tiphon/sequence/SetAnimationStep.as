package com.ankamagames.tiphon.sequence
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class SetAnimationStep extends AbstractSequencable
   {
      
      public function SetAnimationStep(target:TiphonSprite, animation:String) {
         super();
         this._target = target;
         this._animation = animation;
      }
      
      private var _animation:String;
      
      private var _target:TiphonSprite;
      
      public function get animation() : String {
         return this._animation;
      }
      
      public function get target() : TiphonSprite {
         return this._target;
      }
      
      override public function start() : void {
         this._target.setAnimation(this._animation);
         executeCallbacks();
      }
      
      override public function toString() : String {
         return "set animation " + this._animation + " on " + this._target.name;
      }
   }
}
