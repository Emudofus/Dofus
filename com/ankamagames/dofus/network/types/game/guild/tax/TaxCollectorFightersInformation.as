package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import __AS3__.vec.*;
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
      
      public function initTaxCollectorFightersInformation(collectorId:int=0, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>=null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>=null) : TaxCollectorFightersInformation {
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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorFightersInformation(input);
      }
      
      public function deserializeAs_TaxCollectorFightersInformation(input:IDataInput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
