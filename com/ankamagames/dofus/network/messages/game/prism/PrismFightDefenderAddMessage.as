package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var fighterMovementInformations:CharacterMinimalPlusLookAndGradeInformations;
        public var inMain:Boolean = false;
        public static const protocolId:uint = 5895;

        public function PrismFightDefenderAddMessage()
        {
            this.fighterMovementInformations = new CharacterMinimalPlusLookAndGradeInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5895;
        }// end function

        public function initPrismFightDefenderAddMessage(param1:Number = 0, param2:CharacterMinimalPlusLookAndGradeInformations = null, param3:Boolean = false) : PrismFightDefenderAddMessage
        {
            this.fightId = param1;
            this.fighterMovementInformations = param2;
            this.inMain = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.fighterMovementInformations = new CharacterMinimalPlusLookAndGradeInformations();
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
            this.serializeAs_PrismFightDefenderAddMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismFightDefenderAddMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.fightId);
            this.fighterMovementInformations.serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
            param1.writeBoolean(this.inMain);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismFightDefenderAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismFightDefenderAddMessage(param1:IDataInput) : void
        {
            this.fightId = param1.readDouble();
            this.fighterMovementInformations = new CharacterMinimalPlusLookAndGradeInformations();
            this.fighterMovementInformations.deserialize(param1);
            this.inMain = param1.readBoolean();
            return;
        }// end function

    }
}
