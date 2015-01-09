package com.ankamagames.jerakine.handlers.messages
{
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.messages.DiscardableMessage;
    import com.ankamagames.jerakine.pools.Poolable;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import com.ankamagames.jerakine.utils.display.FrameIdManager;
    import flash.display.DisplayObject;

    public class HumanInputMessage implements Message, DiscardableMessage, Poolable 
    {

        protected var _target:InteractiveObject;
        protected var _nativeEvent:Event;
        protected var _frameId:uint;
        private var _canceled:Boolean;
        private var _actions:Array;
        public var bubbling:Boolean;


        public static function create(target:InteractiveObject, nativeEvent:Event, instance:HumanInputMessage=null):HumanInputMessage
        {
            if (!(instance))
            {
                instance = new (HumanInputMessage)();
            };
            instance._target = target;
            instance._nativeEvent = nativeEvent;
            instance._frameId = FrameIdManager.frameId;
            return (instance);
        }


        public function get target():DisplayObject
        {
            return (this._target);
        }

        public function get frameId():uint
        {
            return (this._frameId);
        }

        public function get canceled():Boolean
        {
            return (this._canceled);
        }

        public function set canceled(value:Boolean):void
        {
            if (this.bubbling)
            {
                throw (new InvalidCancelError("Can't cancel a bubbling message."));
            };
            if (((this._canceled) && (!(value))))
            {
                throw (new InvalidCancelError("Can't uncancel a canceled message."));
            };
            this._canceled = value;
        }

        public function get actions():Array
        {
            return (this._actions);
        }

        public function free():void
        {
            this._target = null;
            this._nativeEvent = null;
        }

        public function addAction(action:Action):void
        {
            if (this._actions == null)
            {
                this._actions = new Array();
            };
            this._actions.push(action);
        }


    }
}//package com.ankamagames.jerakine.handlers.messages

