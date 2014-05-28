package com.ankamagames.dofus.network.types.game.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ProtectedEntityWaitingForHelpInfo extends Object implements INetworkType
   {
      
      public function ProtectedEntityWaitingForHelpInfo() {
         super();
      }
      
      public static const protocolId:uint = 186;
      
      public var timeLeftBeforeFight:int = 0;
      
      public var waitTimeForPlacement:int = 0;
      
      public var nbPositionForDefensors:uint = 0;
      
      public function getTypeId() : uint {
         return 186;
      }
      
      public function initProtectedEntityWaitingForHelpInfo(timeLeftBeforeFight:int = 0, waitTimeForPlacement:int = 0, nbPositionForDefensors:uint = 0) : ProtectedEntityWaitingForHelpInfo {
         this.timeLeftBeforeFight = timeLeftBeforeFight;
         this.waitTimeForPlacement = waitTimeForPlacement;
         this.nbPositionForDefensors = nbPositionForDefensors;
         return this;
      }
      
      public function reset() : void {
         this.timeLeftBeforeFight = 0;
         this.waitTimeForPlacement = 0;
         this.nbPositionForDefensors = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
      }
      
      public function serializeAs_ProtectedEntityWaitingForHelpInfo(output:IDataOutput) : void {
         output.writeInt(this.timeLeftBeforeFight);
         output.writeInt(this.waitTimeForPlacement);
         if(this.nbPositionForDefensors < 0)
         {
            throw new Error("Forbidden value (" + this.nbPositionForDefensors + ") on element nbPositionForDefensors.");
         }
         else
         {
            output.writeByte(this.nbPositionForDefensors);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ProtectedEntityWaitingForHelpInfo(input);
      }
      
      public function deserializeAs_ProtectedEntityWaitingForHelpInfo(input:IDataInput) : void {
         this.timeLeftBeforeFight = input.readInt();
         this.waitTimeForPlacement = input.readInt();
         this.nbPositionForDefensors = input.readByte();
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
