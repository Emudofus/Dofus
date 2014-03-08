package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AllianceFactSheetInformations extends AllianceInformations implements INetworkType
   {
      
      public function AllianceFactSheetInformations() {
         super();
      }
      
      public static const protocolId:uint = 421;
      
      public var creationDate:uint = 0;
      
      override public function getTypeId() : uint {
         return 421;
      }
      
      public function initAllianceFactSheetInformations(param1:uint=0, param2:String="", param3:String="", param4:GuildEmblem=null, param5:uint=0) : AllianceFactSheetInformations {
         super.initAllianceInformations(param1,param2,param3,param4);
         this.creationDate = param5;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.creationDate = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AllianceFactSheetInformations(param1);
      }
      
      public function serializeAs_AllianceFactSheetInformations(param1:IDataOutput) : void {
         super.serializeAs_AllianceInformations(param1);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         else
         {
            param1.writeInt(this.creationDate);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceFactSheetInformations(param1);
      }
      
      public function deserializeAs_AllianceFactSheetInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.creationDate = param1.readInt();
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of AllianceFactSheetInformations.creationDate.");
         }
         else
         {
            return;
         }
      }
   }
}
