package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class BasicAllianceInformations extends AbstractSocialGroupInfos implements INetworkType
   {
      
      public function BasicAllianceInformations() {
         super();
      }
      
      public static const protocolId:uint = 419;
      
      public var allianceId:uint = 0;
      
      public var allianceTag:String = "";
      
      override public function getTypeId() : uint {
         return 419;
      }
      
      public function initBasicAllianceInformations(allianceId:uint = 0, allianceTag:String = "") : BasicAllianceInformations {
         this.allianceId = allianceId;
         this.allianceTag = allianceTag;
         return this;
      }
      
      override public function reset() : void {
         this.allianceId = 0;
         this.allianceTag = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_BasicAllianceInformations(output);
      }
      
      public function serializeAs_BasicAllianceInformations(output:IDataOutput) : void {
         super.serializeAs_AbstractSocialGroupInfos(output);
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            output.writeInt(this.allianceId);
            output.writeUTF(this.allianceTag);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicAllianceInformations(input);
      }
      
      public function deserializeAs_BasicAllianceInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.allianceId = input.readInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of BasicAllianceInformations.allianceId.");
         }
         else
         {
            this.allianceTag = input.readUTF();
            return;
         }
      }
   }
}
