package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismFightDefendersSwapMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var fighterId1:uint = 0;
        public var fighterId2:uint = 0;
        public static const protocolId:uint = 5902;

        public function PrismFightDefendersSwapMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5902;
        }// end function

        public function initPrismFightDefendersSwapMessage(param1:Number = 0, param2:uint = 0, param3:uint = 0) : PrismFightDefendersSwapMessage
        {
            this.fightId = param1;
            this.fighterId1 = param2;
            this.fighterId2 = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.fighterId1 = 0;
            this.fighterId2 = 0;
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
            this.serializeAs_PrismFightDefendersSwapMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismFightDefendersSwapMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.fightId);
            if (this.fighterId1 < 0)
            {
                throw new Error("Forbidden value (" + this.fighterId1 + ") on element fighterId1.");
            }
            param1.writeInt(this.fighterId1);
            if (this.fighterId2 < 0)
            {
                throw new Error("Forbidden value (" + this.fighterId2 + ") on element fighterId2.");
            }
            param1.writeInt(this.fighterId2);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismFightDefendersSwapMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismFightDefendersSwapMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readDouble();
            this.fighterId1 = param1.readInt();
            if (this.fighterId1 < 0)
            {
                throw new Error("Forbidden value (" + this.fighterId1 + ") on element of PrismFightDefendersSwapMessage.fighterId1.");
            }
            this.fighterId2 = param1.readInt();
            if (this.fighterId2 < 0)
            {
                throw new Error("Forbidden value (" + this.fighterId2 + ") on element of PrismFightDefendersSwapMessage.fighterId2.");
            }
            return;
        }// end function

    }
}
