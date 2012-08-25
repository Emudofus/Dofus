package com.ankamagames.tiphon.display
{
    import com.ankamagames.tiphon.types.*;
    import flash.display.*;
    import flash.utils.*;

    public class RasterizedSyncAnimation extends RasterizedAnimation
    {
        private static var _events:Dictionary = new Dictionary(true);

        public function RasterizedSyncAnimation(param1:MovieClip, param2:String)
        {
            var _loc_3:String = null;
            super(param1, param2);
            _target = param1;
            _totalFrames = _target.totalFrames;
            spriteHandler = (param1 as ScriptedAnimation).spriteHandler;
            switch(spriteHandler.getDirection())
            {
                case 1:
                case 3:
                {
                    _loc_3 = spriteHandler.getAnimation() + "_1";
                    break;
                }
                case 5:
                case 7:
                {
                    _loc_3 = spriteHandler.getAnimation() + "_5";
                    break;
                }
                default:
                {
                    _loc_3 = spriteHandler.getAnimation() + "_" + spriteHandler.getDirection();
                    break;
                }
            }
            if (spriteHandler != null)
            {
                spriteHandler.tiphonEventManager.parseLabels(currentScene, _loc_3);
            }
            return;
        }// end function

        override public function gotoAndStop(param1:Object, param2:String = null) : void
        {
            var _loc_3:* = param1 as uint;
            if (_loc_3 > 0)
            {
                _loc_3 = _loc_3 - 1;
            }
            this.displayFrame(_loc_3 % _totalFrames);
            return;
        }// end function

        override public function gotoAndPlay(param1:Object, param2:String = null) : void
        {
            this.gotoAndStop(param1, param2);
            play();
            return;
        }// end function

        override protected function displayFrame(param1:uint) : Boolean
        {
            var _loc_2:* = super.displayFrame(param1);
            if (_loc_2)
            {
                spriteHandler.tiphonEventManager.dispatchEvents(param1);
            }
            return _loc_2;
        }// end function

    }
}
