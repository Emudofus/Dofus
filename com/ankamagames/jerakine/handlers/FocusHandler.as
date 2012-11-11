package com.ankamagames.jerakine.handlers
{
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.display.*;

    public class FocusHandler extends Object
    {
        private static var _self:FocusHandler;
        private static var _currentFocus:WeakReference;

        public function FocusHandler()
        {
            if (_self != null)
            {
                throw new SingletonError("FocusHandler constructor should not be called directly.");
            }
            StageShareManager.stage.stageFocusRect = false;
            return;
        }// end function

        public function setFocus(param1:InteractiveObject) : void
        {
            _currentFocus = new WeakReference(param1);
            return;
        }// end function

        public function getFocus() : InteractiveObject
        {
            return _currentFocus ? (_currentFocus.object as InteractiveObject) : (null);
        }// end function

        public function hasFocus(param1:InteractiveObject) : Boolean
        {
            if (_currentFocus)
            {
                return _currentFocus.object == param1;
            }
            return false;
        }// end function

        public static function getInstance() : FocusHandler
        {
            if (_self == null)
            {
                _self = new FocusHandler;
            }
            return _self;
        }// end function

    }
}
