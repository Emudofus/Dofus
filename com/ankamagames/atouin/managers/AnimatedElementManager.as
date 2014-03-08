package com.ankamagames.atouin.managers
{
   import __AS3__.vec.Vector;
   import com.ankamagames.atouin.types.AnimatedElementInfo;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import flash.utils.getTimer;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.types.Callback;
   import flash.utils.Dictionary;
   
   public final class AnimatedElementManager extends Object
   {
      
      public function AnimatedElementManager() {
         this._sequenceRef = new Dictionary(true);
         super();
      }
      
      private static var _elements:Vector.<AnimatedElementInfo>;
      
      private static const SEQUENCE_TYPE_NAME:String = "AnimatedElementManager_sequence";
      
      private static const MAX_ANIMATION_LENGTH:int = 20000;
      
      public static function reset() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:AnimatedElementInfo = null;
         if(_elements)
         {
            _loc1_ = _elements.length;
            _loc2_ = -1;
            while(++_loc2_ < _loc1_)
            {
               _loc3_ = _elements[_loc2_];
               _loc3_.tiphonSprite.destroy();
            }
         }
         _elements = new Vector.<AnimatedElementInfo>();
         StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,loop);
      }
      
      public static function addAnimatedElement(param1:TiphonSprite, param2:int, param3:int) : void {
         if(_elements.length == 0)
         {
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,loop);
         }
         _elements.push(new AnimatedElementInfo(param1,param2,param3));
      }
      
      public static function removeAnimatedElement(param1:TiphonSprite) : void {
         var _loc2_:uint = 0;
         var _loc3_:AnimatedElementInfo = null;
         while(_loc2_ < _elements.length)
         {
            _loc3_ = _elements[_loc2_];
            if(_loc3_.tiphonSprite == param1)
            {
               _elements.splice(_loc2_,1);
               if(_elements.length == 0)
               {
                  StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,loop);
                  SerialSequencer.clearByType(SEQUENCE_TYPE_NAME);
               }
               return;
            }
            _loc2_++;
         }
      }
      
      public static function loop(param1:Event) : void {
         var _loc5_:AnimatedElementInfo = null;
         var _loc6_:SerialSequencer = null;
         var _loc7_:PlayAnimationStep = null;
         var _loc2_:int = getTimer();
         var _loc3_:* = -1;
         var _loc4_:int = _elements.length;
         while(++_loc3_ < _loc4_)
         {
            _loc5_ = _elements[_loc3_];
            if(_loc2_ - _loc5_.nextAnimation > 0)
            {
               _loc5_.setNextAnimation();
               _loc6_ = new SerialSequencer(SEQUENCE_TYPE_NAME);
               _loc7_ = new PlayAnimationStep(_loc5_.tiphonSprite,"AnimStart",false);
               _loc7_.timeout = MAX_ANIMATION_LENGTH;
               _loc6_.addStep(_loc7_);
               _loc6_.addStep(new SetAnimationStep(_loc5_.tiphonSprite,"AnimStatique"));
               _loc6_.addStep(new CallbackStep(new Callback(onSequenceEnd,_loc6_,_loc5_.tiphonSprite)));
               _loc6_.start();
            }
         }
      }
      
      private static function onSequenceEnd(param1:SerialSequencer, param2:TiphonSprite) : void {
         param1.clear();
         if(param2.getAnimation() == "AnimStart")
         {
            param2.stopAnimation();
         }
      }
      
      private var _sequenceRef:Dictionary;
   }
}
