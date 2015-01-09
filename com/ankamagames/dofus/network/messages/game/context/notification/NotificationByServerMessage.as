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
    public class NotificationByServerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6103;

        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var parameters:Vector.<String>;
        public var forceOpen:Boolean = false;

        public function NotificationByServerMessage()
        {
            this.parameters = new Vector.<String>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6103);
        }

        public function initNotificationByServerMessage(id:uint=0, parameters:Vector.<String>=null, forceOpen:Boolean=false):NotificationByServerMessage
        {
            this.id = id;
            this.parameters = parameters;
            this.forceOpen = forceOpen;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = 0;
            this.parameters = new Vector.<String>();
            this.forceOpen = false;
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
            this.serializeAs_NotificationByServerMessage(output);
        }

        public function serializeAs_NotificationByServerMessage(output:ICustomDataOutput):void
        {
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeVarShort(this.id);
            output.writeShort(this.parameters.length);
            var _i2:uint;
            while (_i2 < this.parameters.length)
            {
                output.writeUTF(this.parameters[_i2]);
                _i2++;
            };
            output.writeBoolean(this.forceOpen);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NotificationByServerMessage(input);
        }

        public function deserializeAs_NotificationByServerMessage(input:ICustomDataInput):void
        {
            var _val2:String;
            this.id = input.readVarUhShort();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of NotificationByServerMessage.id.")));
            };
            var _parametersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _parametersLen)
            {
                _val2 = input.readUTF();
                this.parameters.push(_val2);
                _i2++;
            };
            this.forceOpen = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.notification

