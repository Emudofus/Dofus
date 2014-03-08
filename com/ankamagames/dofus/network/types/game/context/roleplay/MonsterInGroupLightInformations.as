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
      
      public function initMonsterInGroupLightInformations(param1:int=0, param2:uint=0) : MonsterInGroupLightInformations {
         this.creatureGenericId = param1;
         this.grade = param2;
         return this;
      }
      
      public function reset() : void {
         this.creatureGenericId = 0;
         this.grade = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_MonsterInGroupLightInformations(param1);
      }
      
      public function serializeAs_MonsterInGroupLightInformations(param1:IDataOutput) : void {
         param1.writeInt(this.creatureGenericId);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            param1.writeByte(this.grade);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MonsterInGroupLightInformations(param1);
      }
      
      public function deserializeAs_MonsterInGroupLightInformations(param1:IDataInput) : void {
         this.creatureGenericId = param1.readInt();
         this.grade = param1.readByte();
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
