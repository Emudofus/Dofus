package com.ankamagames.dofus.network.messages.game.prism
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismFightAttackerAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var charactersDescription:Vector.<CharacterMinimalPlusLookAndGradeInformations>;
        public static const protocolId:uint = 5893;

        public function PrismFightAttackerAddMessage()
        {
            this.charactersDescription = new Vector.<CharacterMinimalPlusLookAndGradeInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5893;
        }// end function

        public function initPrismFightAttackerAddMessage(param1:Number = 0, param2:Vector.<CharacterMinimalPlusLookAndGradeInformations> = null) : PrismFightAttackerAddMessage
        {
            this.fightId = param1;
            this.charactersDescription = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.charactersDescription = new Vector.<CharacterMinimalPlusLookAndGradeInformations>;
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
            this.serializeAs_PrismFightAttackerAddMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismFightAttackerAddMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.fightId);
            param1.writeShort(this.charactersDescription.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.charactersDescription.length)
            {
                
                (this.charactersDescription[_loc_2] as CharacterMinimalPlusLookAndGradeInformations).serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismFightAttackerAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismFightAttackerAddMessage(param1:IDataInput) : void
        {
            var _loc_4:CharacterMinimalPlusLookAndGradeInformations = null;
            this.fightId = param1.readDouble();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new CharacterMinimalPlusLookAndGradeInformations();
                _loc_4.deserialize(param1);
                this.charactersDescription.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
