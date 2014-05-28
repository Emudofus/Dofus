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
      
      public function initHumanOptionAlliance(allianceInformations:AllianceInformations = null, aggressable:uint = 0) : HumanOptionAlliance {
         this.allianceInformations = allianceInformations;
         this.aggressable = aggressable;
         return this;
      }
      
      override public function reset() : void {
         this.allianceInformations = new AllianceInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanOptionAlliance(output);
      }
      
      public function serializeAs_HumanOptionAlliance(output:IDataOutput) : void {
         super.serializeAs_HumanOption(output);
         this.allianceInformations.serializeAs_AllianceInformations(output);
         output.writeByte(this.aggressable);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanOptionAlliance(input);
      }
      
      public function deserializeAs_HumanOptionAlliance(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceInformations = new AllianceInformations();
         this.allianceInformations.deserialize(input);
         this.aggressable = input.readByte();
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
