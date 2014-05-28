package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class MonsterInGroupLightInformations extends Object implements INetworkType
   {
      
      public function MonsterInGroupLightInformations() {
         super();
      }
      
      public static const protocolId:uint = 395;
      
      public var creatureGenericId:int = 0;
      
      public var grade:uint = 0;
      
      public function getTypeId() : uint {
         return 395;
      }
      
      public function initMonsterInGroupLightInformations(creatureGenericId:int = 0, grade:uint = 0) : MonsterInGroupLightInformations {
         this.creatureGenericId = creatureGenericId;
         this.grade = grade;
         return this;
      }
      
      public function reset() : void {
         this.creatureGenericId = 0;
         this.grade = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MonsterInGroupLightInformations(output);
      }
      
      public function serializeAs_MonsterInGroupLightInformations(output:IDataOutput) : void {
         output.writeInt(this.creatureGenericId);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            output.writeByte(this.grade);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MonsterInGroupLightInformations(input);
      }
      
      public function deserializeAs_MonsterInGroupLightInformations(input:IDataInput) : void {
         this.creatureGenericId = input.readInt();
         this.grade = input.readByte();
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of MonsterInGroupLightInformations.grade.");
         }
         else
         {
            return;
         }
      }
   }
}
