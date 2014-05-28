package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightOptionToggleMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightOptionToggleMessage() {
         super();
      }
      
      public static const protocolId:uint = 707;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var option:uint = 3;
      
      override public function getMessageId() : uint {
         return 707;
      }
      
      public function initGameFightOptionToggleMessage(option:uint = 3) : GameFightOptionToggleMessage {
         this.option = option;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.option = 3;
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
         this.serializeAs_GameFightOptionToggleMessage(output);
      }
      
      public function serializeAs_GameFightOptionToggleMessage(output:IDataOutput) : void {
         output.writeByte(this.option);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightOptionToggleMessage(input);
      }
      
      public function deserializeAs_GameFightOptionToggleMessage(input:IDataInput) : void {
         this.option = input.readByte();
         if(this.option < 0)
         {
            throw new Error("Forbidden value (" + this.option + ") on element of GameFightOptionToggleMessage.option.");
         }
         else
         {
            return;
         }
      }
   }
}
