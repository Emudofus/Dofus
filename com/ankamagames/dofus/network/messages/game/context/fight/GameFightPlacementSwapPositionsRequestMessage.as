package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameFightPlacementSwapPositionsRequestMessage extends GameFightPlacementPositionRequestMessage implements INetworkMessage
   {
      
      public function GameFightPlacementSwapPositionsRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6541;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var requestedId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6541;
      }
      
      public function initGameFightPlacementSwapPositionsRequestMessage(param1:uint = 0, param2:int = 0) : GameFightPlacementSwapPositionsRequestMessage
      {
         super.initGameFightPlacementPositionRequestMessage(param1);
         this.requestedId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.requestedId = 0;
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
         this.serializeAs_GameFightPlacementSwapPositionsRequestMessage(param1);
      }
      
      public function serializeAs_GameFightPlacementSwapPositionsRequestMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightPlacementPositionRequestMessage(param1);
         param1.writeInt(this.requestedId);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightPlacementSwapPositionsRequestMessage(param1);
      }
      
      public function deserializeAs_GameFightPlacementSwapPositionsRequestMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.requestedId = param1.readInt();
      }
   }
}
