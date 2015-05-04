package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameCautiousMapMovementRequestMessage extends GameMapMovementRequestMessage implements INetworkMessage
   {
      
      public function GameCautiousMapMovementRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6496;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint
      {
         return 6496;
      }
      
      public function initGameCautiousMapMovementRequestMessage(param1:Vector.<uint> = null, param2:uint = 0) : GameCautiousMapMovementRequestMessage
      {
         super.initGameMapMovementRequestMessage(param1,param2);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(_loc2_);
         }
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameCautiousMapMovementRequestMessage(param1);
      }
      
      public function serializeAs_GameCautiousMapMovementRequestMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_GameMapMovementRequestMessage(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameCautiousMapMovementRequestMessage(param1);
      }
      
      public function deserializeAs_GameCautiousMapMovementRequestMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
