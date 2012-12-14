package com.ankamagames.dofus.network.messages.game.context.display
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class DisplayNumericalValueWithAgeBonusMessage extends DisplayNumericalValueMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var valueOfBonus:int = 0;
        public static const protocolId:uint = 6361;

        public function DisplayNumericalValueWithAgeBonusMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6361;
        }// end function

        public function initDisplayNumericalValueWithAgeBonusMessage(param1:int = 0, param2:int = 0, param3:uint = 0, param4:int = 0) : DisplayNumericalValueWithAgeBonusMessage
        {
            super.initDisplayNumericalValueMessage(param1, param2, param3);
            this.valueOfBonus = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.valueOfBonus = 0;
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
            this.serializeAs_DisplayNumericalValueWithAgeBonusMessage(param1);
            return;
        }// end function

        public function serializeAs_DisplayNumericalValueWithAgeBonusMessage(param1:IDataOutput) : void
        {
            super.serializeAs_DisplayNumericalValueMessage(param1);
            param1.writeInt(this.valueOfBonus);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_DisplayNumericalValueWithAgeBonusMessage(param1);
            return;
        }// end function

        public function deserializeAs_DisplayNumericalValueWithAgeBonusMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.valueOfBonus = param1.readInt();
            return;
        }// end function

    }
}
