package com.ankamagames.berilia.managers
{
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.utils.errors.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.display.*;
    import flash.utils.*;

    public class UIEventManager extends Object
    {
        private var _dInstanceIndex:Dictionary;
        private static var _self:UIEventManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UIEventManager));

        public function UIEventManager()
        {
            this._dInstanceIndex = new Dictionary(true);
            if (_self != null)
            {
                throw new BeriliaError("UIEventManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function get instances() : Dictionary
        {
            return this._dInstanceIndex;
        }// end function

        public function registerInstance(event:InstanceEvent) : void
        {
            this._dInstanceIndex[event.instance] = event;
            return;
        }// end function

        public function isRegisteredInstance(param1:DisplayObject, param2 = null) : Boolean
        {
            return this._dInstanceIndex[param1] && this._dInstanceIndex[param1].events[getQualifiedClassName(param2)];
        }// end function

        public function removeInstance(param1) : void
        {
            delete this._dInstanceIndex[param1];
            return;
        }// end function

        public static function getInstance() : UIEventManager
        {
            if (_self == null)
            {
                _self = new UIEventManager;
            }
            return _self;
        }// end function

    }
}
