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
      
      public function initAllianceFactSheetInformations(allianceId:uint = 0, allianceTag:String = "", allianceName:String = "", allianceEmblem:GuildEmblem = null, creationDate:uint = 0) : AllianceFactSheetInformations {
         super.initAllianceInformations(allianceId,allianceTag,allianceName,allianceEmblem);
         this.creationDate = creationDate;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.creationDate = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AllianceFactSheetInformations(output);
      }
      
      public function serializeAs_AllianceFactSheetInformations(output:IDataOutput) : void {
         super.serializeAs_AllianceInformations(output);
         if(this.creationDate < 0)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         else
         {
            output.writeInt(this.creationDate);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceFactSheetInformations(input);
      }
      
      public function deserializeAs_AllianceFactSheetInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.creationDate = input.readInt();
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
