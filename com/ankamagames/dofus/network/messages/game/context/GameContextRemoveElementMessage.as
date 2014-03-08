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
      
      public function initGameContextRemoveElementMessage(param1:int=0) : GameContextRemoveElementMessage {
         this.id = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_GameContextRemoveElementMessage(param1);
      }
      
      public function serializeAs_GameContextRemoveElementMessage(param1:IDataOutput) : void {
         param1.writeInt(this.id);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameContextRemoveElementMessage(param1);
      }
      
      public function deserializeAs_GameContextRemoveElementMessage(param1:IDataInput) : void {
         this.id = param1.readInt();
      }
   }
}
