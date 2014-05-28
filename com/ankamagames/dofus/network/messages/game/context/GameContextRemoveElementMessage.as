package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextRemoveElementMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextRemoveElementMessage() {
         super();
      }
      
      public static const protocolId:uint = 251;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      override public function getMessageId() : uint {
         return 251;
      }
      
      public function initGameContextRemoveElementMessage(id:int = 0) : GameContextRemoveElementMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_GameContextRemoveElementMessage(output);
      }
      
      public function serializeAs_GameContextRemoveElementMessage(output:IDataOutput) : void {
         output.writeInt(this.id);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextRemoveElementMessage(input);
      }
      
      public function deserializeAs_GameContextRemoveElementMessage(input:IDataInput) : void {
         this.id = input.readInt();
      }
   }
}
