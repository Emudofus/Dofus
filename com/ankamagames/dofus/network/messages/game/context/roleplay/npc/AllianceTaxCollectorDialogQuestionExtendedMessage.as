﻿package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceTaxCollectorDialogQuestionExtendedMessage extends TaxCollectorDialogQuestionExtendedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6445;

        private var _isInitialized:Boolean = false;
        public var alliance:BasicNamedAllianceInformations;

        public function AllianceTaxCollectorDialogQuestionExtendedMessage()
        {
            this.alliance = new BasicNamedAllianceInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6445);
        }

        public function initAllianceTaxCollectorDialogQuestionExtendedMessage(guildInfo:BasicGuildInformations=null, maxPods:uint=0, prospecting:uint=0, wisdom:uint=0, taxCollectorsCount:uint=0, taxCollectorAttack:int=0, kamas:uint=0, experience:Number=0, pods:uint=0, itemsValue:uint=0, alliance:BasicNamedAllianceInformations=null):AllianceTaxCollectorDialogQuestionExtendedMessage
        {
            super.initTaxCollectorDialogQuestionExtendedMessage(guildInfo, maxPods, prospecting, wisdom, taxCollectorsCount, taxCollectorAttack, kamas, experience, pods, itemsValue);
            this.alliance = alliance;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.alliance = new BasicNamedAllianceInformations();
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
            this.serializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(output);
        }

        public function serializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_TaxCollectorDialogQuestionExtendedMessage(output);
            this.alliance.serializeAs_BasicNamedAllianceInformations(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(input);
        }

        public function deserializeAs_AllianceTaxCollectorDialogQuestionExtendedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.alliance = new BasicNamedAllianceInformations();
            this.alliance.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.npc

