package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceModificationEmblemValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6447;

        private var _isInitialized:Boolean = false;
        public var Alliancemblem:GuildEmblem;

        public function AllianceModificationEmblemValidMessage()
        {
            this.Alliancemblem = new GuildEmblem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6447);
        }

        public function initAllianceModificationEmblemValidMessage(Alliancemblem:GuildEmblem=null):AllianceModificationEmblemValidMessage
        {
            this.Alliancemblem = Alliancemblem;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.Alliancemblem = new GuildEmblem();
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
            this.serializeAs_AllianceModificationEmblemValidMessage(output);
        }

        public function serializeAs_AllianceModificationEmblemValidMessage(output:ICustomDataOutput):void
        {
            this.Alliancemblem.serializeAs_GuildEmblem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceModificationEmblemValidMessage(input);
        }

        public function deserializeAs_AllianceModificationEmblemValidMessage(input:ICustomDataInput):void
        {
            this.Alliancemblem = new GuildEmblem();
            this.Alliancemblem.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

