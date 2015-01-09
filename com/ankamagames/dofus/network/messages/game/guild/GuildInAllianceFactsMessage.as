package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
    import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildInAllianceFactsMessage extends GuildFactsMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6422;

        private var _isInitialized:Boolean = false;
        public var allianceInfos:BasicNamedAllianceInformations;

        public function GuildInAllianceFactsMessage()
        {
            this.allianceInfos = new BasicNamedAllianceInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6422);
        }

        public function initGuildInAllianceFactsMessage(infos:GuildFactSheetInformations=null, creationDate:uint=0, nbTaxCollectors:uint=0, enabled:Boolean=false, members:Vector.<CharacterMinimalInformations>=null, allianceInfos:BasicNamedAllianceInformations=null):GuildInAllianceFactsMessage
        {
            super.initGuildFactsMessage(infos, creationDate, nbTaxCollectors, enabled, members);
            this.allianceInfos = allianceInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.allianceInfos = new BasicNamedAllianceInformations();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildInAllianceFactsMessage(output);
        }

        public function serializeAs_GuildInAllianceFactsMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GuildFactsMessage(output);
            this.allianceInfos.serializeAs_BasicNamedAllianceInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInAllianceFactsMessage(input);
        }

        public function deserializeAs_GuildInAllianceFactsMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.allianceInfos = new BasicNamedAllianceInformations();
            this.allianceInfos.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

