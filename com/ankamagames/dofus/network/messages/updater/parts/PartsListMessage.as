package com.ankamagames.dofus.network.messages.updater.parts
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.updater.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var parts:Vector.<ContentPart>;
        public static const protocolId:uint = 1502;

        public function PartsListMessage()
        {
            this.parts = new Vector.<ContentPart>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1502;
        }// end function

        public function initPartsListMessage(param1:Vector.<ContentPart> = null) : PartsListMessage
        {
            this.parts = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.parts = new Vector.<ContentPart>;
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
            this.serializeAs_PartsListMessage(param1);
            return;
        }// end function

        public function serializeAs_PartsListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.parts.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.parts.length)
            {
                
                (this.parts[_loc_2] as ContentPart).serializeAs_ContentPart(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartsListMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ContentPart();
                _loc_4.deserialize(param1);
                this.parts.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
