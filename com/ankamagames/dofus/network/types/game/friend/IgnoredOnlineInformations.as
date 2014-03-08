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
      
      public function initIgnoredOnlineInformations(param1:uint=0, param2:String="", param3:uint=0, param4:String="", param5:int=0, param6:Boolean=false) : IgnoredOnlineInformations {
         super.initIgnoredInformations(param1,param2);
         this.playerId = param3;
         this.playerName = param4;
         this.breed = param5;
         this.sex = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerId = 0;
         this.playerName = "";
         this.breed = 0;
         this.sex = false;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_IgnoredOnlineInformations(param1);
      }
      
      public function serializeAs_IgnoredOnlineInformations(param1:IDataOutput) : void {
         super.serializeAs_IgnoredInformations(param1);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            param1.writeUTF(this.playerName);
            param1.writeByte(this.breed);
            param1.writeBoolean(this.sex);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IgnoredOnlineInformations(param1);
      }
      
      public function deserializeAs_IgnoredOnlineInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of IgnoredOnlineInformations.playerId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            this.breed = param1.readByte();
            if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Steamer)
            {
               throw new Error("Forbidden value (" + this.breed + ") on element of IgnoredOnlineInformations.breed.");
            }
            else
            {
               this.sex = param1.readBoolean();
               return;
            }
         }
      }
   }
}
