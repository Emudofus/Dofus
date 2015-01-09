package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class LivingObjectMessageRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6066;

        private var _isInitialized:Boolean = false;
        public var msgId:uint = 0;
        public var parameters:Vector.<String>;
        public var livingObject:uint = 0;

        public function LivingObjectMessageRequestMessage()
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
            return (6066);
        }

        public function initLivingObjectMessageRequestMessage(msgId:uint=0, parameters:Vector.<String>=null, livingObject:uint=0):LivingObjectMessageRequestMessage
        {
            this.msgId = msgId;
            this.parameters = parameters;
            this.livingObject = livingObject;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.msgId = 0;
            this.parameters = new Vector.<String>();
            this.livingObject = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_LivingObjectMessageRequestMessage(output);
        }

        public function serializeAs_LivingObjectMessageRequestMessage(output:IDataOutput):void
        {
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element msgId.")));
            };
            output.writeShort(this.msgId);
            output.writeShort(this.parameters.length);
            var _i2:uint;
            while (_i2 < this.parameters.length)
            {
                output.writeUTF(this.parameters[_i2]);
                _i2++;
            };
            if ((((this.livingObject < 0)) || ((this.livingObject > 0xFFFFFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.livingObject) + ") on element livingObject.")));
            };
            output.writeUnsignedInt(this.livingObject);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_LivingObjectMessageRequestMessage(input);
        }

        public function deserializeAs_LivingObjectMessageRequestMessage(input:IDataInput):void
        {
            var _val2:String;
            this.msgId = input.readShort();
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element of LivingObjectMessageRequestMessage.msgId.")));
            };
            var _parametersLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _parametersLen)
            {
                _val2 = input.readUTF();
                this.parameters.push(_val2);
                _i2++;
            };
            this.livingObject = input.readUnsignedInt();
            if ((((this.livingObject < 0)) || ((this.livingObject > 0xFFFFFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.livingObject) + ") on element of LivingObjectMessageRequestMessage.livingObject.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

