package com.ankamagames.dofus.network.messages.game.friend
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.friend.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IgnoredListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var ignoredList:Vector.<IgnoredInformations>;
        public static const protocolId:uint = 5674;

        public function IgnoredListMessage()
        {
            this.ignoredList = new Vector.<IgnoredInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5674;
        }// end function

        public function initIgnoredListMessage(param1:Vector.<IgnoredInformations> = null) : IgnoredListMessage
        {
            this.ignoredList = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.ignoredList = new Vector.<IgnoredInformations>;
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
            this.serializeAs_IgnoredListMessage(param1);
            return;
        }// end function

        public function serializeAs_IgnoredListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.ignoredList.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.ignoredList.length)
            {
                
                param1.writeShort((this.ignoredList[_loc_2] as IgnoredInformations).getTypeId());
                (this.ignoredList[_loc_2] as IgnoredInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IgnoredListMessage(param1);
            return;
        }// end function

        public function deserializeAs_IgnoredListMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:IgnoredInformations = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(IgnoredInformations, _loc_4);
                _loc_5.deserialize(param1);
                this.ignoredList.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
