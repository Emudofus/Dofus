package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class BasicAllianceInformations extends AbstractSocialGroupInfos implements INetworkType
   {
      
      public function BasicAllianceInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 419;
      
      public var allianceId:uint = 0;
      
      public var allianceTag:String = "";
      
      override public function getTypeId() : uint
      {
         return 419;
      }
      
      public function initBasicAllianceInformations(param1:uint = 0, param2:String = "") : BasicAllianceInformations
      {
         this.allianceId = param1;
         this.allianceTag = param2;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceId = 0;
         this.allianceTag = "";
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_BasicAllianceInformations(param1);
      }
      
      public function serializeAs_BasicAllianceInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractSocialGroupInfos(param1);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            param1.writeVarInt(this.allianceId);
            param1.writeUTF(this.allianceTag);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_BasicAllianceInformations(param1);
      }
      
      public function deserializeAs_BasicAllianceInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.allianceId = param1.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of BasicAllianceInformations.allianceId.");
         }
         else
         {
            this.allianceTag = param1.readUTF();
            return;
         }
      }
   }
}
