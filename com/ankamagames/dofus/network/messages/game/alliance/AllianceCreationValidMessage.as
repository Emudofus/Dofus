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
    public class AllianceCreationValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6393;

        private var _isInitialized:Boolean = false;
        public var allianceName:String = "";
        public var allianceTag:String = "";
        public var allianceEmblem:GuildEmblem;

        public function AllianceCreationValidMessage()
        {
            this.allianceEmblem = new GuildEmblem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6393);
        }

        public function initAllianceCreationValidMessage(allianceName:String="", allianceTag:String="", allianceEmblem:GuildEmblem=null):AllianceCreationValidMessage
        {
            this.allianceName = allianceName;
            this.allianceTag = allianceTag;
            this.allianceEmblem = allianceEmblem;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.allianceName = "";
            this.allianceTag = "";
            this.allianceEmblem = new GuildEmblem();
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
            this.serializeAs_AllianceCreationValidMessage(output);
        }

        public function serializeAs_AllianceCreationValidMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.allianceName);
            output.writeUTF(this.allianceTag);
            this.allianceEmblem.serializeAs_GuildEmblem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceCreationValidMessage(input);
        }

        public function deserializeAs_AllianceCreationValidMessage(input:ICustomDataInput):void
        {
            this.allianceName = input.readUTF();
            this.allianceTag = input.readUTF();
            this.allianceEmblem = new GuildEmblem();
            this.allianceEmblem.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

