package com.ankamagames.dofus.network.messages.game.prism
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismFightDefendersStateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:Number = 0;
        public var mainFighters:Vector.<CharacterMinimalPlusLookAndGradeInformations>;
        public var reserveFighters:Vector.<CharacterMinimalPlusLookAndGradeInformations>;
        public static const protocolId:uint = 5899;

        public function PrismFightDefendersStateMessage()
        {
            this.mainFighters = new Vector.<CharacterMinimalPlusLookAndGradeInformations>;
            this.reserveFighters = new Vector.<CharacterMinimalPlusLookAndGradeInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5899;
        }// end function

        public function initPrismFightDefendersStateMessage(param1:Number = 0, param2:Vector.<CharacterMinimalPlusLookAndGradeInformations> = null, param3:Vector.<CharacterMinimalPlusLookAndGradeInformations> = null) : PrismFightDefendersStateMessage
        {
            this.fightId = param1;
            this.mainFighters = param2;
            this.reserveFighters = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.mainFighters = new Vector.<CharacterMinimalPlusLookAndGradeInformations>;
            this.reserveFighters = new Vector.<CharacterMinimalPlusLookAndGradeInformations>;
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
            this.serializeAs_PrismFightDefendersStateMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismFightDefendersStateMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.fightId);
            param1.writeShort(this.mainFighters.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.mainFighters.length)
            {
                
                (this.mainFighters[_loc_2] as CharacterMinimalPlusLookAndGradeInformations).serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.reserveFighters.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.reserveFighters.length)
            {
                
                (this.reserveFighters[_loc_3] as CharacterMinimalPlusLookAndGradeInformations).serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismFightDefendersStateMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismFightDefendersStateMessage(param1:IDataInput) : void
        {
            var _loc_6:CharacterMinimalPlusLookAndGradeInformations = null;
            var _loc_7:CharacterMinimalPlusLookAndGradeInformations = null;
            this.fightId = param1.readDouble();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new CharacterMinimalPlusLookAndGradeInformations();
                _loc_6.deserialize(param1);
                this.mainFighters.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new CharacterMinimalPlusLookAndGradeInformations();
                _loc_7.deserialize(param1);
                this.reserveFighters.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
