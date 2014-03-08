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
      
      public function initGameFightLeaveMessage(param1:int=0) : GameFightLeaveMessage {
         this.charId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.charId = 0;
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
         this.serializeAs_GameFightLeaveMessage(param1);
      }
      
      public function serializeAs_GameFightLeaveMessage(param1:IDataOutput) : void {
         param1.writeInt(this.charId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightLeaveMessage(param1);
      }
      
      public function deserializeAs_GameFightLeaveMessage(param1:IDataInput) : void {
         this.charId = param1.readInt();
      }
   }
}
