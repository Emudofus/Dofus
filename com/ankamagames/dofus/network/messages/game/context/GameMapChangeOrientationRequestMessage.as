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
      
      public function initGameMapChangeOrientationRequestMessage(direction:uint = 1) : GameMapChangeOrientationRequestMessage {
         this.direction = direction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.direction = 1;
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
         this.serializeAs_GameMapChangeOrientationRequestMessage(output);
      }
      
      public function serializeAs_GameMapChangeOrientationRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.direction);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameMapChangeOrientationRequestMessage(input);
      }
      
      public function deserializeAs_GameMapChangeOrientationRequestMessage(input:IDataInput) : void {
         this.direction = input.readByte();
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
