package com.ankamagames.dofus.network.messages.game.context.notification
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class NotificationListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6087;

        private var _isInitialized:Boolean = false;
        public var flags:Vector.<int>;

        public function NotificationListMessage()
        {
            this.flags = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6087);
        }

        public function initNotificationListMessage(flags:Vector.<int>=null):NotificationListMessage
        {
            this.flags = flags;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.flags = new Vector.<int>();
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
            this.serializeAs_NotificationListMessage(output);
        }

        public function serializeAs_NotificationListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.flags.length);
            var _i1:uint;
            while (_i1 < this.flags.length)
            {
                output.writeVarInt(this.flags[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NotificationListMessage(input);
        }

        public function deserializeAs_NotificationListMessage(input:ICustomDataInput):void
        {
            var _val1:int;
            var _flagsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _flagsLen)
            {
                _val1 = input.readVarInt();
                this.flags.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.notification

