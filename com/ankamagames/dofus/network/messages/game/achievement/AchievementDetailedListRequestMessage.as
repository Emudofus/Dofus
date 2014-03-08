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
      
      public function initAchievementDetailedListRequestMessage(categoryId:uint=0) : AchievementDetailedListRequestMessage {
         this.categoryId = categoryId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.categoryId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AchievementDetailedListRequestMessage(output);
      }
      
      public function serializeAs_AchievementDetailedListRequestMessage(output:IDataOutput) : void {
         if(this.categoryId < 0)
         {
            throw new Error("Forbidden value (" + this.categoryId + ") on element categoryId.");
         }
         else
         {
            output.writeShort(this.categoryId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AchievementDetailedListRequestMessage(input);
      }
      
      public function deserializeAs_AchievementDetailedListRequestMessage(input:IDataInput) : void {
         this.categoryId = input.readShort();
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
