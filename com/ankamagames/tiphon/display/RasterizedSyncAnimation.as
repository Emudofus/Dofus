package com.ankamagames.tiphon.display
{
   import flash.utils.Dictionary;
   import flash.display.MovieClip;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   
   public class RasterizedSyncAnimation extends RasterizedAnimation
   {
      
      public function RasterizedSyncAnimation(param1:MovieClip, param2:String) {
         var _loc3_:String = null;
         super(param1,param2);
         _target = param1;
         _totalFrames = _target.totalFrames;
         spriteHandler = (param1 as ScriptedAnimation).spriteHandler;
         switch(spriteHandler.getDirection())
         {
            case 1:
            case 3:
               _loc3_ = spriteHandler.getAnimation() + "_1";
               break;
            case 5:
            case 7:
               _loc3_ = spriteHandler.getAnimation() + "_5";
               break;
            default:
               _loc3_ = spriteHandler.getAnimation() + "_" + spriteHandler.getDirection();
         }
         if(spriteHandler != null)
         {
            spriteHandler.tiphonEventManager.parseLabels(currentScene,_loc3_);
         }
      }
      
      private static var _events:Dictionary = new Dictionary(true);
      
      override public function gotoAndStop(param1:Object, param2:String=null) : void {
         var _loc3_:uint = param1 as uint;
         if(_loc3_ > 0)
         {
            _loc3_--;
         }
         this.displayFrame(_loc3_ % _totalFrames);
      }
      
      override public function gotoAndPlay(param1:Object, param2:String=null) : void {
         this.gotoAndStop(param1,param2);
         play();
      }
      
      override protected function displayFrame(param1:uint) : Boolean {
         var _loc2_:Boolean = super.displayFrame(param1);
         if(_loc2_)
         {
            spriteHandler.tiphonEventManager.dispatchEvents(param1);
         }
         return _loc2_;
      }
   }
}
