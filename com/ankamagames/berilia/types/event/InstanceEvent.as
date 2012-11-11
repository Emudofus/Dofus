package com.ankamagames.berilia.types.event
{
    import flash.display.*;
    import flash.utils.*;

    public class InstanceEvent extends Object
    {
        private var _doInstance:DisplayObject;
        private var _aEvent:Array;
        private var _oCallback:Object;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function InstanceEvent(param1:DisplayObject, param2:Object)
        {
            this._doInstance = param1;
            this._aEvent = new Array();
            this._oCallback = param2;
            if (param1 is InteractiveObject)
            {
                InteractiveObject(param1).mouseEnabled = true;
            }
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get instance() : DisplayObject
        {
            return this._doInstance;
        }// end function

        public function get events() : Array
        {
            return this._aEvent;
        }// end function

        public function get callbackObject() : Object
        {
            return this._oCallback;
        }// end function

        public function set callbackObject(param1:Object) : void
        {
            this._oCallback = param1;
            return;
        }// end function

        public function get haveEvent() : Boolean
        {
            return this._aEvent.length != 0;
        }// end function

        public function push(param1:String) : void
        {
            this._aEvent[param1] = true;
            return;
        }// end function

    }
}
