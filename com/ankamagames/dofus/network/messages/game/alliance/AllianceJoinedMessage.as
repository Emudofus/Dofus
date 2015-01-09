package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceJoinedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6402;

        private var _isInitialized:Boolean = false;
        public var allianceInfo:AllianceInformations;
        public var enabled:Boolean = false;

        public function AllianceJoinedMessage()
        {
            this.allianceInfo = new AllianceInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6402);
        }

        public function initAllianceJoinedMessage(allianceInfo:AllianceInformations=null, enabled:Boolean=false):AllianceJoinedMessage
        {
            this.allianceInfo = allianceInfo;
            this.enabled = enabled;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.allianceInfo = new AllianceInformations();
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
            this.serializeAs_AllianceJoinedMessage(output);
        }

        public function serializeAs_AllianceJoinedMessage(output:ICustomDataOutput):void
        {
            this.allianceInfo.serializeAs_AllianceInformations(output);
            output.writeBoolean(this.enabled);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceJoinedMessage(input);
        }

        public function deserializeAs_AllianceJoinedMessage(input:ICustomDataInput):void
        {
            this.allianceInfo = new AllianceInformations();
            this.allianceInfo.deserialize(input);
            this.enabled = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

