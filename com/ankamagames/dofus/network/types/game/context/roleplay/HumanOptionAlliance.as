package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionAlliance extends HumanOption implements INetworkType
   {
      
      public function HumanOptionAlliance() {
         this.allianceInformations = new AllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 425;
      
      public var allianceInformations:AllianceInformations;
      
      public var aggressable:uint = 0;
      
      override public function getTypeId() : uint {
         return 425;
      }
      
      public function initHumanOptionAlliance(param1:AllianceInformations=null, param2:uint=0) : HumanOptionAlliance {
         this.allianceInformations = param1;
         this.aggressable = param2;
         return this;
      }
      
      override public function reset() : void {
         this.allianceInformations = new AllianceInformations();
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HumanOptionAlliance(param1);
      }
      
      public function serializeAs_HumanOptionAlliance(param1:IDataOutput) : void {
         super.serializeAs_HumanOption(param1);
         this.allianceInformations.serializeAs_AllianceInformations(param1);
         param1.writeByte(this.aggressable);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HumanOptionAlliance(param1);
      }
      
      public function deserializeAs_HumanOptionAlliance(param1:IDataInput) : void {
         super.deserialize(param1);
         this.allianceInformations = new AllianceInformations();
         this.allianceInformations.deserialize(param1);
         this.aggressable = param1.readByte();
         if(this.aggressable < 0)
         {
            throw new Error("Forbidden value (" + this.aggressable + ") on element of HumanOptionAlliance.aggressable.");
         }
         else
         {
            return;
         }
      }
   }
}
