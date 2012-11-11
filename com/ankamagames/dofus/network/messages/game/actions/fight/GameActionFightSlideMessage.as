package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightSlideMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var startCellId:int = 0;
        public var endCellId:int = 0;
        public static const protocolId:uint = 5525;

        public function GameActionFightSlideMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5525;
        }// end function

        public function initGameActionFightSlideMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0) : GameActionFightSlideMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.targetId = param3;
            this.startCellId = param4;
            this.endCellId = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.targetId = 0;
            this.startCellId = 0;
            this.endCellId = 0;
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
            this.serializeAs_GameActionFightSlideMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightSlideMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeInt(this.targetId);
            if (this.startCellId < -1 || this.startCellId > 559)
            {
                throw new Error("Forbidden value (" + this.startCellId + ") on element startCellId.");
            }
            param1.writeShort(this.startCellId);
            if (this.endCellId < -1 || this.endCellId > 559)
            {
                throw new Error("Forbidden value (" + this.endCellId + ") on element endCellId.");
            }
            param1.writeShort(this.endCellId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightSlideMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightSlideMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.targetId = param1.readInt();
            this.startCellId = param1.readShort();
            if (this.startCellId < -1 || this.startCellId > 559)
            {
                throw new Error("Forbidden value (" + this.startCellId + ") on element of GameActionFightSlideMessage.startCellId.");
            }
            this.endCellId = param1.readShort();
            if (this.endCellId < -1 || this.endCellId > 559)
            {
                throw new Error("Forbidden value (" + this.endCellId + ") on element of GameActionFightSlideMessage.endCellId.");
            }
            return;
        }// end function

    }
}
