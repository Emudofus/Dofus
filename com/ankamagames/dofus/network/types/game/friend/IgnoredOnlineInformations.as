package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   
   public class IgnoredOnlineInformations extends IgnoredInformations implements INetworkType
   {
      
      public function IgnoredOnlineInformations() {
         super();
      }
      
      public static const protocolId:uint = 105;
      
      public var playerId:uint = 0;
      
      public var playerName:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      override public function getTypeId() : uint {
         return 105;
      }
      
      public function initIgnoredOnlineInformations(accountId:uint = 0, accountName:String = "", playerId:uint = 0, playerName:String = "", breed:int = 0, sex:Boolean = false) : IgnoredOnlineInformations {
         super.initIgnoredInformations(accountId,accountName);
         this.playerId = playerId;
         this.playerName = playerName;
         this.breed = breed;
         this.sex = sex;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_IgnoredOnlineInformations(output);
      }
      
      public function serializeAs_IgnoredOnlineInformations(output:IDataOutput) : void {
         super.serializeAs_IgnoredInformations(output);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            output.writeUTF(this.playerName);
            output.writeByte(this.breed);
            output.writeBoolean(this.sex);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IgnoredOnlineInformations(input);
      }
      
      public function deserializeAs_IgnoredOnlineInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of IgnoredOnlineInformations.playerId.");
         }
         else
         {
            this.playerName = input.readUTF();
            this.breed = input.readByte();
            if((this.breed < PlayableBreedEnum.Feca) || (this.breed > PlayableBreedEnum.Steamer))
            {
               throw new Error("Forbidden value (" + this.breed + ") on element of IgnoredOnlineInformations.breed.");
            }
            else
            {
               this.sex = input.readBoolean();
               return;
            }
         }
      }
   }
}
