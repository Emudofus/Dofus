package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class HumanOptionOrnament extends HumanOption implements INetworkType
   {
      
      public function HumanOptionOrnament()
      {
         super();
      }
      
      public static const protocolId:uint = 411;
      
      public var ornamentId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 411;
      }
      
      public function initHumanOptionOrnament(param1:uint = 0) : HumanOptionOrnament
      {
         this.ornamentId = param1;
         return this;
      }
      
      override public function reset() : void
      {
         this.ornamentId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_HumanOptionOrnament(param1);
      }
      
      public function serializeAs_HumanOptionOrnament(param1:ICustomDataOutput) : void
      {
         super.serializeAs_HumanOption(param1);
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
         }
         else
         {
            param1.writeVarShort(this.ornamentId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_HumanOptionOrnament(param1);
      }
      
      public function deserializeAs_HumanOptionOrnament(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.ornamentId = param1.readVarUhShort();
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element of HumanOptionOrnament.ornamentId.");
         }
         else
         {
            return;
         }
      }
   }
}
