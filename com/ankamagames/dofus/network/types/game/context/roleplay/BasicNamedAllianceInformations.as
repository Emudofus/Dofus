package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class BasicNamedAllianceInformations extends BasicAllianceInformations implements INetworkType
   {
      
      public function BasicNamedAllianceInformations() {
         super();
      }
      
      public static const protocolId:uint = 418;
      
      public var allianceName:String = "";
      
      override public function getTypeId() : uint {
         return 418;
      }
      
      public function initBasicNamedAllianceInformations(allianceId:uint=0, allianceTag:String="", allianceName:String="") : BasicNamedAllianceInformations {
         super.initBasicAllianceInformations(allianceId,allianceTag);
         this.allianceName = allianceName;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allianceName = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      public function serializeAs_BasicNamedAllianceInformations(output:IDataOutput) : void {
         super.serializeAs_BasicAllianceInformations(output);
         output.writeUTF(this.allianceName);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicNamedAllianceInformations(input);
      }
      
      public function deserializeAs_BasicNamedAllianceInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceName = input.readUTF();
      }
   }
}
