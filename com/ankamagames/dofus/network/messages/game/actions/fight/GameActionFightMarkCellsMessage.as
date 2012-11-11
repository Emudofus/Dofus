package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightMarkCellsMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mark:GameActionMark;
        public static const protocolId:uint = 5540;

        public function GameActionFightMarkCellsMessage()
        {
            this.mark = new GameActionMark();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5540;
        }// end function

        public function initGameActionFightMarkCellsMessage(param1:uint = 0, param2:int = 0, param3:GameActionMark = null) : GameActionFightMarkCellsMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.mark = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.mark = new GameActionMark();
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
            this.serializeAs_GameActionFightMarkCellsMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightMarkCellsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            this.mark.serializeAs_GameActionMark(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightMarkCellsMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightMarkCellsMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.mark = new GameActionMark();
            this.mark.deserialize(param1);
            return;
        }// end function

    }
}
