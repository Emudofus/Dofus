package com.ankamagames.dofus.network.types.game.guild.tax
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorFightersInformation extends Object implements INetworkType
    {
        public var collectorId:int = 0;
        public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
        public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
        public static const protocolId:uint = 169;

        public function TaxCollectorFightersInformation()
        {
            this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>;
            this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 169;
        }// end function

        public function initTaxCollectorFightersInformation(param1:int = 0, param2:Vector.<CharacterMinimalPlusLookInformations> = null, param3:Vector.<CharacterMinimalPlusLookInformations> = null) : TaxCollectorFightersInformation
        {
            this.collectorId = param1;
            this.allyCharactersInformations = param2;
            this.enemyCharactersInformations = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.collectorId = 0;
            this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>;
            this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TaxCollectorFightersInformation(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorFightersInformation(param1:IDataOutput) : void
        {
            param1.writeInt(this.collectorId);
            param1.writeShort(this.allyCharactersInformations.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.allyCharactersInformations.length)
            {
                
                (this.allyCharactersInformations[_loc_2] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.enemyCharactersInformations.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.enemyCharactersInformations.length)
            {
                
                (this.enemyCharactersInformations[_loc_3] as CharacterMinimalPlusLookInformations).serializeAs_CharacterMinimalPlusLookInformations(param1);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorFightersInformation(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorFightersInformation(param1:IDataInput) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            this.collectorId = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new CharacterMinimalPlusLookInformations();
                _loc_6.deserialize(param1);
                this.allyCharactersInformations.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new CharacterMinimalPlusLookInformations();
                _loc_7.deserialize(param1);
                this.enemyCharactersInformations.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
