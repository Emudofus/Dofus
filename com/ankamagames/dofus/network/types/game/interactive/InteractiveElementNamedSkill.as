package com.ankamagames.dofus.network.types.game.interactive
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class InteractiveElementNamedSkill extends InteractiveElementSkill implements INetworkType
   {
      
      public function InteractiveElementNamedSkill()
      {
         super();
      }
      
      public static const protocolId:uint = 220;
      
      public var nameId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 220;
      }
      
      public function initInteractiveElementNamedSkill(param1:uint = 0, param2:uint = 0, param3:uint = 0) : InteractiveElementNamedSkill
      {
         super.initInteractiveElementSkill(param1,param2);
         this.nameId = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.nameId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_InteractiveElementNamedSkill(param1);
      }
      
      public function serializeAs_InteractiveElementNamedSkill(param1:ICustomDataOutput) : void
      {
         super.serializeAs_InteractiveElementSkill(param1);
         if(this.nameId < 0)
         {
            throw new Error("Forbidden value (" + this.nameId + ") on element nameId.");
         }
         else
         {
            param1.writeVarInt(this.nameId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveElementNamedSkill(param1);
      }
      
      public function deserializeAs_InteractiveElementNamedSkill(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.nameId = param1.readVarUhInt();
         if(this.nameId < 0)
         {
            throw new Error("Forbidden value (" + this.nameId + ") on element of InteractiveElementNamedSkill.nameId.");
         }
         else
         {
            return;
         }
      }
   }
}
