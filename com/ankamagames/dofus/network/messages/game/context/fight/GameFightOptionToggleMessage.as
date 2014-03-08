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
      
      public function initGameFightOptionToggleMessage(param1:uint=3) : GameFightOptionToggleMessage {
         this.option = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.option = 3;
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
         this.serializeAs_GameFightOptionToggleMessage(param1);
      }
      
      public function serializeAs_GameFightOptionToggleMessage(param1:IDataOutput) : void {
         param1.writeByte(this.option);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightOptionToggleMessage(param1);
      }
      
      public function deserializeAs_GameFightOptionToggleMessage(param1:IDataInput) : void {
         this.option = param1.readByte();
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
