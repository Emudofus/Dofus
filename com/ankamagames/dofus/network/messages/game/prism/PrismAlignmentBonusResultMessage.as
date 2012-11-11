package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.dofus.network.types.game.prism.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismAlignmentBonusResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var alignmentBonus:AlignmentBonusInformations;
        public static const protocolId:uint = 5842;

        public function PrismAlignmentBonusResultMessage()
        {
            this.alignmentBonus = new AlignmentBonusInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5842;
        }// end function

        public function initPrismAlignmentBonusResultMessage(param1:AlignmentBonusInformations = null) : PrismAlignmentBonusResultMessage
        {
            this.alignmentBonus = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.alignmentBonus = new AlignmentBonusInformations();
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PrismAlignmentBonusResultMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismAlignmentBonusResultMessage(param1:IDataOutput) : void
        {
            this.alignmentBonus.serializeAs_AlignmentBonusInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismAlignmentBonusResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismAlignmentBonusResultMessage(param1:IDataInput) : void
        {
            this.alignmentBonus = new AlignmentBonusInformations();
            this.alignmentBonus.deserialize(param1);
            return;
        }// end function

    }
}
