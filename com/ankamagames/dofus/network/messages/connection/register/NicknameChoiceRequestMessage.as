package com.ankamagames.dofus.network.messages.connection.register
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NicknameChoiceRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NicknameChoiceRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5639;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var nickname:String = "";
      
      override public function getMessageId() : uint {
         return 5639;
      }
      
      public function initNicknameChoiceRequestMessage(param1:String="") : NicknameChoiceRequestMessage {
         this.nickname = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nickname = "";
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
         this.serializeAs_NicknameChoiceRequestMessage(param1);
      }
      
      public function serializeAs_NicknameChoiceRequestMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.nickname);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NicknameChoiceRequestMessage(param1);
      }
      
      public function deserializeAs_NicknameChoiceRequestMessage(param1:IDataInput) : void {
         this.nickname = param1.readUTF();
      }
   }
}
