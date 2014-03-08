package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpouseStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpouseStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6265;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var hasSpouse:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6265;
      }
      
      public function initSpouseStatusMessage(param1:Boolean=false) : SpouseStatusMessage {
         this.hasSpouse = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.hasSpouse = false;
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
         this.serializeAs_SpouseStatusMessage(param1);
      }
      
      public function serializeAs_SpouseStatusMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.hasSpouse);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SpouseStatusMessage(param1);
      }
      
      public function deserializeAs_SpouseStatusMessage(param1:IDataInput) : void {
         this.hasSpouse = param1.readBoolean();
      }
   }
}
