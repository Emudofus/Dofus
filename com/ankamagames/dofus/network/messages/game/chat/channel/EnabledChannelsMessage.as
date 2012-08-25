package com.ankamagames.dofus.network.messages.game.chat.channel
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EnabledChannelsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var channels:Vector.<uint>;
        public var disallowed:Vector.<uint>;
        public static const protocolId:uint = 892;

        public function EnabledChannelsMessage()
        {
            this.channels = new Vector.<uint>;
            this.disallowed = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 892;
        }// end function

        public function initEnabledChannelsMessage(param1:Vector.<uint> = null, param2:Vector.<uint> = null) : EnabledChannelsMessage
        {
            this.channels = param1;
            this.disallowed = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.channels = new Vector.<uint>;
            this.disallowed = new Vector.<uint>;
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
            this.serializeAs_EnabledChannelsMessage(param1);
            return;
        }// end function

        public function serializeAs_EnabledChannelsMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.channels.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.channels.length)
            {
                
                param1.writeByte(this.channels[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.disallowed.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.disallowed.length)
            {
                
                param1.writeByte(this.disallowed[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EnabledChannelsMessage(param1);
            return;
        }// end function

        public function deserializeAs_EnabledChannelsMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readByte();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of channels.");
                }
                this.channels.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readByte();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of disallowed.");
                }
                this.disallowed.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
