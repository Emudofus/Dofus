package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class DynamicSprite extends MovieClip
    {
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function DynamicSprite()
        {
            MEMORY_LOG[this] = 1;
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            return;
        }// end function

        protected function getRoot() : ScriptedAnimation
        {
            return this._getRoot();
        }// end function

        public function init(param1:IAnimationSpriteHandler) : void
        {
            return;
        }// end function

        private function onAdded(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            var _loc_2:* = event.target as DisplayObject;
            while (!(_loc_2 is TiphonSprite) && _loc_2.parent)
            {
                
                _loc_2 = _loc_2.parent;
            }
            if (_loc_2 is TiphonSprite)
            {
                this.init(_loc_2 as TiphonSprite);
            }
            return;
        }// end function

        private function _getRoot() : ScriptedAnimation
        {
            var _loc_1:* = this;
            while (_loc_1)
            {
                
                if (_loc_1 is ScriptedAnimation)
                {
                    return _loc_1 as ScriptedAnimation;
                }
                _loc_1 = _loc_1.parent;
            }
            return null;
        }// end function

    }
}
