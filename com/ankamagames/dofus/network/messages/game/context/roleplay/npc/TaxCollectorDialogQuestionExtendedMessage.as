package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorDialogQuestionExtendedMessage extends TaxCollectorDialogQuestionBasicMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var maxPods:uint = 0;
        public var prospecting:uint = 0;
        public var wisdom:uint = 0;
        public var taxCollectorsCount:uint = 0;
        public var taxCollectorAttack:int = 0;
        public var kamas:uint = 0;
        public var experience:Number = 0;
        public var pods:uint = 0;
        public var itemsValue:uint = 0;
        public static const protocolId:uint = 5615;

        public function TaxCollectorDialogQuestionExtendedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5615;
        }// end function

        public function initTaxCollectorDialogQuestionExtendedMessage(param1:BasicGuildInformations = null, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:int = 0, param7:uint = 0, param8:Number = 0, param9:uint = 0, param10:uint = 0) : TaxCollectorDialogQuestionExtendedMessage
        {
            super.initTaxCollectorDialogQuestionBasicMessage(param1);
            this.maxPods = param2;
            this.prospecting = param3;
            this.wisdom = param4;
            this.taxCollectorsCount = param5;
            this.taxCollectorAttack = param6;
            this.kamas = param7;
            this.experience = param8;
            this.pods = param9;
            this.itemsValue = param10;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.maxPods = 0;
            this.prospecting = 0;
            this.wisdom = 0;
            this.taxCollectorsCount = 0;
            this.taxCollectorAttack = 0;
            this.kamas = 0;
            this.experience = 0;
            this.pods = 0;
            this.itemsValue = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TaxCollectorDialogQuestionExtendedMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorDialogQuestionExtendedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_TaxCollectorDialogQuestionBasicMessage(param1);
            if (this.maxPods < 0)
            {
                throw new Error("Forbidden value (" + this.maxPods + ") on element maxPods.");
            }
            param1.writeShort(this.maxPods);
            if (this.prospecting < 0)
            {
                throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
            }
            param1.writeShort(this.prospecting);
            if (this.wisdom < 0)
            {
                throw new Error("Forbidden value (" + this.wisdom + ") on element wisdom.");
            }
            param1.writeShort(this.wisdom);
            if (this.taxCollectorsCount < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element taxCollectorsCount.");
            }
            param1.writeByte(this.taxCollectorsCount);
            param1.writeInt(this.taxCollectorAttack);
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
            }
            param1.writeInt(this.kamas);
            if (this.experience < 0)
            {
                throw new Error("Forbidden value (" + this.experience + ") on element experience.");
            }
            param1.writeDouble(this.experience);
            if (this.pods < 0)
            {
                throw new Error("Forbidden value (" + this.pods + ") on element pods.");
            }
            param1.writeInt(this.pods);
            if (this.itemsValue < 0)
            {
                throw new Error("Forbidden value (" + this.itemsValue + ") on element itemsValue.");
            }
            param1.writeInt(this.itemsValue);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorDialogQuestionExtendedMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorDialogQuestionExtendedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.maxPods = param1.readShort();
            if (this.maxPods < 0)
            {
                throw new Error("Forbidden value (" + this.maxPods + ") on element of TaxCollectorDialogQuestionExtendedMessage.maxPods.");
            }
            this.prospecting = param1.readShort();
            if (this.prospecting < 0)
            {
                throw new Error("Forbidden value (" + this.prospecting + ") on element of TaxCollectorDialogQuestionExtendedMessage.prospecting.");
            }
            this.wisdom = param1.readShort();
            if (this.wisdom < 0)
            {
                throw new Error("Forbidden value (" + this.wisdom + ") on element of TaxCollectorDialogQuestionExtendedMessage.wisdom.");
            }
            this.taxCollectorsCount = param1.readByte();
            if (this.taxCollectorsCount < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element of TaxCollectorDialogQuestionExtendedMessage.taxCollectorsCount.");
            }
            this.taxCollectorAttack = param1.readInt();
            this.kamas = param1.readInt();
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element of TaxCollectorDialogQuestionExtendedMessage.kamas.");
            }
            this.experience = param1.readDouble();
            if (this.experience < 0)
            {
                throw new Error("Forbidden value (" + this.experience + ") on element of TaxCollectorDialogQuestionExtendedMessage.experience.");
            }
            this.pods = param1.readInt();
            if (this.pods < 0)
            {
                throw new Error("Forbidden value (" + this.pods + ") on element of TaxCollectorDialogQuestionExtendedMessage.pods.");
            }
            this.itemsValue = param1.readInt();
            if (this.itemsValue < 0)
            {
                throw new Error("Forbidden value (" + this.itemsValue + ") on element of TaxCollectorDialogQuestionExtendedMessage.itemsValue.");
            }
            return;
        }// end function

    }
}
