package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildInvitationStateRecruterMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5563;

        private var _isInitialized:Boolean = false;
        public var recrutedName:String = "";
        public var invitationState:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5563);
        }

        public function initGuildInvitationStateRecruterMessage(recrutedName:String="", invitationState:uint=0):GuildInvitationStateRecruterMessage
        {
            this.recrutedName = recrutedName;
            this.invitationState = invitationState;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.recrutedName = "";
            this.invitationState = 0;
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
            this.serializeAs_GuildInvitationStateRecruterMessage(output);
        }

        public function serializeAs_GuildInvitationStateRecruterMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.recrutedName);
            output.writeByte(this.invitationState);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInvitationStateRecruterMessage(input);
        }

        public function deserializeAs_GuildInvitationStateRecruterMessage(input:ICustomDataInput):void
        {
            this.recrutedName = input.readUTF();
            this.invitationState = input.readByte();
            if (this.invitationState < 0)
            {
                throw (new Error((("Forbidden value (" + this.invitationState) + ") on element of GuildInvitationStateRecruterMessage.invitationState.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

