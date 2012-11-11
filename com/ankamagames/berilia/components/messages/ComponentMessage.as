package com.ankamagames.berilia.components.messages
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;
    import flash.utils.*;

    public class ComponentMessage extends Object implements Message
    {
        protected var _target:InteractiveObject;
        private var _canceled:Boolean;
        private var _actions:Array;
        public var bubbling:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ComponentMessage));

        public function ComponentMessage(param1:InteractiveObject)
        {
            this._target = param1;
            return;
        }// end function

        public function get target() : DisplayObject
        {
            return this._target;
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

        public function addAction(param1:Action) : void
        {
            if (this._actions == null)
            {
                this._actions = new Array();
            }
            this._actions.push(param1);
            return;
        }// end function

    }
}
