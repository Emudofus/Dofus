package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceInvitationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6395;

        private var _isInitialized:Boolean = false;
        public var targetId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6395);
        }

        public function initAllianceInvitationMessage(targetId:uint=0):AllianceInvitationMessage
        {
            this.targetId = targetId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.targetId = 0;
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
            this.serializeAs_AllianceInvitationMessage(output);
        }

        public function serializeAs_AllianceInvitationMessage(output:ICustomDataOutput):void
        {
            if (this.targetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.targetId) + ") on element targetId.")));
            };
            output.writeVarInt(this.targetId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceInvitationMessage(input);
        }

        public function deserializeAs_AllianceInvitationMessage(input:ICustomDataInput):void
        {
            this.targetId = input.readVarUhInt();
            if (this.targetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.targetId) + ") on element of AllianceInvitationMessage.targetId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

