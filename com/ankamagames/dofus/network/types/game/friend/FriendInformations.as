package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FriendInformations extends AbstractContactInformations implements INetworkType
   {
      
      public function FriendInformations() {
         super();
      }
      
      public static const protocolId:uint = 78;
      
      public var playerState:uint = 99;
      
      public var lastConnection:uint = 0;
      
      public var achievementPoints:int = 0;
      
      override public function getTypeId() : uint {
         return 78;
      }
      
      public function initFriendInformations(param1:uint=0, param2:String="", param3:uint=99, param4:uint=0, param5:int=0) : FriendInformations {
         super.initAbstractContactInformations(param1,param2);
         this.playerState = param3;
         this.lastConnection = param4;
         this.achievementPoints = param5;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerState = 99;
         this.lastConnection = 0;
         this.achievementPoints = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FriendInformations(param1);
      }
      
      public function serializeAs_FriendInformations(param1:IDataOutput) : void {
         super.serializeAs_AbstractContactInformations(param1);
         param1.writeByte(this.playerState);
         if(this.lastConnection < 0)
         {
            throw new Error("Forbidden value (" + this.lastConnection + ") on element lastConnection.");
         }
         else
         {
            param1.writeInt(this.lastConnection);
            param1.writeInt(this.achievementPoints);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FriendInformations(param1);
      }
      
      public function deserializeAs_FriendInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.playerState = param1.readByte();
         if(this.playerState < 0)
         {
            throw new Error("Forbidden value (" + this.playerState + ") on element of FriendInformations.playerState.");
         }
         else
         {
            this.lastConnection = param1.readInt();
            if(this.lastConnection < 0)
            {
               throw new Error("Forbidden value (" + this.lastConnection + ") on element of FriendInformations.lastConnection.");
            }
            else
            {
               this.achievementPoints = param1.readInt();
               return;
            }
         }
      }
   }
}
