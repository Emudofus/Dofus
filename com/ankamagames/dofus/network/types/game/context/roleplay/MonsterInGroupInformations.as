package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class MonsterInGroupInformations extends MonsterInGroupLightInformations implements INetworkType
   {
      
      public function MonsterInGroupInformations()
      {
         this.look = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 144;
      
      public var look:EntityLook;
      
      override public function getTypeId() : uint
      {
         return 144;
      }
      
      public function initMonsterInGroupInformations(param1:int = 0, param2:uint = 0, param3:EntityLook = null) : MonsterInGroupInformations
      {
         super.initMonsterInGroupLightInformations(param1,param2);
         this.look = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.look = new EntityLook();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_MonsterInGroupInformations(param1);
      }
      
      public function serializeAs_MonsterInGroupInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_MonsterInGroupLightInformations(param1);
         this.look.serializeAs_EntityLook(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_MonsterInGroupInformations(param1);
      }
      
      public function deserializeAs_MonsterInGroupInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.look = new EntityLook();
         this.look.deserialize(param1);
      }
   }
}
