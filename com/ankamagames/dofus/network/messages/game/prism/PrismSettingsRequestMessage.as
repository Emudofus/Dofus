package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PrismSettingsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6437;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var startDefenseTime:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6437);
        }

        public function initPrismSettingsRequestMessage(subAreaId:uint=0, startDefenseTime:uint=0):PrismSettingsRequestMessage
        {
            this.subAreaId = subAreaId;
            this.startDefenseTime = startDefenseTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subAreaId = 0;
            this.startDefenseTime = 0;
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
            this.serializeAs_PrismSettingsRequestMessage(output);
        }

        public function serializeAs_PrismSettingsRequestMessage(output:ICustomDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
            if (this.startDefenseTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.startDefenseTime) + ") on element startDefenseTime.")));
            };
            output.writeByte(this.startDefenseTime);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PrismSettingsRequestMessage(input);
        }

        public function deserializeAs_PrismSettingsRequestMessage(input:ICustomDataInput):void
        {
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismSettingsRequestMessage.subAreaId.")));
            };
            this.startDefenseTime = input.readByte();
            if (this.startDefenseTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.startDefenseTime) + ") on element of PrismSettingsRequestMessage.startDefenseTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

