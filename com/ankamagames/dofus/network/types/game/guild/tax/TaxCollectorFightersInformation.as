package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class TaxCollectorFightersInformation extends Object implements INetworkType
   {
      
      public function TaxCollectorFightersInformation() {
         this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         super();
      }
      
      public static const protocolId:uint = 169;
      
      public var collectorId:int = 0;
      
      public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      public function getTypeId() : uint {
         return 169;
      }
      
      public function initTaxCollectorFightersInformation(collectorId:int = 0, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null) : TaxCollectorFightersInformation {
         this.collectorId = collectorId;
         this.allyCharactersInformations = allyCharactersInformations;
         this.enemyCharactersInformations = enemyCharactersInformations;
         return this;
      }
      
      public function reset() : void {
         this.collectorId = 0;
         this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_TaxCollectorFightersInformation(output);
      }
      
      public function serializeAs_TaxCollectorFightersInformation(output:IDataOutput) : void {
         output.writeInt(this.collectorId);
         output.writeShort(this.allyCharactersInformations.length);
         var _i2:uint = 0;
         while(_i2 < this.allyCharactersInformations.length)
         {
            output.writeShort((this.allyCharactersInformations[_i2] as CharacterMinimalPlusLookInformations).getTypeId());
            (this.allyCharactersInformations[_i2] as CharacterMinimalPlusLookInformations).serialize(output);
            _i2++;
         }
         output.writeShort(this.enemyCharactersInformations.length);
         var _i3:uint = 0;
         while(_i3 < this.enemyCharactersInformations.length)
         {
            output.writeShort((this.enemyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).getTypeId());
            (this.enemyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).serialize(output);
            _i3++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorFightersInformation(input);
      }
      
      public function deserializeAs_TaxCollectorFightersInformation(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:CharacterMinimalPlusLookInformations = null;
         var _id3:uint = 0;
         var _item3:CharacterMinimalPlusLookInformations = null;
         this.collectorId = input.readInt();
         var _allyCharactersInformationsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _allyCharactersInformationsLen)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id2);
            _item2.deserialize(input);
            this.allyCharactersInformations.push(_item2);
            _i2++;
         }
         var _enemyCharactersInformationsLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _enemyCharactersInformationsLen)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id3);
            _item3.deserialize(input);
            this.enemyCharactersInformations.push(_item3);
            _i3++;
         }
      }
   }
}
