package com.ankamagames.atouin.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import flash.events.*;
    import flash.utils.*;

    final public class AnimatedElementManager extends Object
    {
        private var _sequenceRef:Dictionary;
        private static var _elements:Vector.<AnimatedElementInfo>;
        private static const SEQUENCE_TYPE_NAME:String = "AnimatedElementManager_sequence";

        public function AnimatedElementManager()
        {
            this._sequenceRef = new Dictionary(true);
            return;
        }// end function

        public static function reset() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (_elements)
            {
                _loc_1 = _elements.length;
                _loc_2 = -1;
                while (++_loc_2 < _loc_1)
                {
                    
                    _loc_3 = _elements[_loc_2];
                    _loc_3.tiphonSprite.destroy();
                }
            }
            _elements = new Vector.<AnimatedElementInfo>;
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, loop);
            return;
        }// end function

        public static function addAnimatedElement(param1:TiphonSprite, param2:int, param3:int) : void
        {
            if (_elements.length == 0)
            {
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, loop);
            }
            _elements.push(new AnimatedElementInfo(param1, param2, param3));
            return;
        }// end function

        public static function removeAnimatedElement(param1:TiphonSprite) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            while (_loc_2 < _elements.length)
            {
                
                _loc_3 = _elements[_loc_2];
                if (_loc_3.tiphonSprite == param1)
                {
                    _elements.splice(_loc_2, 1);
                    if (_elements.length == 0)
                    {
                        StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, loop);
                        SerialSequencer.clearByType(SEQUENCE_TYPE_NAME);
                    }
                    return;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public static function loop(event:Event) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = getTimer();
            var _loc_3:* = -1;
            var _loc_4:* = _elements.length;
            while (++_loc_3 < _loc_4)
            {
                
                _loc_5 = _elements[_loc_3];
                if (_loc_2 - _loc_5.nextAnimation > 0)
                {
                    _loc_5.setNextAnimation();
                    _loc_6 = new SerialSequencer(SEQUENCE_TYPE_NAME);
                    _loc_6.addStep(new PlayAnimationStep(_loc_5.tiphonSprite, "AnimStart", false));
                    _loc_6.addStep(new SetAnimationStep(_loc_5.tiphonSprite, "AnimStatique"));
                    _loc_6.addStep(new CallbackStep(new Callback(onSequenceEnd, _loc_6, _loc_5.tiphonSprite)));
                    _loc_6.start();
                }
            }
            return;
        }// end function

        private static function onSequenceEnd(param1:SerialSequencer, param2:TiphonSprite) : void
        {
            param1.clear();
            if (param2.getAnimation() == "AnimStart")
            {
                param2.stopAnimation();
            }
            return;
        }// end function

    }
}
