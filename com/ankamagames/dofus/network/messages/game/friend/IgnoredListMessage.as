package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class IgnoredListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5674;

        private var _isInitialized:Boolean = false;
        public var ignoredList:Vector.<IgnoredInformations>;

        public function IgnoredListMessage()
        {
            this.ignoredList = new Vector.<IgnoredInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5674);
        }

        public function initIgnoredListMessage(ignoredList:Vector.<IgnoredInformations>=null):IgnoredListMessage
        {
            this.ignoredList = ignoredList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ignoredList = new Vector.<IgnoredInformations>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_IgnoredListMessage(output);
        }

        public function serializeAs_IgnoredListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.ignoredList.length);
            var _i1:uint;
            while (_i1 < this.ignoredList.length)
            {
                output.writeShort((this.ignoredList[_i1] as IgnoredInformations).getTypeId());
                (this.ignoredList[_i1] as IgnoredInformations).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredListMessage(input);
        }

        public function deserializeAs_IgnoredListMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:IgnoredInformations;
            var _ignoredListLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _ignoredListLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(IgnoredInformations, _id1);
                _item1.deserialize(input);
                this.ignoredList.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

