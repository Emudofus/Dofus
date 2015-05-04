package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TreasureHuntFlagRequestAnswerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntFlagRequestAnswerMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6507;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var questType:uint = 0;
      
      public var result:uint = 0;
      
      public var index:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6507;
      }
      
      public function initTreasureHuntFlagRequestAnswerMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : TreasureHuntFlagRequestAnswerMessage
      {
         this.questType = param1;
         this.result = param2;
         this.index = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questType = 0;
         this.result = 0;
         this.index = 0;
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
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TreasureHuntFlagRequestAnswerMessage(param1);
      }
      
      public function serializeAs_TreasureHuntFlagRequestAnswerMessage(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.questType);
         param1.writeByte(this.result);
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         else
         {
            param1.writeByte(this.index);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntFlagRequestAnswerMessage(param1);
      }
      
      public function deserializeAs_TreasureHuntFlagRequestAnswerMessage(param1:ICustomDataInput) : void
      {
         this.questType = param1.readByte();
         if(this.questType < 0)
         {
            throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntFlagRequestAnswerMessage.questType.");
         }
         else
         {
            this.result = param1.readByte();
            if(this.result < 0)
            {
               throw new Error("Forbidden value (" + this.result + ") on element of TreasureHuntFlagRequestAnswerMessage.result.");
            }
            else
            {
               this.index = param1.readByte();
               if(this.index < 0)
               {
                  throw new Error("Forbidden value (" + this.index + ") on element of TreasureHuntFlagRequestAnswerMessage.index.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
