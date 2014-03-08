package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class MonsterInGroupInformations extends MonsterInGroupLightInformations implements INetworkType
   {
      
      public function MonsterInGroupInformations() {
         this.look = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 144;
      
      public var look:EntityLook;
      
      override public function getTypeId() : uint {
         return 144;
      }
      
      public function initMonsterInGroupInformations(creatureGenericId:int=0, grade:uint=0, look:EntityLook=null) : MonsterInGroupInformations {
         super.initMonsterInGroupLightInformations(creatureGenericId,grade);
         this.look = look;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.look = new EntityLook();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_MonsterInGroupInformations(output);
      }
      
      public function serializeAs_MonsterInGroupInformations(output:IDataOutput) : void {
         super.serializeAs_MonsterInGroupLightInformations(output);
         this.look.serializeAs_EntityLook(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MonsterInGroupInformations(input);
      }
      
      public function deserializeAs_MonsterInGroupInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
   }
}
