package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PortalInformation extends Object implements INetworkType
   {
      
      public function PortalInformation()
      {
         super();
      }
      
      public static const protocolId:uint = 466;
      
      public var portalId:uint = 0;
      
      public var areaId:int = 0;
      
      public function getTypeId() : uint
      {
         return 466;
      }
      
      public function initPortalInformation(param1:uint = 0, param2:int = 0) : PortalInformation
      {
         this.portalId = param1;
         this.areaId = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.portalId = 0;
         this.areaId = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PortalInformation(param1);
      }
      
      public function serializeAs_PortalInformation(param1:ICustomDataOutput) : void
      {
         if(this.portalId < 0)
         {
            throw new Error("Forbidden value (" + this.portalId + ") on element portalId.");
         }
         else
         {
            param1.writeVarShort(this.portalId);
            param1.writeShort(this.areaId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PortalInformation(param1);
      }
      
      public function deserializeAs_PortalInformation(param1:ICustomDataInput) : void
      {
         this.portalId = param1.readVarUhShort();
         if(this.portalId < 0)
         {
            throw new Error("Forbidden value (" + this.portalId + ") on element of PortalInformation.portalId.");
         }
         else
         {
            this.areaId = param1.readShort();
            return;
         }
      }
   }
}
