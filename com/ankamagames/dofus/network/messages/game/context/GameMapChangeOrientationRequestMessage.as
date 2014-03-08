package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameMapChangeOrientationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameMapChangeOrientationRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 945;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var direction:uint = 1;
      
      override public function getMessageId() : uint {
         return 945;
      }
      
      public function initGameMapChangeOrientationRequestMessage(param1:uint=1) : GameMapChangeOrientationRequestMessage {
         this.direction = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.direction = 1;
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
         this.serializeAs_GameMapChangeOrientationRequestMessage(param1);
      }
      
      public function serializeAs_GameMapChangeOrientationRequestMessage(param1:IDataOutput) : void {
         param1.writeByte(this.direction);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameMapChangeOrientationRequestMessage(param1);
      }
      
      public function deserializeAs_GameMapChangeOrientationRequestMessage(param1:IDataInput) : void {
         this.direction = param1.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of GameMapChangeOrientationRequestMessage.direction.");
         }
         else
         {
            return;
         }
      }
   }
}
