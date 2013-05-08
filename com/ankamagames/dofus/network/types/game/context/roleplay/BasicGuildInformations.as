package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class BasicGuildInformations extends Object implements INetworkType
   {
         

      public function BasicGuildInformations() {
         super();
      }

      public static const protocolId:uint = 365;

      public var guildId:uint = 0;

      public var guildName:String = "";

      public function getTypeId() : uint {
         return 365;
      }

      public function initBasicGuildInformations(guildId:uint=0, guildName:String="") : BasicGuildInformations {
         this.guildId=guildId;
         this.guildName=guildName;
         return this;
      }

      public function reset() : void {
         this.guildId=0;
         this.guildName="";
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_BasicGuildInformations(output);
      }

      public function serializeAs_BasicGuildInformations(output:IDataOutput) : void {
         if(this.guildId<0)
         {
            throw new Error("Forbidden value ("+this.guildId+") on element guildId.");
         }
         else
         {
            output.writeInt(this.guildId);
            output.writeUTF(this.guildName);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicGuildInformations(input);
      }

      public function deserializeAs_BasicGuildInformations(input:IDataInput) : void {
         this.guildId=input.readInt();
         if(this.guildId<0)
         {
            throw new Error("Forbidden value ("+this.guildId+") on element of BasicGuildInformations.guildId.");
         }
         else
         {
            this.guildName=input.readUTF();
            return;
         }
      }
   }

}