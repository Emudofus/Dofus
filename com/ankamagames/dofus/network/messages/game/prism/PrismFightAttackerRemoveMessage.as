package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismFightAttackerRemoveMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var fighterToRemoveId:uint = 0;
        public static const protocolId:uint = 5897;

        public function PrismFightAttackerRemoveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5897;
        }// end function

        public function initPrismFightAttackerRemoveMessage(param1:Number = 0, param2:uint = 0) : PrismFightAttackerRemoveMessage
        {
            this.fightId = param1;
            this.fighterToRemoveId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.fighterToRemoveId = 0;
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
            this.serializeAs_PrismFightAttackerRemoveMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismFightAttackerRemoveMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.fightId);
            if (this.fighterToRemoveId < 0)
            {
                throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element fighterToRemoveId.");
            }
            param1.writeInt(this.fighterToRemoveId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismFightAttackerRemoveMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismFightAttackerRemoveMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readDouble();
            this.fighterToRemoveId = param1.readInt();
            if (this.fighterToRemoveId < 0)
            {
                throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element of PrismFightAttackerRemoveMessage.fighterToRemoveId.");
            }
            return;
        }// end function

    }
}
