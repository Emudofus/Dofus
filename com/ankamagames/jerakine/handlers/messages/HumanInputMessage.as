package com.ankamagames.jerakine.handlers.messages
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;

    public class HumanInputMessage extends Object implements Message, DiscardableMessage, Poolable
    {
        protected var _target:InteractiveObject;
        protected var _nativeEvent:Event;
        protected var _frameId:uint;
        private var _canceled:Boolean;
        private var _actions:Array;
        public var bubbling:Boolean;

        public function HumanInputMessage()
        {
            return;
        }// end function

        public function get target() : DisplayObject
        {
            return this._target;
        }// end function

        public function get frameId() : uint
        {
            return this._frameId;
        }// end function

        public function get canceled() : Boolean
        {
            return this._canceled;
        }// end function

        public function set canceled(param1:Boolean) : void
        {
            if (this.bubbling)
            {
                throw new InvalidCancelError("Can\'t cancel a bubbling message.");
            }
            if (this._canceled && !param1)
            {
                throw new InvalidCancelError("Can\'t uncancel a canceled message.");
            }
            this._canceled = param1;
            return;
        }// end function

        public function get actions() : Array
        {
            return this._actions;
        }// end function

        public function free() : void
        {
            this._target = null;
            this._nativeEvent = null;
            return;
        }// end function

        public function addAction(param1:Action) : void
        {
            if (this._actions == null)
            {
                this._actions = new Array();
            }
            this._actions.push(param1);
            return;
        }// end function

        public static function create(param1:InteractiveObject, param2:Event, param3:HumanInputMessage = null) : HumanInputMessage
        {
            if (!param3)
            {
                param3 = new HumanInputMessage;
            }
            param3._target = param1;
            param3._nativeEvent = param2;
            param3._frameId = FrameIdManager.frameId;
            return param3;
        }// end function

    }
}
