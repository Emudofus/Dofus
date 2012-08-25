package com.ankamagames.dofus.network.messages.game.approach
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AuthenticationTicketWithClientPacksMessage extends AuthenticationTicketMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var packs:Vector.<uint>;
        public static const protocolId:uint = 6190;

        public function AuthenticationTicketWithClientPacksMessage()
        {
            this.packs = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6190;
        }// end function

        public function initAuthenticationTicketWithClientPacksMessage(param1:String = "", param2:String = "", param3:Vector.<uint> = null) : AuthenticationTicketWithClientPacksMessage
        {
            super.initAuthenticationTicketMessage(param1, param2);
            this.packs = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.packs = new Vector.<uint>;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AuthenticationTicketWithClientPacksMessage(param1);
            return;
        }// end function

        public function serializeAs_AuthenticationTicketWithClientPacksMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AuthenticationTicketMessage(param1);
            param1.writeShort(this.packs.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.packs.length)
            {
                
                if (this.packs[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.packs[_loc_2] + ") on element 1 (starting at 1) of packs.");
                }
                param1.writeInt(this.packs[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AuthenticationTicketWithClientPacksMessage(param1);
            return;
        }// end function

        public function deserializeAs_AuthenticationTicketWithClientPacksMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of packs.");
                }
                this.packs.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
