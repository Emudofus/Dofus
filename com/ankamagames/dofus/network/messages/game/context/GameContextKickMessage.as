package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextKickMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextKickMessage() {
         super();
      }
      
      public static const protocolId:uint = 6081;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 6081;
      }
      
      public function initGameContextKickMessage(targetId:int = 0) : GameContextKickMessage {
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.targetId = 0;
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
         this.serializeAs_GameContextKickMessage(output);
      }
      
      public function serializeAs_GameContextKickMessage(output:IDataOutput) : void {
         output.writeInt(this.targetId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextKickMessage(input);
      }
      
      public function deserializeAs_GameContextKickMessage(input:IDataInput) : void {
         this.targetId = input.readInt();
      }
   }
}
