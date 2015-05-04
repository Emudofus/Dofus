package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AchievementFinishedInformationMessage extends AchievementFinishedMessage implements INetworkMessage
   {
      
      public function AchievementFinishedInformationMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6381;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var name:String = "";
      
      public var playerId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6381;
      }
      
      public function initAchievementFinishedInformationMessage(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0) : AchievementFinishedInformationMessage
      {
         super.initAchievementFinishedMessage(param1,param2);
         this.name = param3;
         this.playerId = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.playerId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AchievementFinishedInformationMessage(param1);
      }
      
      public function serializeAs_AchievementFinishedInformationMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AchievementFinishedMessage(param1);
         param1.writeUTF(this.name);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeVarInt(this.playerId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AchievementFinishedInformationMessage(param1);
      }
      
      public function deserializeAs_AchievementFinishedInformationMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.name = param1.readUTF();
         this.playerId = param1.readVarUhInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AchievementFinishedInformationMessage.playerId.");
         }
         else
         {
            return;
         }
      }
   }
}
