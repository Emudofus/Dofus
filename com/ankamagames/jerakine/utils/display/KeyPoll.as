package com.ankamagames.jerakine.utils.display
{
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.events.KeyboardEvent;
    import flash.events.Event;

    public class KeyPoll 
    {

        private static var _self:KeyPoll;

        private var states:ByteArray;

        public function KeyPoll()
        {
            if (_self)
            {
                throw (new SingletonError());
            };
            this.states = new ByteArray();
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownListener, false, 0, true);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP, this.keyUpListener, false, 0, true);
            StageShareManager.stage.addEventListener(Event.ACTIVATE, this.activateListener, false, 0, true);
            StageShareManager.stage.addEventListener(Event.DEACTIVATE, this.deactivateListener, false, 0, true);
        }

        public static function getInstance():KeyPoll
        {
            if (!(_self))
            {
                _self = new (KeyPoll)();
            };
            return (_self);
        }


        private function keyDownListener(ev:KeyboardEvent):void
        {
            this.states[(ev.keyCode >>> 3)] = (this.states[(ev.keyCode >>> 3)] | (1 << (ev.keyCode & 7)));
        }

        private function keyUpListener(ev:KeyboardEvent):void
        {
            this.states[(ev.keyCode >>> 3)] = (this.states[(ev.keyCode >>> 3)] & ~((1 << (ev.keyCode & 7))));
        }

        private function activateListener(ev:Event):void
        {
            var i:int;
            while (i < 32)
            {
                this.states[i] = 0;
                i++;
            };
        }

        private function deactivateListener(ev:Event):void
        {
            var i:int;
            while (i < 32)
            {
                this.states[i] = 0;
                i++;
            };
        }

        public function isDown(keyCode:uint):Boolean
        {
            return (!(((this.states[(keyCode >>> 3)] & (1 << (keyCode & 7))) == 0)));
        }

        public function isUp(keyCode:uint):Boolean
        {
            return (((this.states[(keyCode >>> 3)] & (1 << (keyCode & 7))) == 0));
        }


    }
}//package com.ankamagames.jerakine.utils.display

