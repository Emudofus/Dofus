package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;

    [Trusted]
    public class IdentificationSuccessMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 22;

        private var _isInitialized:Boolean = false;
        [Transient]
        public var login:String = "";
        public var nickname:String = "";
        public var accountId:uint = 0;
        public var communityId:uint = 0;
        public var hasRights:Boolean = false;
        public var secretQuestion:String = "";
        public var accountCreation:Number = 0;
        public var subscriptionElapsedDuration:Number = 0;
        public var subscriptionEndDate:Number = 0;
        public var wasAlreadyConnected:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (22);
        }

        public function initIdentificationSuccessMessage(login:String="", nickname:String="", accountId:uint=0, communityId:uint=0, hasRights:Boolean=false, secretQuestion:String="", accountCreation:Number=0, subscriptionElapsedDuration:Number=0, subscriptionEndDate:Number=0, wasAlreadyConnected:Boolean=false):IdentificationSuccessMessage
        {
            this.login = login;
            this.nickname = nickname;
            this.accountId = accountId;
            this.communityId = communityId;
            this.hasRights = hasRights;
            this.secretQuestion = secretQuestion;
            this.accountCreation = accountCreation;
            this.subscriptionElapsedDuration = subscriptionElapsedDuration;
            this.subscriptionEndDate = subscriptionEndDate;
            this.wasAlreadyConnected = wasAlreadyConnected;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.login = "";
            this.nickname = "";
            this.accountId = 0;
            this.communityId = 0;
            this.hasRights = false;
            this.secretQuestion = "";
            this.accountCreation = 0;
            this.subscriptionElapsedDuration = 0;
            this.subscriptionEndDate = 0;
            this.wasAlreadyConnected = false;
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
            this.serializeAs_IdentificationSuccessMessage(output);
        }

        public function serializeAs_IdentificationSuccessMessage(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.hasRights);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.wasAlreadyConnected);
            output.writeByte(_box0);
            output.writeUTF(this.login);
            output.writeUTF(this.nickname);
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element accountId.")));
            };
            output.writeInt(this.accountId);
            if (this.communityId < 0)
            {
                throw (new Error((("Forbidden value (" + this.communityId) + ") on element communityId.")));
            };
            output.writeByte(this.communityId);
            output.writeUTF(this.secretQuestion);
            if ((((this.accountCreation < 0)) || ((this.accountCreation > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.accountCreation) + ") on element accountCreation.")));
            };
            output.writeDouble(this.accountCreation);
            if ((((this.subscriptionElapsedDuration < 0)) || ((this.subscriptionElapsedDuration > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.subscriptionElapsedDuration) + ") on element subscriptionElapsedDuration.")));
            };
            output.writeDouble(this.subscriptionElapsedDuration);
            if ((((this.subscriptionEndDate < 0)) || ((this.subscriptionEndDate > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.subscriptionEndDate) + ") on element subscriptionEndDate.")));
            };
            output.writeDouble(this.subscriptionEndDate);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IdentificationSuccessMessage(input);
        }

        public function deserializeAs_IdentificationSuccessMessage(input:ICustomDataInput):void
        {
            var _box0:uint = input.readByte();
            this.hasRights = BooleanByteWrapper.getFlag(_box0, 0);
            this.wasAlreadyConnected = BooleanByteWrapper.getFlag(_box0, 1);
            this.login = input.readUTF();
            this.nickname = input.readUTF();
            this.accountId = input.readInt();
            if (this.accountId < 0)
            {
                throw (new Error((("Forbidden value (" + this.accountId) + ") on element of IdentificationSuccessMessage.accountId.")));
            };
            this.communityId = input.readByte();
            if (this.communityId < 0)
            {
                throw (new Error((("Forbidden value (" + this.communityId) + ") on element of IdentificationSuccessMessage.communityId.")));
            };
            this.secretQuestion = input.readUTF();
            this.accountCreation = input.readDouble();
            if ((((this.accountCreation < 0)) || ((this.accountCreation > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.accountCreation) + ") on element of IdentificationSuccessMessage.accountCreation.")));
            };
            this.subscriptionElapsedDuration = input.readDouble();
            if ((((this.subscriptionElapsedDuration < 0)) || ((this.subscriptionElapsedDuration > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.subscriptionElapsedDuration) + ") on element of IdentificationSuccessMessage.subscriptionElapsedDuration.")));
            };
            this.subscriptionEndDate = input.readDouble();
            if ((((this.subscriptionEndDate < 0)) || ((this.subscriptionEndDate > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.subscriptionEndDate) + ") on element of IdentificationSuccessMessage.subscriptionEndDate.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

