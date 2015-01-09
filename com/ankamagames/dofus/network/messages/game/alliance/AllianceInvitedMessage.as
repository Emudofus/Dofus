package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceInvitedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6397;

        private var _isInitialized:Boolean = false;
        public var recruterId:uint = 0;
        public var recruterName:String = "";
        public var allianceInfo:BasicNamedAllianceInformations;

        public function AllianceInvitedMessage()
        {
            this.allianceInfo = new BasicNamedAllianceInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6397);
        }

        public function initAllianceInvitedMessage(recruterId:uint=0, recruterName:String="", allianceInfo:BasicNamedAllianceInformations=null):AllianceInvitedMessage
        {
            this.recruterId = recruterId;
            this.recruterName = recruterName;
            this.allianceInfo = allianceInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.recruterId = 0;
            this.recruterName = "";
            this.allianceInfo = new BasicNamedAllianceInformations();
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
            this.serializeAs_AllianceInvitedMessage(output);
        }

        public function serializeAs_AllianceInvitedMessage(output:ICustomDataOutput):void
        {
            if (this.recruterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.recruterId) + ") on element recruterId.")));
            };
            output.writeVarInt(this.recruterId);
            output.writeUTF(this.recruterName);
            this.allianceInfo.serializeAs_BasicNamedAllianceInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceInvitedMessage(input);
        }

        public function deserializeAs_AllianceInvitedMessage(input:ICustomDataInput):void
        {
            this.recruterId = input.readVarUhInt();
            if (this.recruterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.recruterId) + ") on element of AllianceInvitedMessage.recruterId.")));
            };
            this.recruterName = input.readUTF();
            this.allianceInfo = new BasicNamedAllianceInformations();
            this.allianceInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

