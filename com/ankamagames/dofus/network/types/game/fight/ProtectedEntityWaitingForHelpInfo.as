package com.ankamagames.dofus.network.types.game.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ProtectedEntityWaitingForHelpInfo extends Object implements INetworkType
   {
      
      public function ProtectedEntityWaitingForHelpInfo()
      {
         super();
      }
      
      public static const protocolId:uint = 186;
      
      public var timeLeftBeforeFight:int = 0;
      
      public var waitTimeForPlacement:int = 0;
      
      public var nbPositionForDefensors:uint = 0;
      
      public function getTypeId() : uint
      {
         return 186;
      }
      
      public function initProtectedEntityWaitingForHelpInfo(param1:int = 0, param2:int = 0, param3:uint = 0) : ProtectedEntityWaitingForHelpInfo
      {
         this.timeLeftBeforeFight = param1;
         this.waitTimeForPlacement = param2;
         this.nbPositionForDefensors = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.timeLeftBeforeFight = 0;
         this.waitTimeForPlacement = 0;
         this.nbPositionForDefensors = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ProtectedEntityWaitingForHelpInfo(param1);
      }
      
      public function serializeAs_ProtectedEntityWaitingForHelpInfo(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.timeLeftBeforeFight);
         param1.writeInt(this.waitTimeForPlacement);
         if(this.nbPositionForDefensors < 0)
         {
            throw new Error("Forbidden value (" + this.nbPositionForDefensors + ") on element nbPositionForDefensors.");
         }
         else
         {
            param1.writeByte(this.nbPositionForDefensors);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ProtectedEntityWaitingForHelpInfo(param1);
      }
      
      public function deserializeAs_ProtectedEntityWaitingForHelpInfo(param1:ICustomDataInput) : void
      {
         this.timeLeftBeforeFight = param1.readInt();
         this.waitTimeForPlacement = param1.readInt();
         this.nbPositionForDefensors = param1.readByte();
         if(this.nbPositionForDefensors < 0)
         {
            throw new Error("Forbidden value (" + this.nbPositionForDefensors + ") on element of ProtectedEntityWaitingForHelpInfo.nbPositionForDefensors.");
         }
         else
         {
            return;
         }
      }
   }
}
