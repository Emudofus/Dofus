package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightLeaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightLeaveMessage() {
         super();
      }
      
      public static const protocolId:uint = 721;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var charId:int = 0;
      
      override public function getMessageId() : uint {
         return 721;
      }
      
      public function initGameFightLeaveMessage(charId:int=0) : GameFightLeaveMessage {
         this.charId = charId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.charId = 0;
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
         this.serializeAs_GameFightLeaveMessage(output);
      }
      
      public function serializeAs_GameFightLeaveMessage(output:IDataOutput) : void {
         output.writeInt(this.charId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightLeaveMessage(input);
      }
      
      public function deserializeAs_GameFightLeaveMessage(input:IDataInput) : void {
         this.charId = input.readInt();
      }
   }
}
