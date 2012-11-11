package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightSummonMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var summon:GameFightFighterInformations;
        public static const protocolId:uint = 5825;

        public function GameActionFightSummonMessage()
        {
            this.summon = new GameFightFighterInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5825;
        }// end function

        public function initGameActionFightSummonMessage(param1:uint = 0, param2:int = 0, param3:GameFightFighterInformations = null) : GameActionFightSummonMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.summon = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.summon = new GameFightFighterInformations();
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
            this.serializeAs_GameActionFightSummonMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightSummonMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeShort(this.summon.getTypeId());
            this.summon.serialize(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightSummonMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightSummonMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            this.summon = ProtocolTypeManager.getInstance(GameFightFighterInformations, _loc_2);
            this.summon.deserialize(param1);
            return;
        }// end function

    }
}
