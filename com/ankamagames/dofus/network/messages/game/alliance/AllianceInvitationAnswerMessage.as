package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceInvitationAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6401;

        private var _isInitialized:Boolean = false;
        public var accept:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6401);
        }

        public function initAllianceInvitationAnswerMessage(accept:Boolean=false):AllianceInvitationAnswerMessage
        {
            this.accept = accept;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.accept = false;
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
            this.serializeAs_AllianceInvitationAnswerMessage(output);
        }

        public function serializeAs_AllianceInvitationAnswerMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.accept);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceInvitationAnswerMessage(input);
        }

        public function deserializeAs_AllianceInvitationAnswerMessage(input:ICustomDataInput):void
        {
            this.accept = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

