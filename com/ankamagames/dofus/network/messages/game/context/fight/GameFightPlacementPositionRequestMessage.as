package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightPlacementPositionRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightPlacementPositionRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 704;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var cellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 704;
      }
      
      public function initGameFightPlacementPositionRequestMessage(param1:uint=0) : GameFightPlacementPositionRequestMessage {
         this.cellId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.cellId = 0;
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
         this.serializeAs_GameFightPlacementPositionRequestMessage(param1);
      }
      
      public function serializeAs_GameFightPlacementPositionRequestMessage(param1:IDataOutput) : void {
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            param1.writeShort(this.cellId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightPlacementPositionRequestMessage(param1);
      }
      
      public function deserializeAs_GameFightPlacementPositionRequestMessage(param1:IDataInput) : void {
         this.cellId = param1.readShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of GameFightPlacementPositionRequestMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }
}
