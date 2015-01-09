package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AccountCapabilitiesMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6216;

        private var _isInitialized:Boolean = false;
        public var accountId:uint = 0;
        public var tutorialAvailable:Boolean = false;
        public var breedsVisible:uint = 0;
        public var breedsAvailable:uint = 0;
        public var status:int = -1;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6216);
        }

        public function initAccountCapabilitiesMessage(accountId:uint=0, tutorialAvailable:Boolean=false, breedsVisible:uint=0, breedsAvailable:uint=0, status:int=-1):AccountCapabilitiesMessage
        {
            this.accountId = accountId;
            this.tutorialAvailable = tutorialAvailable;
            this.breedsVisible = breedsVisible;
            this.breedsAvailable = breedsAvailable;
            this.status = status;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accountId = 0;
            this.tutorialAvailable = false;
            this.breedsVisible = 0;
            this.breedsAvailable = 0;
            this.status = -1;
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
            this.serializeAs_AccountCapabilitiesMessage(output);
        }

        public function serializeAs_AccountCapabilitiesMessage(output:ICustomDataOutput):void
        {
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            output.writeBoolean(this.tutorialAvailable);
            if ((((this.breedsVisible < 0)) || ((this.breedsVisible > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.breedsVisible) + ") on element breedsVisible.")));
            };
            output.writeShort(this.breedsVisible);
            if ((((this.breedsAvailable < 0)) || ((this.breedsAvailable > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.breedsAvailable) + ") on element breedsAvailable.")));
            };
            output.writeShort(this.breedsAvailable);
            output.writeByte(this.status);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AccountCapabilitiesMessage(input);
        }

        public function deserializeAs_AccountCapabilitiesMessage(input:ICustomDataInput):void
        {
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of AccountCapabilitiesMessage.accountId.")));
            };
            this.tutorialAvailable = input.readBoolean();
            this.breedsVisible = input.readUnsignedShort();
            if ((((this.breedsVisible < 0)) || ((this.breedsVisible > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.breedsVisible) + ") on element of AccountCapabilitiesMessage.breedsVisible.")));
            };
            this.breedsAvailable = input.readUnsignedShort();
            if ((((this.breedsAvailable < 0)) || ((this.breedsAvailable > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.breedsAvailable) + ") on element of AccountCapabilitiesMessage.breedsAvailable.")));
            };
            this.status = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.approach

