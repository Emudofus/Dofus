package com.ankamagames.dofus.network.messages.game.context.fight.character
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightShowFighterMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var informations:GameFightFighterInformations;
        public static const protocolId:uint = 5864;

        public function GameFightShowFighterMessage()
        {
            this.informations = new GameFightFighterInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5864;
        }// end function

        public function initGameFightShowFighterMessage(param1:GameFightFighterInformations = null) : GameFightShowFighterMessage
        {
            this.informations = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.informations = new GameFightFighterInformations();
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
            this.serializeAs_GameFightShowFighterMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightShowFighterMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.informations.getTypeId());
            this.informations.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightShowFighterMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightShowFighterMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.informations = ProtocolTypeManager.getInstance(GameFightFighterInformations, _loc_2);
            this.informations.deserialize(param1);
            return;
        }// end function

    }
}
