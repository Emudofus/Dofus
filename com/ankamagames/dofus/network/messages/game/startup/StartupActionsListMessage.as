package com.ankamagames.dofus.network.messages.game.startup
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.startup.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StartupActionsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var actions:Vector.<StartupActionAddObject>;
        public static const protocolId:uint = 1301;

        public function StartupActionsListMessage()
        {
            this.actions = new Vector.<StartupActionAddObject>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1301;
        }// end function

        public function initStartupActionsListMessage(param1:Vector.<StartupActionAddObject> = null) : StartupActionsListMessage
        {
            this.actions = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.actions = new Vector.<StartupActionAddObject>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_StartupActionsListMessage(param1);
            return;
        }// end function

        public function serializeAs_StartupActionsListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.actions.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.actions.length)
            {
                
                (this.actions[_loc_2] as StartupActionAddObject).serializeAs_StartupActionAddObject(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StartupActionsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_StartupActionsListMessage(param1:IDataInput) : void
        {
            var _loc_4:StartupActionAddObject = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new StartupActionAddObject();
                _loc_4.deserialize(param1);
                this.actions.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
