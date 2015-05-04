package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightPlacementSwapPositionsCancelledMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightPlacementSwapPositionsCancelledMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6546;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var requestId:uint = 0;
      
      public var cancellerId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6546;
      }
      
      public function initGameFightPlacementSwapPositionsCancelledMessage(param1:uint = 0, param2:uint = 0) : GameFightPlacementSwapPositionsCancelledMessage
      {
         this.requestId = param1;
         this.cancellerId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.requestId = 0;
         this.cancellerId = 0;
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
         this.serializeAs_GameFightPlacementSwapPositionsCancelledMessage(param1);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsCancelledMessage(param1:ICustomDataOutput) : void
      {
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element requestId.");
         }
         else
         {
            param1.writeInt(this.requestId);
            if(this.cancellerId < 0)
            {
               throw new Error("Forbidden value (" + this.cancellerId + ") on element cancellerId.");
            }
            else
            {
               param1.writeVarInt(this.cancellerId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsCancelledMessage(param1);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsCancelledMessage(param1:ICustomDataInput) : void
      {
         this.requestId = param1.readInt();
         if(this.requestId < 0)
         {
            throw new Error("Forbidden value (" + this.requestId + ") on element of GameFightPlacementSwapPositionsCancelledMessage.requestId.");
         }
         else
         {
            this.cancellerId = param1.readVarUhInt();
            if(this.cancellerId < 0)
            {
               throw new Error("Forbidden value (" + this.cancellerId + ") on element of GameFightPlacementSwapPositionsCancelledMessage.cancellerId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
