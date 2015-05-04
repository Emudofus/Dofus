package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class BasicNamedAllianceInformations extends BasicAllianceInformations implements INetworkType
   {
      
      public function BasicNamedAllianceInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 418;
      
      public var allianceName:String = "";
      
      override public function getTypeId() : uint
      {
         return 418;
      }
      
      public function initBasicNamedAllianceInformations(param1:uint = 0, param2:String = "", param3:String = "") : BasicNamedAllianceInformations
      {
         super.initBasicAllianceInformations(param1,param2);
         this.allianceName = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceName = "";
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_BasicNamedAllianceInformations(param1);
      }
      
      public function serializeAs_BasicNamedAllianceInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_BasicAllianceInformations(param1);
         param1.writeUTF(this.allianceName);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_BasicNamedAllianceInformations(param1);
      }
      
      public function deserializeAs_BasicNamedAllianceInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.allianceName = param1.readUTF();
      }
   }
}
