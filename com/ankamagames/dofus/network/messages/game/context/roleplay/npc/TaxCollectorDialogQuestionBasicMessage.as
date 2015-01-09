package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TaxCollectorDialogQuestionBasicMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5619;

        private var _isInitialized:Boolean = false;
        public var guildInfo:BasicGuildInformations;

        public function TaxCollectorDialogQuestionBasicMessage()
        {
            this.guildInfo = new BasicGuildInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5619);
        }

        public function initTaxCollectorDialogQuestionBasicMessage(guildInfo:BasicGuildInformations=null):TaxCollectorDialogQuestionBasicMessage
        {
            this.guildInfo = guildInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildInfo = new BasicGuildInformations();
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
            this.serializeAs_TaxCollectorDialogQuestionBasicMessage(output);
        }

        public function serializeAs_TaxCollectorDialogQuestionBasicMessage(output:ICustomDataOutput):void
        {
            this.guildInfo.serializeAs_BasicGuildInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorDialogQuestionBasicMessage(input);
        }

        public function deserializeAs_TaxCollectorDialogQuestionBasicMessage(input:ICustomDataInput):void
        {
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.npc

