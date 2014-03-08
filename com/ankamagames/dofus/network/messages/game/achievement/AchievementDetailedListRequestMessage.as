package com.ankamagames.dofus.network.messages.game.achievement
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AchievementDetailedListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AchievementDetailedListRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6357;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var categoryId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6357;
      }
      
      public function initAchievementDetailedListRequestMessage(param1:uint=0) : AchievementDetailedListRequestMessage {
         this.categoryId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.categoryId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AchievementDetailedListRequestMessage(param1);
      }
      
      public function serializeAs_AchievementDetailedListRequestMessage(param1:IDataOutput) : void {
         if(this.categoryId < 0)
         {
            throw new Error("Forbidden value (" + this.categoryId + ") on element categoryId.");
         }
         else
         {
            param1.writeShort(this.categoryId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AchievementDetailedListRequestMessage(param1);
      }
      
      public function deserializeAs_AchievementDetailedListRequestMessage(param1:IDataInput) : void {
         this.categoryId = param1.readShort();
         if(this.categoryId < 0)
         {
            throw new Error("Forbidden value (" + this.categoryId + ") on element of AchievementDetailedListRequestMessage.categoryId.");
         }
         else
         {
            return;
         }
      }
   }
}
