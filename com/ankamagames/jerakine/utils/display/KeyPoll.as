package com.ankamagames.jerakine.utils.display
{
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class KeyPoll extends Object
    {
        private var states:ByteArray;
        private static var _self:KeyPoll;

        public function KeyPoll()
        {
            if (_self)
            {
                throw new SingletonError();
            }
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
            return;
        }// end function

        private function keyDownListener(event:KeyboardEvent) : void
        {
            this.states[event.keyCode >>> 3] = this.states[event.keyCode >>> 3] | 1 << (event.keyCode & 7);
            return;
        }// end function

        private function keyUpListener(event:KeyboardEvent) : void
        {
            this.states[event.keyCode >>> 3] = this.states[event.keyCode >>> 3] & ~(1 << (event.keyCode & 7));
            return;
        }// end function

        private function activateListener(event:Event) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < 32)
            {
                
                this.states[_loc_2] = 0;
                _loc_2++;
            }
            return;
        }// end function

        private function deactivateListener(event:Event) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < 32)
            {
                
                this.states[_loc_2] = 0;
                _loc_2++;
            }
            return;
        }// end function

        public function isDown(param1:uint) : Boolean
        {
            return (this.states[param1 >>> 3] & 1 << (param1 & 7)) != 0;
        }// end function

        public function isUp(param1:uint) : Boolean
        {
            return (this.states[param1 >>> 3] & 1 << (param1 & 7)) == 0;
        }// end function

        public static function getInstance() : KeyPoll
        {
            if (!_self)
            {
                _self = new KeyPoll;
            }
            return _self;
        }// end function

    }
}
